#!/bin/lua

_G.love = require("love")

function love.load()
        board = {
                image = love.graphics.newImage('sprites/board.png'),
                border = 7
        }
        pieces = {
                black_pawn = {
                image = love.graphics.newImage('sprites/black_pawn.png'),
                first = {
                        x = 7 + (88.25 * 1) + 15.5,
                        y = 7 + (88.25 * 1) + 15.5
                },
                second = {},
                third = {},
                fourth = {},
                fifth = {},
                sixth = {},
                seventh = {},
                eight = {}
                },
                white_pawn = {
                image = love.graphics.newImage('sprites/white_pawn.png'),
                first = {
                        x = (90 * 6) + 15.5,
                        y = (90 * 6) + 15.5
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
        selector = {
                x = 0,
                y = 0
        }
end


function love.update(dt)
end

function love.draw()
        love.graphics.draw(board.image, 0, 0)
        love.graphics.setColor(70/255, 200/255, 235/255, 1)
        love.graphics.rectangle("fill", 7, 7, 90, 90)
        love.graphics.setColor(1, 1, 1, 1)
        love.graphics.draw(pieces.black_pawn.image, pieces.black_pawn.first.x, pieces.black_pawn.first.y)
        love.graphics.draw(pieces.white_pawn.image, pieces.white_pawn.first.x, pieces.white_pawn.first.y)
end

