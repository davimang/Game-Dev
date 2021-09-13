PlayerLiftState = Class{__includes = BaseState}

function PlayerLiftState:init(player,dungeon)
    
    self.player = player
   
    
    self.dungeon= dungeon
    self.player.offsetY =0
    self.player.offsetX = 0
   
    self.player:changeAnimation('pot-lift-' .. self.player.direction)
    
end

function PlayerLiftState:enter(params)
    self.player.currentAnimation:refresh()
    
    Timer.tween(0.2,{
        [pot]={y=self.player.y-8,x=self.player.x}
    })
end

function PlayerLiftState:update(dt)
    if self.player.currentAnimation.timesPlayed > 0 then
        self.player.currentAnimation.timesPlayed = 0
        self.player:changeState('pot-walk')
    end
    

end

function PlayerLiftState:render()
    local anim = self.player.currentAnimation
    love.graphics.draw(gTextures[anim.texture], gFrames[anim.texture][anim:getCurrentFrame()],
        math.floor(self.player.x - self.player.offsetX), math.floor(self.player.y - self.player.offsetY))

end

