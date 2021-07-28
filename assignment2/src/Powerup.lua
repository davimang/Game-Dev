Powerup = Class{}

RANDOM_TIME = math.random(15)

function Powerup:init(skin)
    self.width = 16
    self.height = 16

    self.x = VIRTUAL_WIDTH/2
    self.y = VIRTUAL_HEIGHT/2
    self.dy = math.random(25,50)
    self.inPlay = true
    self.skin = skin
    power_activate = false
end



function Powerup:update(dt)
    if self.skin == 10 then
        self.dy = 10
        
    end

    self.y = self.y + self.dy*dt

end

function Powerup:collides(paddle)
    if self.x > paddle.x + paddle.width or paddle.x > self.x + self.width then
        return false
    end

    if self.y > paddle.y + paddle.height or paddle.y > self.y + self.height then
        return false
    end 
     
    return true

end


function Powerup:render()
    if self.inPlay then

        love.graphics.draw(gTextures['main'], gFrames['powerups'][self.skin],
            self.x, self.y)
    end

end


    



    