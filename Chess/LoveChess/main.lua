#!/bin/lua

_G.love = require("love")

function love.load()
        player = {}
        board = {
                image = love.graphics.newImage('sprites/board.png')
        }
end


function love.update(dt)
end

function love.draw()
        love.graphics.draw(board.image)
end

