PlayerLiftState = class{__includes = BaseState}

function PlayerLiftState:init(player,dungeon)
    
    self.player = player
    local direction = self.player.direction
    
    self.dungeon= dungeon
    self.player.offsetY =0
    self.player.offsetX = 0
   
    self.player:changeAnimation('pot-lift-'  .. direction)
    
end

function PlayerLiftState:enter()
    self.player.currentAnimation:refresh()
    self.pot= self.Room.objects[2]
    timer.tween(0.2,{
        [self.pot]={y=self.player.y-4,x=self.player.x}
    })
end

function PlayerLiftState:update(dt)
    if self.player.currentAnimation.timesPlayed > 0 then
        self.player.currentAnimation.timesPlayed = 0

    end


end

