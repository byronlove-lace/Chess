#!/bin/lua

_G.love = require("love")

function gen_board()

        local board = {}
        local letters = 'abcdefgh'
        --DUPES--

        for i = 1, 8 do
                for j = 1, 8 do
                        local letter = string.sub(letters, j, j) 
                        local square = letter..i
                        board[square] = 'E'
                end
        end
        
        local wp_count = 1
        local bp_count = 1

        for k, v in pairs(board) do
                if string.sub(k, 2, 2) == '2' then
                        board[k] = 'WP'..wp_count
                        wp_count = wp_count + 1
                end

                if string.match(k, "b1") then
                        board[k] = "WN1"
                end
                if string.match(k, "g1") then
                        board[k] = "WN2"
                end
                if string.match(k, "c1") then
                        board[k] = "WB1"
                end
                if string.match(k, "f1") then
                        board[k] = "WB2"
                end
                if string.match(k, "a1") then
                        board[k] = "WR1"
                end
                if string.match(k, "h1") then
                        board[k] = "WR2"
                end
                if string.match(k, "d1") then
                        board[k] = "WQ"
                end
                if string.match(k, "e1") then
                        board[k] = "WK"
                end


                if string.sub(k, 2, 2) == '7' then
                        board[k] = 'BP'..bp_count
                        bp_count = bp_count + 1
                end
                if string.match(k, "b8") then
                        board[k] = "BN1"
                end
                if string.match(k, "g8") then
                        board[k] = "BN2"
                end
                if string.match(k, "c8") then
                        board[k] = "BB1"
                end
                if string.match(k, "f8") then
                        board[k] = "BB2"
                end
                if string.match(k, "a8") then
                        board[k] = "BR1"
                end
                if string.match(k, "h8") then
                        board[k] = "BR2"
                end
                if string.match(k, "d8") then
                        board[k] = "BQ"
                end
                if string.match(k, "e8") then
                        board[k] = "BK"
                end
        end

        return board
end

function algebra_coords(square) 
        local letters = 'abcdefgh'
        local numbers = '87654321'
        --DUPES--
        local x_letter = string.sub(square, 1, 1)
        local y_number = tonumber(string.sub(square, 2, 2))
        local x = 0
        local y = 0
        x = string.find(letters, x_letter)
        y = string.find(numbers, y_number)
        return x, y
end

function coords_algebra(x, y)
        local letters = 'abcdefgh'
        local numbers = '87654321'
        local x_letter = string.sub(letters, x, x)
        local y_numbers = string.sub(numbers, y, y)
        --DUPES--
        alg = x_letter..y_numbers
        return alg
end

function white_pawn_moves(board, row, column) 

        local position = {row, column}
        local initial_square = coords_algebra(row, column)
        local single_forward = coords_algebra(row, column + 1)
        local double_forward = coords_algebra(row, column + 2)
        local take_left = coords_algebra(row - 1, column + 1)
        local take_right = coords_algebra(row + 1, column + 1)
        local moves = {}
        
        if row < 8 then

                if board[single_forward] == 'E' then
                        table.insert(moves, single_forward)
                end

                if board[double_forward] == 'E' then
                        table.insert(moves, double_forward)
                end

                if column > 1 then
                        if string.sub(board[take_left], 1, 1) == 'B' then
                                table.insert(moves, take_left)
                        end
                --insert ep logic: need a func that logs moves-- 
                end

                if column < 8 then 
                        if string.sub(board[take_right], 1, 1) == 'B' then
                                table.insert(moves, take_right)
                        end
                end
                --insert ep logic: need a func that logs moves-- 
        end
        for i = 1, #moves do
                moves[i] = algebra_coords(moves[i])
                return {moves} 
        end
end

function calc_moves(board, x, y)
        local position = coords_algebra(x, y)
        print(board[position])
        local target = board[position]
        -- how can i turn check here?
        if string.sub(board[position], 2, 2) == 'P' then
                local moves = white_pawn_moves(board, x, y)
                print('hi')
        end
end


function love.load()

        board = {
                image = love.graphics.newImage('sprites/board.png'),
                border = 7,
                square = 88.25,
                state = gen_board(),
                turn = "white",
                last_move = nil
        }

        function board.position (coord)

                coord = coord - 1
                local position = board.border + (board.square * coord) + 15.5

                return position

        end


        pieces = {
                white_pawn = {
                        image = love.graphics.newImage('sprites/white_pawn.png'),
                        first = {
                                in_play = true,
                                moves = {},
                                x = 1,
                                y = 7
                        },
                        second = {
                                in_play = true,
                                moves = {},
                                x = 2,
                                y = 7,
                        },
                        third = {
                                in_play = true,
                                moves = {},
                                x = 3,
                                y = 7,
                        },
                        fourth = {
                                in_play = true,
                                moves = {},
                                x = 4,
                                y = 7,
                        },
                        fifth = {
                                in_play = true,
                                moves = {},
                                x = 5,
                                y = 7,
                        },
                        sixth = {
                                in_play = true,
                                moves = {},
                                x = 6,
                                y = 7,
                        },
                        seventh = {
                                in_play = true,
                                moves = {},
                                x = 7,
                                y = 7,
                        },
                        eight = {
                                in_play = true,
                                moves = {},
                                x = 8,
                                y = 7,
                        }
                },

                white_knight = {
                        image = love.graphics.newImage('sprites/white_knight.png'),
                        first = {
                                in_play = true,
                                moves = {},
                                x = 2,
                                y = 8,
                        },
                        second = {
                                in_play = true,
                                moves = {},
                                x = 7,
                                y = 8
                        }
                },

                white_bishop = {
                        image = love.graphics.newImage('sprites/white_bishop.png'),
                        first = {
                                in_play = true,
                                moves = {},
                                x = 3,
                                y = 8
                        },
                        second = {
                                in_play = true,
                                moves = {},
                                x = 6,
                                y = 8
                        }
                },

                white_rook = {
                        image = love.graphics.newImage('sprites/white_rook.png'),
                        first = {
                                in_play = true,
                                moves = {},
                                x = 1,
                                y = 8
                        },
                        second = {
                                in_play = true,
                                moves = {},
                                x = 8,
                                y = 8
                        }
                },

                white_queen = {
                        image = love.graphics.newImage('sprites/white_queen.png'),
                        x = 4,
                        y = 8
                },

                white_king = {
                        image = love.graphics.newImage('sprites/white_king.png'),
                        castle_left = true,
                        castle_right = true,
                        check = false,
                        x = 5,
                        y = 8
                },

                black_pawn = {
                        image = love.graphics.newImage('sprites/black_pawn.png'),
                        first = {
                                in_play = true,
                                moves = {},
                                x = 1,
                                y = 2
                        },
                                second = {
                                in_play = true,
                                moves = {},
                                x = 2,
                                y = 2,
                                },
                                third = {
                                in_play = true,
                                moves = {},
                                x = 3,
                                y = 2,
                                },
                                fourth = {
                                in_play = true,
                                moves = {},
                                x = 4,
                                y = 2,
                                },
                                fifth = {
                                in_play = true,
                                moves = {},
                                x = 5,
                                y = 2,
                                },
                                sixth = {
                                in_play = true,
                                moves = {},
                                x = 6,
                                y = 2,
                                },
                                seventh = {
                                in_play = true,
                                moves = {},
                                x = 7,
                                y = 2,
                                },
                                eight = {
                                in_play = true,
                                moves = {},
                                x = 8,
                                y = 2,
                                }
                        },

                black_knight = {
                        image = love.graphics.newImage('sprites/black_knight.png'),
                        first = {
                                in_play = true,
                                moves = {},
                                x = 2,
                                y = 1,
                        },
                        second = {
                                in_play = true,
                                moves = {},
                                x = 7,
                                y = 1,
                        }
                },

                black_bishop = {
                        image = love.graphics.newImage('sprites/black_bishop.png'),
                        first = {
                                in_play = true,
                                moves = {},
                                x = 3,
                                y = 1,
                        },
                        second = {
                                in_play = true,
                                moves = {},
                                x = 6,
                                y = 1,
                        }
                },

                black_rook = {
                        image = love.graphics.newImage('sprites/black_rook.png'),
                        first = {
                                in_play = true,
                                moves = {},
                                x = 1,
                                y = 1,
                        },
                        second = {
                                in_play = true,
                                moves = {},
                                x = 8,
                                y = 1,
                        }
                },

                black_queen = {
                        image = love.graphics.newImage('sprites/black_queen.png'),
                        x = 4,
                        y = 1
                },

                black_king = {
                        image = love.graphics.newImage('sprites/black_king.png'),
                        castle_left = true,
                        castle_right = true,
                        check = false,
                        x = 5,
                        y = 1
                },
        }

        selector = {
                choose = false,
                x = 1,
                y = 1
        }

end

function love.update(dt)

        if turn ~= turn then
                --boardcheck
                --
                for i = 1, #board do
                        for j = 1, #board[i] do

                                        if string.sub(board[i][j][2], 2, 2) == "P" then
                                                table.insert(movable_pieces, p_moves(turn, i, j))
                                        end
                                        if string.sub(board[i][j][2], 2, 2) == "N" then
                                                table.insert(movable_pieces, n_moves(turn, i, j))
                                        end
                                        if string.sub(board[i][j][2], 2, 2) == "B" then
                                                table.insert(movable_pieces, b_moves(turn, i, j))
                                        end
                        end
                end

        end

        if selector.choose == false then
                function love.keypressed(key, scancode)

                        if scancode == "j" then
                                selector.y = selector.y + 1
                        end

                        if scancode == "k" then
                                selector.y = selector.y - 1 
                        end

                        if scancode == "h" then
                                selector.x = selector.x - 1 
                        end

                        if scancode == "l" then
                                selector.x = selector.x + 1
                        end

                        if scancode == "f" then
                                calc_moves(board.state, selector.x, selector.y)
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
        board.border + board.square * (selector.x - 1), 
        board.border + board.square * (selector.y - 1), 
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
        pieces.white_queen.image, 
        board.position(pieces.white_queen.x), 
        board.position(pieces.white_queen.y)
        )

        love.graphics.draw(
        pieces.white_king.image, 
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
        pieces.black_queen.image, 
        board.position(pieces.black_queen.x), 
        board.position(pieces.black_queen.y)
        )

        love.graphics.draw(
        pieces.black_king.image, 
        board.position(pieces.black_king.x), 
        board.position(pieces.black_king.y)
        )
end
