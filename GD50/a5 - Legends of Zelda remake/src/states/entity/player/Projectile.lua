Projectile = Class{__includes = BaseState}

function Projectile:init(player,dungeon)
    self.player= player
    
    self.x = self.player.x
    self.y = self.player.y- 8

    self.dungeon = dungeon
    
end

function Projectile:enter(params)

end

function Projectile:update(dt)
    if self.player.direction == 'up' then
        
        pot.y = pot.y- (PROJECTILE_SPEED * dt)
        if math.abs(pot.y-self.y) > 4*TILE_SIZE then
            self.player:changeState('idle')
            waspotThrown = true
        end

        

    elseif self.player.direction == 'down'then
        pot.y = pot.y+ (PROJECTILE_SPEED * dt)
        if math.abs(pot.y-self.y) > 4*TILE_SIZE then
            self.player:changeState('idle')
        end
    
    elseif self.player.direction == 'left' then
        pot.x = pot.x- (PROJECTILE_SPEED * dt)
        if math.abs(pot.x-self.x) > 4*TILE_SIZE then
            self.player:changeState('idle')
        end
    else
        pot.x = pot.x+ (PROJECTILE_SPEED * dt)
        if math.abs(pot.x-self.x) > 4*TILE_SIZE then
            self.player:changeState('idle')
        end


            
    end
end

function Projectile:render()

end