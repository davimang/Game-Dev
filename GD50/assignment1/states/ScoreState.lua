--[[
    ScoreState Class
    Author: Colton Ogden
    cogden@cs50.harvard.edu

    A simple state used to display the player's score before they
    transition back into the play state. Transitioned to from the
    PlayState when they collide with a Pipe.
]]

ScoreState = Class{__includes = BaseState}

--[[
    When we enter the score state, we expect to receive the score
    from the play state so we know what to render to the State.
]]

--Medal = Class{}

    --function Medal:init()
        --self.image = love.graphics.newImage('bmedal.jpg')
        --self.x = VIRTUAL_WIDTH/2
        --self.y = VIRTUAL_HEIGHT/2

        --self.width = self.image:getWidth()
        --self.height = self.image:getHeight()
    --end




function ScoreState:enter(params)
    self.score = params.score
end

function ScoreState:update(dt)
    -- go back to play if enter is pressed
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateMachine:change('countdown')
    end
end

function ScoreState:render()
    -- simply render the score to the middle of the screen
    if self.score < 5 then
        love.graphics.setFont(flappyFont)
        love.graphics.printf('Oof! You lost!', 0, 64, VIRTUAL_WIDTH, 'center')

        love.graphics.setFont(mediumFont)
        love.graphics.printf('Score: ' .. tostring(self.score), 0, 100, VIRTUAL_WIDTH, 'center')

        love.graphics.printf('Press Enter to Play Again!', 0, 160, VIRTUAL_WIDTH, 'center')
        
        --love.graphics.draw(love.graphics.newImage('bronzeMedal.jpg'),VIRTUAL_WIDTH/2-8,VIRTUAL_HEIGHT/2-8)
        
    elseif self.score >= 5 and self.score < 10 then

        love.graphics.setFont(mediumFont)
        love.graphics.printf('You earned a bronze medal!', 0, 64, VIRTUAL_WIDTH, 'center')
        love.graphics.printf('Score: ' .. tostring(self.score), 0, 100, VIRTUAL_WIDTH, 'center')
        --love.graphics.newimage('Bronze_Medal(2).jpg')
        love.graphics.draw(love.graphics.newImage('bMedal.png'),VIRTUAL_WIDTH/2-30,VIRTUAL_HEIGHT/2-15)

        love.graphics.printf('Press enter to play again',0, 200, VIRTUAL_WIDTH,'center')
        
        
        --love.graphics.printf()

    elseif self.score >= 10 and self.score < 15 then
        love.graphics.setFont(mediumFont)
        love.graphics.printf('You earned a silver medal!', 0, 64, VIRTUAL_WIDTH, 'center')
        love.graphics.printf('Score: ' .. tostring(self.score), 0, 100, VIRTUAL_WIDTH, 'center')
        love.graphics.draw(love.graphics.newImage('silver.png'),VIRTUAL_WIDTH/2-30,VIRTUAL_HEIGHT/2-15)
        love.graphics.printf('Press enter to play again',0, 200, VIRTUAL_WIDTH,'center')
    else   
        love.graphics.setFont(mediumFont)
        love.graphics.printf('You earned a gold medal!', 0, 64, VIRTUAL_WIDTH, 'center')
        love.graphics.printf('Score: ' .. tostring(self.score), 0, 100, VIRTUAL_WIDTH, 'center')
        love.graphics.draw(love.graphics.newImage('gold_medal.png'),VIRTUAL_WIDTH/2-35,VIRTUAL_HEIGHT/2-15)
        love.graphics.printf('Press enter to play again',0, 230, VIRTUAL_WIDTH,'center')




    end
end