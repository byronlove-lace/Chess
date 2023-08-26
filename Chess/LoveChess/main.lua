#!/bin/lua

_G.love = require("love")

function love.load()
        board = {
                image = love.graphics.newImage('sprites/board.png')
        }
        pieces = {
                black_pawn = {
                image = love.graphics.newImage('sprites/black_pawn2.png'),
                first = {
                        x = 20,
                        y = 20
                },
                second = {},
                third = {},
                fourth = {},
                fifth = {},
                sixth = {},
                seventh = {},
                eight = {}
                }
        }
end


function love.update(dt)
end

function love.draw()
        love.graphics.draw(board.image)
        love.graphics.draw(pieces.black_pawn.image, pieces.black_pawn.first.x, pieces.black_pawn.first.y)
end

