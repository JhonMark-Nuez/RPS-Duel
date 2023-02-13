local Hands = {}


local Rock_1 = love.graphics.newImage('assets/hands/r_1.png')
Rock_1:setFilter("nearest", "nearest")
local Paper_1 = love.graphics.newImage('assets/hands/p_1.png')
Paper_1:setFilter("nearest", "nearest")
local Scissor_1 = love.graphics.newImage('assets/hands/s_1.png')
Scissor_1:setFilter("nearest", "nearest")

local Rock_2 = love.graphics.newImage('assets/hands/r_2.png')
Rock_2:setFilter("nearest", "nearest")
local Paper_2= love.graphics.newImage('assets/hands/p_2.png')
Paper_2:setFilter("nearest", "nearest")
local Scissor_2 = love.graphics.newImage('assets/hands/s_2.png')
Scissor_2:setFilter("nearest", "nearest")


local hand_idle_1 = love.graphics.newImage('assets/hands/idle_1.png')
hand_idle_1:setFilter("nearest", "nearest")
h1_idle_g = anim8.newGrid(176, 154, hand_idle_1:getWidth(), hand_idle_1:getHeight())
h1_stop_animation = anim8.newAnimation(h1_idle_g('1-1', 1), 0.1)
h1_play_animation = anim8.newAnimation(h1_idle_g('1-13', 1), 0.1)
h1_current_animation = h1_stop_animation

local hand_idle_2 = love.graphics.newImage('assets/hands/idle_2.png')
hand_idle_2:setFilter("nearest", "nearest")
h2_idle_g = anim8.newGrid(176, 154, hand_idle_2:getWidth(), hand_idle_2:getHeight())
h2_stop_animation = anim8.newAnimation(h2_idle_g('1-1', 1), 0.1)
h2_play_animation = anim8.newAnimation(h2_idle_g('1-13', 1), 0.1)
h2_current_animation = h2_stop_animation

local img_Height = Scissor_1:getHeight()
local img_Width = Scissor_1:getWidth()
local hand_scale = 2

Hands.img_rotate = 0

Hands_1, Hands_2 = {}, {}
Hands_1.type, Hands_2.type = '', '' -- (Rock, Paper, Scissor)
Hands_1.x, Hands_2.x = 0, _screenWidth 
Hands_1.y, Hands_2.y = _screenHeight -150, _screenHeight -150

function Hands.Draw()
    -- if done then    -- end   
    if not resultTimer.isExpired() then
        h1_current_animation:draw(hand_idle_1, Hands_1.x, Hands_1.y -180, 0, hand_scale, hand_scale, 0, img_Height / 2)
        h2_current_animation:draw(hand_idle_2, Hands_2.x - 352, Hands_2.y -180, 0, hand_scale, hand_scale, 0, img_Height / 2)
    elseif resultTimer.isExpired() then
        
        if Hands_1.type == 'Rock' then love.graphics.draw(Rock_1, Hands_1.x, Hands_1.y, 0, hand_scale, hand_scale, 0, img_Height / 2)
        elseif Hands_1.type == 'Paper' then love.graphics.draw(Paper_1, Hands_1.x, Hands_1.y, 0, hand_scale, hand_scale, 0, img_Height/ 2)
        elseif Hands_1.type == 'Scissor' then love.graphics.draw(Scissor_1, Hands_1.x, Hands_1.y, 0, hand_scale, hand_scale, 0, img_Height / 2) end
    
        if Hands_2.type == 'Rock' then love.graphics.draw(Rock_2, Hands_2.x, Hands_2.y, 0, hand_scale, hand_scale, img_Width , img_Height / 2)
        elseif Hands_2.type == 'Paper' then love.graphics.draw(Paper_2, Hands_2.x, Hands_2.y, 0, hand_scale, hand_scale, img_Width, img_Height / 2)
        elseif Hands_2.type == 'Scissor' then love.graphics.draw(Scissor_2, Hands_2.x, Hands_2.y, 0, hand_scale, hand_scale, img_Width, img_Height / 2) end    

    end
end

function Hands.Update(dt)
    -- print(h1_current_animation)
    h1_current_animation:update(dt)
    h2_current_animation:update(dt)
    if done and not resultTimer.isExpired() then

    end



end

return Hands