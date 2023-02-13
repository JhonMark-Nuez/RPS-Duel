local GameScene = {}

tween = require('lib/tween')
anim8 = require('lib/anim8')

local Timer = require('source/Timer')
local Hands = require('source/Hands')

local _MODE = 'PvP' -- (PvP = Player vs Player, PvE = Player vs Environment)
local Player_1, Player_2 = {}, {}
Player_1.picked, Player_2.picked = '', '' -- (Rock, Paper, Scissor)

done = false

local Bot_options = {"Rock", "Paper", "Scissor"}
local AI = true

local background = love.graphics.newImage('assets/background.png') 

local result = '' -- (P1, P2, DRAW)
local result_image = {
    p1 = love.graphics.newImage('assets/p1-wins.png'),
    p2 = love.graphics.newImage('assets/p2-wins.png'),
    draw = love.graphics.newImage('assets/draw.png')
}
local result_text_width = result_image.p1:getWidth()
local result_text_height = result_image.p1:getHeight()

local time1 = 0.1
local time2 = 1.3
startTimer = Timer.newTimer(time1, function() print("EEEEEEE") end)
resultTimer = Timer.newTimer(time2 , function() print("Your timer is due!") end)

local play_idleAnim = false

-- Initialize the variable
function var_init(dt)
    Player_1.picked, Player_2.picked = '', ''
    Hands_1.type, Hands_2.type = '', ''
    result = ''
    done = false

    time1 = 0.1
    time2 = 1.3
    startTimer = Timer.newTimer(time1, function() print("EEEEEEE") end)
    resultTimer = Timer.newTimer(time2 , function() print("Your timer is due!") end)
    h1_current_animation = h1_stop_animation
    h2_current_animation = h2_stop_animation
    h1_stop_animation = anim8.newAnimation(h1_idle_g('1-1', 1), 0.1)
    h1_play_animation = anim8.newAnimation(h1_idle_g('1-13', 1), 0.1)
    h2_stop_animation = anim8.newAnimation(h2_idle_g('1-1', 1), 0.1)
    h2_play_animation = anim8.newAnimation(h2_idle_g('1-13', 1), 0.1)
end

function GameScene.Draw()
    love.graphics.draw(background)
    Hands.Draw()
    if done then GameScene.GameResult() end

    love.graphics.print(time1, 10, 10)
    love.graphics.print(Hands_2.x, 10, 25)
    love.graphics.print(tostring(done), 10, 40)
    love.graphics.print(result.. "!", 10, 55)
end

function GameScene.Update(dt)
    Hands.Update(dt)
    
    -- AI
    -- Randomize the choices between (Rock, Paper, Scissor)
    local choice = Bot_options[math.random(#Bot_options)]
    if _MODE == 'PvE' and not done then
        -- Check what BOT choose between {Rock, Paper, Scissor}
        if choice == "Rock" then Player_2.picked = 'Rock'
        elseif choice == "Paper" then Player_2.picked = 'Paper'
        elseif choice == "Scissor" then Player_2.picked = 'Scissor' end
    end


    function love.keypressed(key)
        if not done then

            -- PLAYER 1 CONTROLS
            if key == '1' then
                Player_1.picked = 'Rock'
            elseif key == '2' then
                Player_1.picked = 'Paper'
            elseif key == '3' then
                Player_1.picked = 'Scissor'        
            end

            -- PLAYER 2 CONTROLS
            if key == 'q' then
                Player_2.picked = 'Rock'
            elseif key == 'w' then
                Player_2.picked = 'Paper'
            elseif key == 'e' then
                Player_2.picked = 'Scissor'
            end
        end

        -- Proceed
        if resultTimer.isExpired() and key == 'return' then var_init(dt) end

        -- Change GameMode
        if key == 'p' then _MODE = 'PvP' 
        elseif key == 'o' then _MODE = 'PvE'
        end
    end

    -- Check if the selection was DONE
    if  _MODE == 'PvP' and Player_1.picked ~= '' and Player_2.picked ~= ''then 
        if not startTimer.isExpired() then
            startTimer.update(dt)
        end
    elseif _MODE == 'PvE' and Player_1.picked ~= ''then
        if not startTimer.isExpired() then
            startTimer.update(dt)
        end
    end

    -- Check if the game was DONE and tell the result
    if startTimer.isExpired() then
        done = true
    end

    if done then 
        if not resultTimer.isExpired() then 
            resultTimer.update(dt) 
            play_idleAnim = true
        else
            play_idleAnim = false
        end
        GameScene.GameResult()
        if play_idleAnim then
            h1_current_animation = h1_play_animation
            h2_current_animation = h2_play_animation
        else
            h1_current_animation = h1_stop_animation
            h2_current_animation = h2_stop_animation
        end
    end
end

function GameScene.GameResult()

    if resultTimer.isExpired() then
        -- Check what PLAYER 1 & 2 choose between {Rock, Paper, Scissor}
        if Player_1.picked == 'Rock' then Hands_1.type = 'Rock'
        elseif Player_1.picked == 'Paper' then Hands_1.type = 'Paper'
        elseif Player_1.picked == 'Scissor' then Hands_1.type = 'Scissor' end
        if Player_2.picked == 'Rock' then Hands_2.type = 'Rock'
        elseif Player_2.picked == 'Paper' then Hands_2.type = 'Paper'
        elseif Player_2.picked == 'Scissor' then Hands_2.type = 'Scissor' end

    end

    -- All possible results
    if Player_1.picked == 'Rock' and Player_2.picked == 'Rock' then result = 'DRAW' end
    if Player_1.picked == 'Rock' and Player_2.picked == 'Scissor' then result = 'P1' end
    if Player_1.picked == 'Rock' and Player_2.picked == 'Paper' then result = 'P2' end

    if Player_1.picked == 'Paper' and Player_2.picked == 'Paper' then result = 'DRAW' end
    if Player_1.picked == 'Paper' and Player_2.picked == 'Rock' then result = 'P1' end
    if Player_1.picked == 'Paper' and Player_2.picked == 'Scissor' then result = 'P2' end
    
    if Player_1.picked == 'Scissor' and Player_2.picked == 'Scissor' then result = 'DRAW' end
    if Player_1.picked == 'Scissor' and Player_2.picked == 'Paper' then result = 'P1' end
    if Player_1.picked == 'Scissor' and Player_2.picked == 'Rock' then result = 'P2' end

    if resultTimer.isExpired() then
        if result == 'P1' then
            love.graphics.draw(result_image.p1, _screenWidth /2 - result_text_width /2, _screenHeight /2 - result_text_height)
        elseif result == 'P2' then
            love.graphics.draw(result_image.p2, _screenWidth /2 - result_text_width /2, _screenHeight /2 - result_text_height)
        elseif result == 'DRAW' then
            love.graphics.draw(result_image.draw, _screenWidth /2 - result_text_width /2, _screenHeight /2 - result_text_height)
        end
    end
end

return GameScene