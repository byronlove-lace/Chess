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


function white_pawn_moves(board, row, column) 

        local position = {row, column}
        local moves = {}        
        
        if row < 8 then
                -- single
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
                        if board.last_move then
                                if string.sub(board.board.last_move[2], 2, 2) == "7" then
                                        -- ep right
                                        if column < 8 then 
                                                if board[row][column + 1][1] == board.last_move[3] then
                                                        if board[row + 1][column + 1][2] == "E" then
                                                                table.insert(moves, {row + 1, column + 1})
                                                        end
                                                end
                                        end
                                end
                                        -- ep left
                                        if column > 1 then
                                                if board[row][column - 1][1] == board.last_move[3] then
                                                        if board[row + 1][column - 1][2] == "E" then
                                                                table.insert(moves, {row + 1, column - 1})
                                                        end
                                                end
                                        end
                                end
                        end
                end

                return {moves} 
        end


function love.load()

        board = {
                image = love.graphics.newImage('sprites/board.png'),
                border = 7,
                square = 88.25,
                state = init_board(),
                turn = "white",
                last_move = nil
        }

        function board.position (coord)

                local position = board.border + (board.square * coord) + 15.5

                return position

        end


        pieces = {

                white_pawn = {
                        image = love.graphics.newImage('sprites/white_pawn.png'),
                        first = {
                                in_play = true,
                                moves = {},
                                x = 6,
                                y = 6
                        },
                        second = {
                                in_play = true,
                                moves = {},
                                x = 6,
                                y = 6,
                                
                                -- do the multiply in the draw section - also, it should be a function
                        },
                        third = {
                                in_play = true,
                                moves = {},
                                x = 6,
                                y = 6,
                        },
                        fourth = {
                                in_play = true,
                                moves = {},
                                x = 6,
                                y = 6,
                        },
                        fifth = {
                                in_play = true,
                                moves = {},
                                x = 6,
                                y = 6,
                        },
                        sixth = {
                                in_play = true,
                                moves = {},
                                x = 6,
                                y = 6,
                        },
                        seventh = {
                                in_play = true,
                                moves = {},
                                x = 6,
                                y = 6,
                        },
                        eight = {
                                in_play = true,
                                moves = {},
                                x = 6,
                                y = 6,
                        }
                },

                white_knight = {
                        image = love.graphics.newImage('sprites/white_knight.png'),
                        first = {
                                x = 7,
                                y = 7,
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
                        x = 1,
                        y = 1
                },

                white_king = {
                        image = love.graphics.newImage('sprites/white_king.png'),
                        castle_left = true,
                        castle_right = true,
                        x = 1,
                        y = 1
                },

                black_pawn = {
                        image = love.graphics.newImage('sprites/black_pawn.png'),
                        first = {
                                in_play = true,
                                moves = {},
                                x = 4,
                                y = 4
                        },
                                second = {
                                in_play = true,
                                moves = {},
                                x = 6,
                                y = 6,
                                },
                                third = {
                                in_play = true,
                                moves = {},
                                x = 6,
                                y = 6,
                                },
                                fourth = {
                                in_play = true,
                                moves = {},
                                x = 6,
                                y = 6,
                                },
                                fifth = {
                                in_play = true,
                                moves = {},
                                x = 6,
                                y = 6,
                                },
                                sixth = {
                                in_play = true,
                                moves = {},
                                x = 6,
                                y = 6,
                                },
                                seventh = {
                                in_play = true,
                                moves = {},
                                x = 6,
                                y = 6,
                                },
                                eight = {
                                in_play = true,
                                moves = {},
                                x = 6,
                                y = 6,
                                }
                        },

                black_knight = {
                        image = love.graphics.newImage('sprites/black_knight.png'),
                        first = {
                                x = 5,
                                y = 4,
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
                x = 1,
                y = 1
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

        love.graphics.rectangle(
        "fill", 
        board.position(selector.x), 
        board.position(selector.y), 
        90, 
        90
        )

        love.graphics.setColor(1, 1, 1, 1)


        love.graphics.draw(
        pieces.white_pawn.image, 
        board.position(pieces.white_pawn.first.x), 
        board.position(pieces.white_pawn.first.y)
        )

        love.graphics.draw(
        pieces.white_pawn.image, 
        board.position(pieces.white_pawn.second.x), 
        board.position(pieces.white_pawn.second.y)
        )

        love.graphics.draw(
        pieces.white_pawn.image, 
        board.position(pieces.white_pawn.third.x), 
        board.position(pieces.white_pawn.third.y)
        )

        love.graphics.draw(
        pieces.white_pawn.image, 
        board.position(pieces.white_pawn.fourth.x), 
        board.position(pieces.white_pawn.fourth.y)
        )

        love.graphics.draw(
        pieces.white_pawn.image, 
        board.position(pieces.white_pawn.fifth.x), 
        board.position(pieces.white_pawn.fifth.y)
        )

        love.graphics.draw(
        pieces.white_pawn.image, 
        board.position(pieces.white_pawn.sixth.x), 
        board.position(pieces.white_pawn.sixth.y)
        )

        love.graphics.draw(
        pieces.white_pawn.image, 
        board.position(pieces.white_pawn.seventh.x), 
        board.position(pieces.white_pawn.seventh.y)
        )

        love.graphics.draw(
        pieces.white_pawn.image, 
        board.position(pieces.white_pawn.eight.x), 
        board.position(pieces.white_pawn.eight.y)
        )

        love.graphics.draw(
        pieces.white_knight.image, 
        board.position(pieces.white_knight.first.x), 
        board.position(pieces.white_knight.first.y)
        )

        love.graphics.draw(
        pieces.white_knight.image, 
        board.position(pieces.white_knight.second.x), 
        board.position(pieces.white_knight.second.y)
        )

        love.graphics.draw(
        pieces.white_bishop.image, 
        board.position(pieces.white_bishop.first.x), 
        board.position(pieces.white_bishop.first.y)
        )

        love.graphics.draw(
        pieces.white_bishop.image, 
        board.position(pieces.white_bishop.second.x), 
        board.position(pieces.white_bishop.second.y)
        )

        love.graphics.draw(
        pieces.white_rook.image, 
        board.position(pieces.white_rook.first.x), 
        board.position(pieces.white_rook.first.y)
        )

        love.graphics.draw(
        pieces.white_rook.image, 
        board.position(pieces.white_rook.second.x), 
        board.position(pieces.white_rook.second.y)
        )

        love.graphics.draw(
        pieces.white_rook.image, 
        board.position(pieces.white_rook.first.x), 
        board.position(pieces.white_rook.first.y)
        )

        love.graphics.draw(
        pieces.white_rook.image, 
        board.position(pieces.white_rook.second.x), 
        board.position(pieces.white_rook.second.y)
        )

        love.graphics.draw(
        pieces.white_rook.image, 
        board.position(pieces.white_queen.x), 
        board.position(pieces.white_queen.y)
        )

        love.graphics.draw(
        pieces.white_rook.image, 
        board.position(pieces.white_king.x), 
        board.position(pieces.white_king.y)
        )

        love.graphics.draw(
        pieces.black_pawn.image, 
        board.position(pieces.black_pawn.first.x), 
        board.position(pieces.black_pawn.first.y)
        )

        love.graphics.draw(
        pieces.black_pawn.image, 
        board.position(pieces.black_pawn.second.x), 
        board.position(pieces.black_pawn.second.y)
        )

        love.graphics.draw(
        pieces.black_pawn.image, 
        board.position(pieces.black_pawn.third.x), 
        board.position(pieces.black_pawn.third.y)
        )

        love.graphics.draw(
        pieces.black_pawn.image, 
        board.position(pieces.black_pawn.fourth.x), 
        board.position(pieces.black_pawn.fourth.y)
        )

        love.graphics.draw(
        pieces.black_pawn.image, 
        board.position(pieces.black_pawn.fifth.x), 
        board.position(pieces.black_pawn.fifth.y)
        )

        love.graphics.draw(
        pieces.black_pawn.image, 
        board.position(pieces.black_pawn.sixth.x), 
        board.position(pieces.black_pawn.sixth.y)
        )

        love.graphics.draw(
        pieces.black_pawn.image, 
        board.position(pieces.black_pawn.seventh.x), 
        board.position(pieces.black_pawn.seventh.y)
        )

        love.graphics.draw(
        pieces.black_pawn.image, 
        board.position(pieces.black_pawn.eight.x), 
        board.position(pieces.black_pawn.eight.y)
        )

        love.graphics.draw(
        pieces.black_knight.image, 
        board.position(pieces.black_knight.first.x), 
        board.position(pieces.black_knight.first.y)
        )

        love.graphics.draw(
        pieces.black_knight.image, 
        board.position(pieces.black_knight.second.x), 
        board.position(pieces.black_knight.second.y)
        )

        love.graphics.draw(
        pieces.black_bishop.image, 
        board.position(pieces.black_bishop.first.x), 
        board.position(pieces.black_bishop.first.y)
        )

        love.graphics.draw(
        pieces.black_bishop.image, 
        board.position(pieces.black_bishop.second.x), 
        board.position(pieces.black_bishop.second.y)
        )

        love.graphics.draw(
        pieces.black_rook.image, 
        board.position(pieces.black_rook.first.x), 
        board.position(pieces.black_rook.first.y)
        )

        love.graphics.draw(
        pieces.black_rook.image, 
        board.position(pieces.black_rook.second.x), 
        board.position(pieces.black_rook.second.y)
        )

        love.graphics.draw(
        pieces.black_rook.image, 
        board.position(pieces.black_rook.first.x), 
        board.position(pieces.black_rook.first.y)
        )

        love.graphics.draw(
        pieces.black_rook.image, 
        board.position(pieces.black_rook.second.x), 
        board.position(pieces.black_rook.second.y)
        )

        love.graphics.draw(
        pieces.black_rook.image, 
        board.position(pieces.black_queen.x), 
        board.position(pieces.black_queen.y)
        )

        love.graphics.draw(
        pieces.black_rook.image, 
        board.position(pieces.black_king.x), 
        board.position(pieces.black_king.y)
        )
end

