--[[
    GD50
    Legend of Zelda

    Author: Colton Ogden, David Moroniti
    cogden@cs50.harvard.edu
]]



GAME_OBJECT_DEFS = {
    ['switch'] = {
        type = 'switch',
        texture = 'switches',
        frame = 2,
        width = 16,
        height = 16,
        solid = false,
        defaultState = 'unpressed',
        states = {
            ['unpressed'] = {
                frame = 2
            },
            ['pressed'] = {
                frame = 1
            }
        }
    },
    ['pot'] = {
        type = 'pot',
        texture = 'tiles',
        frame = 16,
        width = 16,
        height = 16,
        solid = true,
        collidable= true,
        consumable = false,
        defaultState = 'fixed',

        states = {
            ['fixed'] = {
                frame =16
            },
            ['broken']= {
                frame = 54
            }
        },

        onCollide = function(obj)

        end
        
    },

    ['extra-health']= {
        type = 'extra-health',
        texture= 'hearts',
        frame  = 5,
        width = 16,
        height = 16,
        x=50,
        y=50,
        solid = false,
        consumable = true,
        collidable = true,
        defaultState = 'full-heart',

        states ={
            ['full-heart'] = {
                frame = 5
            }
        },


        onConsume = function(obj)
          


        end

        

    }
}
