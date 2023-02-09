local GameScene = {}

local Hands = require('source/Hands')
local _MODE = 'PVP' -- (PvP = Player vs Player, PvE = Player vs Environment)
local Player_1, Player_2 = {}, {}
Player_1.picked, Player_2.picked = '', '' -- (Rock, Paper, Scissor)

local Bot_options = {"Rock", "Paper", "Scissor"}

local current_Turn = 1 -- 1 = Player_1, 2 = Player_2/bot/aiv
local AI = true
local done = false

function GameScene.Draw()
    Hands.Draw()
    love.graphics.print(Player_1.picked, 10, 10)
    love.graphics.print(Player_2.picked, 10, 40)
    love.graphics.print(_MODE, 10, 70)
end

function GameScene.Update(dt)
    Hands.Update(dt)

    if current_Turn > 2 then current_Turn = 1 end

    if Player_1.picked == 'Rock' then Hands_1.type = 'Rock'
    elseif Player_1.picked == 'Paper' then Hands_1.type = 'Paper'
    elseif Player_1.picked == 'Scissor' then Hands_1.type = 'Scissor' end
    if Player_2.picked == 'Rock' then Hands_2.type = 'Rock'
    elseif Player_2.picked == 'Paper' then Hands_2.type = 'Paper'
    elseif Player_2.picked == 'Scissor' then Hands_2.type = 'Scissor' end

    -- AI
    local choice = Bot_options[math.random(#Bot_options, math.random(0,3))]

    if _MODE == 'PvE' and current_Turn == 2 and not done then
        if choice == "Rock" then Player_2.picked = 'Rock' end
        if choice == "Paper" then Player_2.picked = 'Paper' end
        if choice == "Scissor" then Player_2.picked = 'Scissor' end

        done = true
    end

    function love.keypressed(key)
        if not done then
            if key == '1' then
                if current_Turn == 1 then
                    Player_1.picked = 'Rock'
                elseif current_Turn == 2 and _MODE == 'PvP' then
                    Player_2.picked = 'Rock'
                end
                current_Turn = current_Turn + 1
            elseif key == '2' then
                if current_Turn == 1 then
                    Player_1.picked = 'Paper'
                elseif current_Turn == 2 and _MODE == 'PvP'  then
                    Player_2.picked = 'Paper'
                end
                current_Turn = current_Turn + 1
            elseif key == '3' then
                if current_Turn == 1 then
                    Player_1.picked = 'Scissor'
                elseif current_Turn == 2 and _MODE == 'PvP'  then
                    Player_2.picked = 'Scissor'
                end            
                current_Turn = current_Turn + 1
            end
        end

        if key == 'return' then
            Player_1.picked, Player_2.picked = '', ''
            current_Turn = 1
            done = false  
        end

        if key == 'p' then
            _MODE = 'PvP' 
        elseif key == 'o' then
            _MODE = 'PvE'
        end
    end

    if Player_1.picked and Player_2.picked ~= '' then
        done = true
    else done = false end

    if done then GameScene.GameResult() end
end

function GameScene.GameResult()
    if Player_1.picked == 'Rock' and Player_2.picked == 'Rock' then print("DRAW") end
    if Player_1.picked == 'Rock' and Player_2.picked == 'Scissor' then print("P1 WINS!") end
    if Player_1.picked == 'Rock' and Player_2.picked == 'Paper' then print("P2 WINS!") end

    if Player_1.picked == 'Paper' and Player_2.picked == 'Paper' then print("DRAW") end
    if Player_1.picked == 'Paper' and Player_2.picked == 'Rock' then print("P1 WINS!") end
    if Player_1.picked == 'Paper' and Player_2.picked == 'Scissor' then print("P2 WINS!") end
    
    if Player_1.picked == 'Scissor' and Player_2.picked == 'Scissor' then print("DRAW") end
    if Player_1.picked == 'Scissor' and Player_2.picked == 'Paper' then print("P1 WINS!") end
    if Player_1.picked == 'Scissor' and Player_2.picked == 'Rock' then print("P2 WINS!") end
end

return GameScene