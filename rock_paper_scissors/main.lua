_screenWidth, _screenHeight = love.graphics.getWidth(), love.graphics.getHeight()

SceneManager = require('source/SceneManager')
GameScene = require('source/GameScene')
function love.load()
end

function love.update(dt)
    SceneManager:updateLoad(GameScene.Update, dt)

end

function love.draw()
    SceneManager:drawLoad(GameScene.Draw)
end