PlayerThrowState = Class{__includes = BaseState}

function PlayerThrowState:init(player,dungeon,room)
    waspotThrown = false
    self.player = player
    self.dungeon = dungeon
    self.tween = false
    self.Room = room
    enterThrow = false
    
    
    self.x = self.player.x
    self.y = self.player.y -8

    self.player:changeAnimation('pot-throw-' .. self.player.direction)
end

function PlayerThrowState:enter(params)
    --self.player.currentAnimation:refresh() 
end

function PlayerThrowState:update(dt)
    enterThrow = true
    
    if self.player.currentAnimation.timesPlayed > 0 then
        self.player.currentAnimation.timesPlayed = 0 
    
    end  
    
    if self.player.direction == 'up' then
        
        pot.y = pot.y- (PROJECTILE_SPEED * dt)
        if math.abs(pot.y-self.y) > 4*TILE_SIZE then
            waspotThrown = true
            self.player:changeState('idle')
           
        end

        

    elseif self.player.direction == 'down'then
        pot.y = pot.y+ (PROJECTILE_SPEED * dt)
        
        if math.abs(pot.y-self.y) > 4*TILE_SIZE then
            waspotThrown = true
            self.player:changeState('idle')
            
        end
    
    elseif self.player.direction == 'left' then
        pot.x = pot.x- (PROJECTILE_SPEED * dt)
        
        if math.abs(pot.x-self.x) > 4*TILE_SIZE then
            waspotThrown = true
            self.player:changeState('idle')
            
        end
    else
        pot.x = pot.x+ (PROJECTILE_SPEED * dt)
        
        if math.abs(pot.x-self.x) > 4*TILE_SIZE then
            waspotThrown = true
            self.player:changeState('idle')
            
        end


            
    end
    
        
    


end

function PlayerThrowState:render()
    local anim = self.player.currentAnimation
    love.graphics.draw(gTextures[anim.texture], gFrames[anim.texture][anim:getCurrentFrame()],
        math.floor(self.player.x - self.player.offsetX), math.floor(self.player.y - self.player.offsetY))
       
end