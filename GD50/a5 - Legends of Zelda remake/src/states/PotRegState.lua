-- Author: David Moroniti

Pot = Class{}

function Pot:init(Room)
    
end




function potIdle:update(dt)
    
    local pot  = self.Room.objects[2]
    
    pot.onCollide = function()
    
        if self.player:collides(pot) then
            self.player.x = self.player.x + PLAYER_WALK_SPEED * dt
        end
    end

end
