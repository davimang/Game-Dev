PlayerPotIdleState = Class{__includes = BaseState}

function PlayerPotIdleState:init(player,dungeon)
    self.player = player
    self.dungeon = dungeon
    
    self.player:changeAnimation('pot-lift-idle')
end

function PlayerPotIdleState:enter(params)
    self.player.currentAnimation:refresh()
end

function PlayerPotIdleState:update(dt)
    EntityIdleState.update(self,dt)

    if love.keyboard.wasPressed('left') or love.keyboard.wasPressed('right') or 
    love.keyboard.wasPressed('up') or love.keyboard.wasPressed('down') then
        self.player:changeState('pot-walk')
    end

   
end

function PlayerPotIdleState:render()
    local anim = self.player.currentAnimation
    love.graphics.draw(gTextures[anim.texture], gFrames[anim.texture][anim:getCurrentFrame()],
        math.floor(self.player.x - self.player.offsetX), math.floor(self.player.y - self.player.offsetY))

end