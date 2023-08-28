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

function p_moves(turn, row, column) 

        local position = {row, column}
        local moves = {}        
        
        if turn == "white" then
                if row < 8 then
                        -- single
                        
                        --[[
                        for i = 1, #pieces do
                                for j in pieces[i] do
                                        if pieces[i][j][pos_x] == row then
                                        --]]                     
                                        
                        if board[row + 1][column][2] == "E" then
                                table.insert(moves, {row + 1, column}) 

                        -- double
                                if string.sub(board[row][column][1], 2, 2) == "2" then
                                        if board[row + 2][column][2] == "E" then
                                                table.insert(moves, {row + 2, column})
                                        end
                                end
                        end

                        -- take right
                        if column < 8 then
                                if string.sub(board[row + 1][column + 1][2], 1, 1) == "B" then
                                        table.insert(moves, {row + 1, column + 1})
                                end
                        end

                        -- take left
                        if column > 1 then
                                if string.sub(board[row + 1][column - 1][2], 1, 1) == "B" then
                                        table.insert(moves, {row + 1, column - 1})
                                end
                        end
                        
                        -- en passant 
                        -- only works if the last turn was a double; you need to account for this
                        if string.sub(board[row][column][1], 2, 2) == "5" then
                                if string.sub(last_move[2], 2, 2) == "7" then
                                        -- ep right
                                        if column < 8 then 
                                                if board[row][column + 1][1] == last_move[3] then
                                                        if board[row + 1][column + 1][2] == "E" then
                                                                table.insert(moves, {row + 1, column + 1})
                                                        end
                                                end
                                        end
                                end
                                        -- ep left
                                        if column > 1 then
                                                if board[row][column - 1][1] == last_move[3] then
                                                        if board[row + 1][column - 1][2] == "E" then
                                                                table.insert(moves, {row + 1, column - 1})
                                                        end
                                                end
                                        end
                                end
                        end

                        return {moves} 
                end

        if turn == "B" then
                if row > 1 then
                        -- single
                        if board[row - 1][column][2] == "E" then
                                table.insert(moves, {row - 1, column}) 

                        -- double
                                if string.sub(board[row][column][1], 2, 2) == "7" then
                                        if board[row - 2][column][2] == "E" then
                                                table.insert(moves, {row - 2, column})
                                        end
                                end
                        end

                        -- take right
                        if column < 8 then
                                if string.sub(board[row - 1][column + 1][2], 1, 1) == "W" then
                                        table.insert(moves, {row - 1, column + 1})
                                end
                        end

                        -- take left
                        if column > 1 then
                                if string.sub(board[row - 1][column - 1][2], 1, 1) == "W" then
                                        table.insert(moves, {row - 1, column - 1})
                                end
                        end
                        
                        -- en passant 
                        if string.sub(board[row][column][1], 2, 2) == "4" then
                                if string.sub(last_move[2], 2, 2) == "2" then
                                        -- ep right
                                        if board[row][column + 1][1] == last_move[3] then
                                                if board[row - 1][column + 1][2] == "E" then
                                                        table.insert(moves, {row - 1, column + 1})
                                                end
                                        end
                                        -- ep left
                                        if board[row][column - 1][1] == last_move[3] then
                                                if board[row - 1][column - 1][2] == "E" then
                                                        table.insert(moves, {row - 1, column - 1})
                                                end
                                        end
                                end
                        end

                        return {moves} 
                end
        end
end

function love.load()

        board = {
                image = love.graphics.newImage('sprites/board.png'),
                border = 7,
                square = 88.25,
                state = init_board(),
                turn = "white"
        }

        pieces = {

                white_pawn = {
                        image = love.graphics.newImage('sprites/white_pawn.png'),
                        first = {
                                in_play = true,
                                moves = {},
                                x = board.border + (board.square * 6) + 15.5,
                                y = board.border + (board.square * 6) + 15.5,
                        },
                        second = {
                                in_play = true,
                                moves = {},
                                pos_x = 6,
                                pos_y = 6,
                                x = board.border + (board.square * pos_x - 1) + 15.5,
                                y = board.border + (board.square * pos_y - 1) + 15.5
                        },
                        third = {
                                in_play = true,
                                moves = {},
                                x = board.border + (board.square * 6) + 15.5,
                                y = board.border + (board.square * 6) + 15.5,
                        },
                        fourth = {
                                in_play = true,
                                moves = {},
                                x = board.border + (board.square * 6) + 15.5,
                                y = board.border + (board.square * 6) + 15.5,
                        },
                        fifth = {
                                in_play = true,
                                moves = {},
                                x = board.border + (board.square * 6) + 15.5,
                                y = board.border + (board.square * 6) + 15.5,
                        },
                        sixth = {
                                in_play = true,
                                moves = {},
                                x = board.border + (board.square * 6) + 15.5,
                                y = board.border + (board.square * 6) + 15.5,
                        },
                        seventh = {
                                in_play = true,
                                moves = {},
                                x = board.border + (board.square * 6) + 15.5,
                                y = board.border + (board.square * 6) + 15.5,
                        },
                        eight = {
                                in_play = true,
                                moves = {},
                                x = board.border + (board.square * 6) + 15.5,
                                y = board.border + (board.square * 6) + 15.5,
                        }
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
                        castle_left = true,
                        castle_right = true,
                        first = {},
                        second = {}
                },

                black_pawn = {
                        image = love.graphics.newImage('sprites/black_pawn.png'),
                        first = {
                                in_play = true,
                                moves = {},
                                x = board.border + (board.square * 4) + 15.5,
                                y = board.border + (board.square * 4) + 15.5
                        },
                                second = {
                                in_play = true,
                                moves = {},
                                x = board.border + (board.square * 6) + 15.5,
                                y = board.border + (board.square * 6) + 15.5,
                                },
                                third = {
                                in_play = true,
                                moves = {},
                                x = board.border + (board.square * 6) + 15.5,
                                y = board.border + (board.square * 6) + 15.5,
                                },
                                fourth = {
                                in_play = true,
                                moves = {},
                                x = board.border + (board.square * 6) + 15.5,
                                y = board.border + (board.square * 6) + 15.5,
                                },
                                fifth = {
                                in_play = true,
                                moves = {},
                                x = board.border + (board.square * 6) + 15.5,
                                y = board.border + (board.square * 6) + 15.5,
                                },
                                sixth = {
                                in_play = true,
                                moves = {},
                                x = board.border + (board.square * 6) + 15.5,
                                y = board.border + (board.square * 6) + 15.5,
                                },
                                seventh = {
                                in_play = true,
                                moves = {},
                                x = board.border + (board.square * 6) + 15.5,
                                y = board.border + (board.square * 6) + 15.5,
                                },
                                eight = {
                                in_play = true,
                                moves = {},
                                x = board.border + (board.square * 6) + 15.5,
                                y = board.border + (board.square * 6) + 15.5,
                                }
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
                        castle_left = true,
                        castle_right = true,
                        first = {},
                        second = {}
                },
        }

        selector = {
                choose = false,
                x = board.border,
                y = board.border
        }
end

function love.update(dt)
        if selector.choose == false then
                function love.keypressed(key, scancode)

                        if scancode == "j" then
                                selector.y = selector.y + board.square
                        end

                        if scancode == "k" then
                                selector.y = selector.y - board.square
                        end

                        if scancode == "h" then
                                selector.x = selector.x - board.square
                        end

                        if scancode == "l" then
                                selector.x = selector.x + board.square
                        end

                        if scancode == "Enter" then
                                selector.choose = true
                        end
                end
        else
                -- if selector.choose == true
                -- Problem: this square should have a piece that has possible moves; else enter should do nothing
                -- end: selector.choose = false
        end
end

function love.draw()
        love.graphics.draw(board.image, 0, 0)
        love.graphics.setColor(70/255, 200/255, 235/255, 1)
        love.graphics.rectangle("fill", selector.x, selector.y, 90, 90)
        love.graphics.setColor(1, 1, 1, 1)
        love.graphics.draw(pieces.black_pawn.image, pieces.black_pawn.first.x, pieces.black_pawn.first.y)
        love.graphics.draw(pieces.white_pawn.image, pieces.white_pawn.first.x, pieces.white_pawn.first.y)
        love.graphics.draw(pieces.white_knight.image, pieces.white_knight.first.x, pieces.white_knight.first.y)
end

