#!/bin/lua

_G.love = require("love")

function init_board()

        local initial_board = {}
        local letters = 'abcdefgh'

        for i = 1, 8 do
                initial_board[i] = {}
                for j = 1, 8 do
                        local letter = string.sub(letters, j, j) 
                        local square = letter..i
                        initial_board[i][j] = {square, "E"}
                end
        end


        for i = 1, #initial_board do
                for j = 1, #initial_board[i] do
                        if string.sub(initial_board[i][j][1], 2, 2) == "2" then
                                initial_board[i][j][2] = "WP"
                        end
                        if string.sub(initial_board[i][j][1], 2, 2) == "7" then
                                initial_board[i][j][2] = "BP"
                        end
                        if string.match(initial_board[i][j][1], "[bg][1]") then
                                initial_board[i][j][2] = "WN"
                        end
                        if string.match(initial_board[i][j][1], "[bg][8]") then
                                initial_board[i][j][2] = "BN"
                        end
                        if string.match(initial_board[i][j][1], "[cf][1]") then
                                initial_board[i][j][2] = "WB"
                        end
                        if string.match(initial_board[i][j][1], "[cf][8]") then
                                initial_board[i][j][2] = "BB"
                        end
                        if string.match(initial_board[i][j][1], "[ah][1]") then
                                initial_board[i][j][2] = "WR"
                        end
                        if string.match(initial_board[i][j][1], "[ah][8]") then
                                initial_board[i][j][2] = "BR"
                        end
                        if initial_board[i][j][1] == "d1" then
                                initial_board[i][j][2] = "WQ"
                        end
                        if initial_board[i][j][1] == "d8" then
                                initial_board[i][j][2] = "BQ"
                        end
                        if initial_board[i][j][1] == "e1" then
                                initial_board[i][j][2] = "WK"
                        end
                        if initial_board[i][j][1] == "e8" then
                                initial_board[i][j][2] = "BK"
                        end
                end
        end
        
        return initial_board
end

function love.load()
        
        board_state = init_board()

        board = {
                image = love.graphics.newImage('sprites/board.png'),
                border = 7,
                square = 88.25
        }

        pieces = {

                white_pawn = {
                        image = love.graphics.newImage('sprites/white_pawn.png'),
                        first = {
                                x = board.border + (board.square * 6) + 15.5,
                                y = board.border + (board.square * 6) + 15.5,
                        },
                        second = {},
                        third = {},
                        fourth = {},
                        fifth = {},
                        sixth = {},
                        seventh = {},
                        eight = {}
                },

                white_knight = {
                        image = love.graphics.newImage('sprites/white_knight.png'),
                        first = {
                                x = board.border + (board.square * 7) + 15.5,
                                y = board.border + (board.square * 7) + 15.5,
                        },
                        second = {}
                },

                white_bishop = {
                        image = love.graphics.newImage('sprites/white_bishop.png'),
                        first = {},
                        second = {}
                },

                white_rook = {
                        image = love.graphics.newImage('sprites/white_rook.png'),
                        first = {},
                        second = {}
                },

                white_queen = {
                        image = love.graphics.newImage('sprites/white_queen.png'),
                        first = {},
                        second = {}
                },

                white_king = {
                        image = love.graphics.newImage('sprites/white_king.png'),
                        first = {},
                        second = {}
                },

                black_pawn = {
                        image = love.graphics.newImage('sprites/black_pawn.png'),
                        first = {
                                x = board.border + (board.square * 4) + 15.5,
                                y = board.border + (board.square * 4) + 15.5
                        },
                                second = {},
                                third = {},
                                fourth = {},
                                fifth = {},
                                sixth = {},
                                seventh = {},
                                eight = {}
                        },

                black_knight = {
                        image = love.graphics.newImage('sprites/black_knight.png'),
                        first = {
                                x = board.border + (board.square * 5) + 15.5,
                                y = board.border + (board.square * 4) + 15.5,
                        },
                        second = {}
                },

                black_bishop = {
                        image = love.graphics.newImage('sprites/black_bishop.png'),
                        first = {},
                        second = {}
                },

                black_rook = {
                        image = love.graphics.newImage('sprites/black_rook.png'),
                        first = {},
                        second = {}
                },

                black_queen = {
                        image = love.graphics.newImage('sprites/black_queen.png'),
                        first = {},
                        second = {}
                },

                black_king = {
                        image = love.graphics.newImage('sprites/black_king.png'),
                        first = {},
                        second = {}
                },
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
        love.graphics.rectangle("fill", board.border, board.border, 90, 90)
        love.graphics.setColor(1, 1, 1, 1)
        love.graphics.draw(pieces.black_pawn.image, pieces.black_pawn.first.x, pieces.black_pawn.first.y)
        love.graphics.draw(pieces.white_pawn.image, pieces.white_pawn.first.x, pieces.white_pawn.first.y)
        love.graphics.draw(pieces.white_knight.image, pieces.white_knight.first.x, pieces.white_knight.first.y)
end

