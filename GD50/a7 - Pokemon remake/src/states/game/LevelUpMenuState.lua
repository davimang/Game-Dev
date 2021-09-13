LevelUpMenuState = Class{__includes = BaseState}

function LevelUpMenuState:init(battlestate,pokemon)
    self.battleState = battlestate
    self.pokemon = pokemon
    self.pokemonHp = self.pokemon.HP
    self.pokemonAttack = self.pokemon.attack 
    self.pokemonDefense = self.pokemon.defense
    self.pokemonSpeed=  self.pokemon.speed


    self.levelupMenu = Menu{
        x = VIRTUAL_WIDTH - 200,
        y= 0,
        width = 64*3,
        height = 64*3,
        items = {
            {
                text = 'Health: ' .. (self.pokemonHp - HPIncrease) .. '+' .. HPIncrease .. '=' .. self.pokemonHp

            },
            {
                text = 'Attack: ' .. (self.pokemonAttack - attackIncrease) .. '+' .. attackIncrease .. '=' .. self.pokemonAttack
            },
            {
                text = 'Defense: ' .. (self.pokemonDefense - defenseIncrease) .. '+' .. defenseIncrease .. '=' .. self.pokemonDefense
            },
            {
                text = 'Speed: ' .. (self.pokemonSpeed - speedIncrease) .. '+' .. speedIncrease .. '=' .. self.pokemonSpeed
            }
        },
        sekectOption = false
     }
end

function LevelUpMenuState:enter(params)

end

function LevelUpMenuState:update(dt)
    self.levelupMenu:update(dt)
end

function LevelUpMenuState:render()
    self.levelupMenu:render()
end