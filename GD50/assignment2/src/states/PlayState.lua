--[[
    GD50
    Breakout Remake

    -- PlayState Class --

    Author: Colton Ogden
    cogden@cs50.harvard.edu

    Represents the state of the game in which we are actively playing;
    player should control the paddle, with the ball actively bouncing between
    the bricks, walls, and the paddle. If the ball goes below the paddle, then
    the player should lose one point of health and be taken either to the Game
    Over screen if at 0 health or the Serve screen otherwise.
]]

PlayState = Class{__includes = BaseState}
Score_Tracker = 0
--[[
    We initialize what's in our PlayState via a state table that we pass between
    states as we go from playing to serving.
]]
function PlayState:enter(params)
    self.paddle = params.paddle
    self.bricks = params.bricks
    self.health = params.health
    self.score = params.score
    self.highScores = params.highScores
    self.ball = params.ball
    self.level = params.level
    self.powerup = Powerup()
    self.powerup.skin = math.random(1,9)
    self.powerup2 = Powerup()
    self.powerup2.skin = 10
    
    timer= 0
    
    self.recoverPoints = 5000
    update = false
    
    brick_hit_counter = 0
    upgraded = true
    self.ball2 = Ball()
    self.ball3 = Ball()

    self.ball2.skin = math.random(7)
    self.ball3.skin = math.random(7)
    self.ball2.x = VIRTUAL_WIDTH / 2 
    self.ball3.x = VIRTUAL_WIDTH / 2 
    self.ball2.y = VIRTUAL_HEIGHT - 60
    self.ball3.y = VIRTUAL_HEIGHT - 60
    self.ball2.dx = math.random(-200, 200)
    self.ball2.dy = -50
    self.ball3.dx = math.random(-200, 200)
    self.ball3.dy = -50
    -- give ball random starting velocity
    self.ball.dx = math.random(-200, 200)
    self.ball.dy = math.random(-50, -60)
    balls = {}
    balls[0] = self.ball
    balls[1] = self.ball2
    balls[2] = self.ball3
end

randTime = math.random(3)
randTime2 = math.random(15,30)
function PlayState:update(dt)
    timer = timer + dt
    if timer > randTime2 and keyNeeded then
        self.powerup2:update(dt)
        
    end

    

    if timer > randTime then

        self.powerup:update(dt)
        
    end

    if self.paused then
        if love.keyboard.wasPressed('space') then
            self.paused = false
            gSounds['pause']:play()
        else
            return
        end
    elseif love.keyboard.wasPressed('space') then
        self.paused = true
        gSounds['pause']:play()
        return
    end



    -- update positions based on velocity
    self.paddle:update(dt)
    self.ball:update(dt)
    
    if self.powerup:collides(self.paddle) then
        self.powerup.inPlay = false
        update = true
    end
    
    if self.powerup2:collides(self.paddle) then 
        self.powerup2.inPlay = false
        power_activate = true
    end

    
    if update then
        self.ball2:update(dt)
        self.ball3:update(dt)
    end

    

    for j, ball in pairs(balls) do
        if ball:collides(self.paddle) then
            -- raise ball above paddle in case it goes below it, then reverse dy
            ball.y = self.paddle.y - 8
            ball.dy = -ball.dy

            --
            -- tweak angle of bounce based on where it hits the paddle
            --

            -- if we hit the paddle on its left side while moving left...
            if ball.x < self.paddle.x + (self.paddle.width / 2) and self.paddle.dx < 0 then
                ball.dx = -50 + -(8 * (self.paddle.x + self.paddle.width / 2 - ball.x))
        
            -- else if we hit the paddle on its right side while moving right...
            elseif ball.x > self.paddle.x + (self.paddle.width / 2) and self.paddle.dx > 0 then
                ball.dx = 50 + (8 * math.abs(self.paddle.x + self.paddle.width / 2 - ball.x))
            end

            gSounds['paddle-hit']:play()
        end
    
    -- detect collision across all bricks with the ball
    
    
        for k, brick in pairs(self.bricks) do

            -- only check collision if we're in play
            if brick.inPlay and ball:collides(brick) then

                -- add to score
                self.score = self.score + (brick.tier * 200 + brick.color * 25)

                -- trigger the brick's hit function, which removes it from play
                brick:hit()
                brick_hit_counter = brick_hit_counter+1

                -- if we have enough points, recover a point of health
                if self.score > self.recoverPoints then
                    -- can't go above 3 health
                    self.health = math.min(3, self.health + 1)
                    

                    -- multiply recover points by 2
                    self.recoverPoints = math.min(100000, self.recoverPoints * 2)

                    -- play recover sound effect
                    gSounds['recover']:play()
                end

                -- go to our victory screen if there are no more bricks left
                if self:checkVictory() then
                    gSounds['victory']:play()

                    gStateMachine:change('victory', {
                        level = self.level,
                        paddle = self.paddle,
                        health = self.health,
                        score = self.score,
                        highScores = self.highScores,
                        ball = self.ball,
                        Powerup = self.powerup,
                        recoverPoints = self.recoverPoints
                        
                    })
                end

                --
                -- collision code for bricks
                --
                -- we check to see if the opposite side of our velocity is outside of the brick;
                -- if it is, we trigger a collision on that side. else we're within the X + width of
                -- the brick and should check to see if the top or bottom edge is outside of the brick,
                -- colliding on the top or bottom accordingly 
                --

                -- left edge; only check if we're moving right, and offset the check by a couple of pixels
                -- so that flush corner hits register as Y flips, not X flips
                if ball.x + 2 < brick.x and ball.dx > 0 then
                
                    -- flip x velocity and reset position outside of brick
                    ball.dx = -ball.dx
                    ball.x = brick.x - 8
            
                -- right edge; only check if we're moving left, , and offset the check by a couple of pixels
                -- so that flush corner hits register as Y flips, not X flips
                elseif ball.x + 6 > brick.x + brick.width and ball.dx < 0 then
                
                    -- flip x velocity and reset position outside of brick
                    ball.dx = -ball.dx
                    ball.x = brick.x + 32
            
                -- top edge if no X collisions, always check
                elseif ball.y < brick.y then
                
                    -- flip y velocity and reset position outside of brick
                    ball.dy = -ball.dy
                    ball.y = brick.y - 8
            
                -- bottom edge if no X collisions or top collision, last possibility
                else
                
                    -- flip y velocity and reset position outside of brick
                    ball.dy = -ball.dy
                    ball.y = brick.y + 16
                end

                -- slightly scale the y velocity to speed up the game, capping at +- 150
                if math.abs(ball.dy) < 150 then
                    ball.dy = ball.dy * 1.02
                end

                -- only allow colliding with one brick, for corners
                break
            end
        end
    end

    -- if ball goes below bounds, revert to serve state and decrease health
    
    
    if update and self.ball.y >= VIRTUAL_HEIGHT and self.ball2.y >= VIRTUAL_HEIGHT and self.ball3.y >= VIRTUAL_HEIGHT then
        if self.paddle.size ~= 1 then
            self.paddle.width = self.paddle.width - 32
            self.paddle.size = self.paddle.size-1
        end
        
        self.health = self.health - 1
        gSounds['hurt']:play()
        
    
    

        if self.health == 0 then
            gStateMachine:change('game-over', {
                score = self.score,
                highScores = self.highScores
            })
        else
            gStateMachine:change('serve', {
                paddle = self.paddle,
                bricks = self.bricks,
                health = self.health,
                score = self.score,
                highScores = self.highScores,
                level = self.level,
                Powerup = self.powerup,
                recoverPoints = self.recoverPoints,
                upgradePoints = self.upgradePoints
            })
        end

    elseif not update and self.ball.y >= VIRTUAL_HEIGHT then
        self.health = self.health - 1
        gSounds['hurt']:play()
        
        if self.paddle.size ~= 1 then
            self.paddle.width = self.paddle.width- 32
            self.paddle.size = self.paddle.size-1
        end

    

        if self.health == 0 then
            gStateMachine:change('game-over', {
                score = self.score,
                highScores = self.highScores
            })
        else
            gStateMachine:change('serve', {
                paddle = self.paddle,
                bricks = self.bricks,
                health = self.health,
                score = self.score,
                highScores = self.highScores,
                level = self.level,
                Powerup = self.powerup,
                recoverPoints = self.recoverPoints,
                upgradePoints = self.upgradePoints
            })
        end


    
    end

    -- for rendering particle systems
    for k, brick in pairs(self.bricks) do
        brick:update(dt)
    end

    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end
end


function PlayState:render()
    -- render bricks
    for k, brick in pairs(self.bricks) do
        brick:render()
    end

    -- render all particle systems
    for k, brick in pairs(self.bricks) do
        brick:renderParticles()
    end

    
    self.ball:render()
    
    if timer > randTime then
        self.powerup:render()
        
    end
    if timer > randTime2 and keyNeeded then 
        self.powerup2:render()
    end

    
    if self.powerup.inPlay == false then
        self.ball2:render()
        self.ball3:render()
        if self.powerup.skin == 10 then
            power_activate = true
        end

        
        
    end
   
    
    renderScore(self.score)
    renderHealth(self.health)

    -- pause text, if paused
    if self.paused then
        love.graphics.setFont(gFonts['large'])
        love.graphics.printf("PAUSED", 0, VIRTUAL_HEIGHT / 2 - 16, VIRTUAL_WIDTH, 'center')
    end
   
    -- if self.score > self.upgradePoints and self.paddle.size ~= 4 then
    --     self.paddle.size = self.paddle.size+1
    --     self.paddle.width= self.paddle.width + 32
    --     self.upgradePoints = self.upgradePoints*2


    -- elseif self.score > self.upgradePoints  then
    --     self.upgradePoints = self.upgradePoints * 2
    -- end



   
    if brick_hit_counter > 15 and self.paddle.size ~= 4 and self.score > 7500 then
        self.paddle.size = self.paddle.size + 1
        self.paddle.width = self.paddle.width + 32
        brick_hit_counter = 0
    end

    self.paddle:render()
    


    
        
end






function PlayState:checkVictory()
    for k, brick in pairs(self.bricks) do
        if brick.inPlay then
            return false
        end 
    end
    -- self.paddle.size = 2
    -- self.paddle.width = 32
    return true
    
end