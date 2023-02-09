local Hands = {}

Hands_1, Hands_2 = {}, {}
Hands_1.type, Hands_2.type = '', '' -- (Rock, Paper, Scissor)
Hands_1.x, Hands_2.x = 50, _screenWidth - 32 - 50
Hands_1.y, Hands_2.y = _screenHeight / 2, _screenHeight / 2

function Hands.Draw()
    love.graphics.rectangle('line', Hands_1.x, Hands_1.y, 32, 32)
    love.graphics.rectangle('line', Hands_2.x, Hands_2.y, 32, 32)
end

function Hands.Update(dt)

end

return Hands