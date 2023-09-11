#!/bin/lua

_G.love = require("love")

function gen_board(material)

        local board = {}
        local letters = 'abcdefgh'
        local count = {"first", "second", "third", "fourth", "fifth", "sixth", "seventh", "eight"}

        --DUPES--

        for i = 1, 8 do
                for j = 1, 8 do
                        local letter = string.sub(letters, j, j) 
                        local square = letter..i
                        board[square] = 'E'
                end
        end
        
        for k, v in pairs(board) do
                if string.sub(k, 2, 2) == '2' then
                        local x_letter = string.sub(k, 1, 1)
                        local pawn_num = string.find(letters, x_letter)
                        local pawn_count = count[pawn_num]
                        board[k] = material.white_pawn[pawn_count]
                end

                if string.match(k, "b1") then
                        board[k] = material.white_knight.first
                end
                if string.match(k, "g1") then
                        board[k] = material.white_knight.second
                end
                if string.match(k, "c1") then
                        board[k] = material.white_bishop.first
                end
                if string.match(k, "f1") then
                        board[k] = material.white_bishop.second
                end
                if string.match(k, "a1") then
                        board[k] = material.white_rook.first
                end
                if string.match(k, "h1") then
                        board[k] = material.white_rook.second
                end
                if string.match(k, "d1") then
                        board[k] = material.white_queen
                end
                if string.match(k, "e1") then
                        board[k] = material.white_king
                end


                if string.sub(k, 2, 2) == '7' then
                        local x_letter = string.sub(k, 1, 1)
                        local pawn_num = string.find(letters, x_letter)
                        local pawn_count = count[pawn_num]
                        board[k] = material.black_pawn[pawn_count]
                end
                if string.match(k, "b8") then
                        board[k] = material.black_knight.first
                end
                if string.match(k, "g8") then
                        board[k] = material.black_knight.second
                end
                if string.match(k, "c8") then
                        board[k] = material.black_bishop.first
                end
                if string.match(k, "f8") then
                        board[k] = material.black_bishop.second
                end
                if string.match(k, "a8") then
                        board[k] = material.black_rook.first
                end
                if string.match(k, "h8") then
                        board[k] = material.black_rook.second
                end
                if string.match(k, "d8") then
                        board[k] = material.black_queen
                end
                if string.match(k, "e8") then
                        board[k] = material.black_king
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
        print(x)
        print(y)
        return {x, y}
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

function wp_moves(board, col, row) 

        local position = {col, row}
        local initial_square = coords_algebra(col, row)
        local single_forward = coords_algebra(col, (row + 1))
        local double_forward = coords_algebra(col, (row + 2))
        local take_left = coords_algebra(col - 1, row + 1)
        local take_right = coords_algebra(col + 1, row + 1)
        local moves = {}
        
        if row < 8 then

                if board[single_forward] == 'E' then
                        table.insert(moves, single_forward)
                end

                if board[double_forward] == 'E' then
                        table.insert(moves, double_forward)
                end

                if col > 1 then
                        if string.sub(board[take_left], 1, 1) == 'B' then
                                table.insert(moves, take_left)
                        end
                --insert ep logic: need a func that logs moves-- 
                end

                if col < 8 then 
                        if string.sub(board[take_right], 1, 1) == 'B' then
                                table.insert(moves, take_right)
                        end
                end
                --insert ep logic: need a func that logs moves-- 
        end
        for i = 1, #moves do
                moves[i] = algebra_coords(moves[i])
        end
                return moves 
end

function calc_moves(board, x, y)
        local position = coords_algebra(x, y)
        local moves = {}
        -- how can i turn check here?
        if string.sub(board[position], 2, 2) == 'P' then
                moves = wp_moves(board, x, y)
        end
        return moves
end

function love.load()


        pieces = {
                white_pawn = {
                        image = love.graphics.newImage('sprites/white_pawn.png'),
                        first = {
                                in_play = true,
                                moves = {},
                                x = 1,
                                y = 7,
                                alg = "WP1"
                        },
                        second = {
                                in_play = true,
                                moves = {},
                                x = 2,
                                y = 7,
                                alg = "WP2"
                        },
                        third = {
                                in_play = true,
                                moves = {},
                                x = 3,
                                y = 7,
                                alg = "WP3"
                        },
                        fourth = {
                                in_play = true,
                                moves = {},
                                x = 4,
                                y = 7,
                                alg = "WP4"
                        },
                        fifth = {
                                in_play = true,
                                moves = {},
                                x = 5,
                                y = 7,
                                alg = "WP5"
                        },
                        sixth = {
                                in_play = true,
                                moves = {},
                                x = 6,
                                y = 7,
                                alg = "WP6"
                        },
                        seventh = {
                                in_play = true,
                                moves = {},
                                x = 7,
                                y = 7,
                                alg = "WP7"
                        },
                        eight = {
                                in_play = true,
                                moves = {},
                                x = 8,
                                y = 7,
                                alg = "WP8"
                        }
                },

                white_knight = {
                        image = love.graphics.newImage('sprites/white_knight.png'),
                        first = {
                                in_play = true,
                                moves = {},
                                x = 2,
                                y = 8,
                                alg = "WK1"
                        },
                        second = {
                                in_play = true,
                                moves = {},
                                x = 7,
                                y = 8,
                                alg = "WK2"
                        }
                },

                white_bishop = {
                        image = love.graphics.newImage('sprites/white_bishop.png'),
                        first = {
                                in_play = true,
                                moves = {},
                                x = 3,
                                y = 8,
                                alg = "WB1"
                        },
                        second = {
                                in_play = true,
                                moves = {},
                                x = 6,
                                y = 8,
                                alg = "WB2"
                        }
                },

                white_rook = {
                        image = love.graphics.newImage('sprites/white_rook.png'),
                        first = {
                                in_play = true,
                                moves = {},
                                x = 1,
                                y = 8,
                                alg = "WR1"
                                
                        },
                        second = {
                                in_play = true,
                                moves = {},
                                x = 8,
                                y = 8,
                                alg = "WR2"
                        }
                },

                white_queen = {
                        image = love.graphics.newImage('sprites/white_queen.png'),
                        x = 4,
                        y = 8,
                        alg = "WQ"
                },

                white_king = {
                        image = love.graphics.newImage('sprites/white_king.png'),
                        castle_left = true,
                        castle_right = true,
                        check = false,
                        x = 5,
                        y = 8,
                        alg = "WK"
                },

                black_pawn = {
                        image = love.graphics.newImage('sprites/black_pawn.png'),
                        first = {
                                in_play = true,
                                moves = {},
                                x = 1,
                                y = 2,
                                alg = "BP1"
                        },
                                second = {
                                in_play = true,
                                moves = {},
                                x = 2,
                                y = 2,
                                alg = "BP2"
                                },
                                third = {
                                in_play = true,
                                moves = {},
                                x = 3,
                                y = 2,
                                alg = "BP3"
                                },
                                fourth = {
                                in_play = true,
                                moves = {},
                                x = 4,
                                y = 2,
                                alg = "BP4"
                                },
                                fifth = {
                                in_play = true,
                                moves = {},
                                x = 5,
                                y = 2,
                                alg = "BP5"
                                },
                                sixth = {
                                in_play = true,
                                moves = {},
                                x = 6,
                                y = 2,
                                alg = "BP6"
                                },
                                seventh = {
                                in_play = true,
                                moves = {},
                                x = 7,
                                y = 2,
                                alg = "BP7"
                                },
                                eight = {
                                in_play = true,
                                moves = {},
                                x = 8,
                                y = 2,
                                alg = "BP8"
                                }
                        },

                black_knight = {
                        image = love.graphics.newImage('sprites/black_knight.png'),
                        first = {
                                in_play = true,
                                moves = {},
                                x = 2,
                                y = 1,
                                alg = "BK1"
                        },
                        second = {
                                in_play = true,
                                moves = {},
                                x = 7,
                                y = 1,
                                alg = "BK2"
                        }
                },

                black_bishop = {
                        image = love.graphics.newImage('sprites/black_bishop.png'),
                        first = {
                                in_play = true,
                                moves = {},
                                x = 3,
                                y = 1,
                                alg = "BB1"
                        },
                        second = {
                                in_play = true,
                                moves = {},
                                x = 6,
                                y = 1,
                                alg = "BB2"
                        }
                },

                black_rook = {
                        image = love.graphics.newImage('sprites/black_rook.png'),
                        first = {
                                in_play = true,
                                moves = {},
                                x = 1,
                                y = 1,
                                alg = "BR1"
                        },
                        second = {
                                in_play = true,
                                moves = {},
                                x = 8,
                                y = 1,
                                alg = "BR2"
                        }
                },

                black_queen = {
                        image = love.graphics.newImage('sprites/black_queen.png'),
                        x = 4,
                        y = 1,
                        alg = "BQ"
                },

                black_king = {
                        image = love.graphics.newImage('sprites/black_king.png'),
                        castle_left = true,
                        castle_right = true,
                        check = false,
                        x = 5,
                        y = 1,
                        alg = "BK"
                },
        }
        
        board = {
                image = love.graphics.newImage('sprites/board.png'),
                border = 7,
                square = 88.25,
                state = gen_board(pieces),
                turn = "white",
                last_move = nil
        }

        function board.position (coord)

                coord = coord - 1
                local position = board.border + (board.square * coord) + 15.5

                return position

        end

        selector = {
                choose = false,
                x = 1,
                y = 1,
                pos_moves = {}

        }

end

function love.update(dt)

        if turn ~= turn then
                --boardcheck
        end

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

                if scancode == "q" then
                        selector.choose = false
                end

                
                if scancode == "f" then
                        if selector.choose == false then
                                selector.pos_moves = calc_moves(board.state, selector.x, selector.y)
                                if #selector.pos_moves > 0 then
                                        selector.choose = true
                                        print('onetime')
                                end
                        else
                                for i = 1, #selector.pos_moves do
                                        if selector.x == selector.pos_moves[i][1] and selector.y == selector.pos_moves[i][2] then
                                                print('target aquired')
                                                selector.choose = false
                                        end
                                end
                                        
                                -- insert input for choosing moves here
                                -- if selector.choose == true
                                -- Problem: this square should have a piece that has possible moves; else enter should do nothing
                                -- end: selector.choose = false
                        end


                end
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

        -- if selector.choose == true logic should go here: highlight possible spaces; should change colour of selector/options
        if selector.choose == true then
                for i = 1, #selector.pos_moves do

                        love.graphics.setColor(255/255, 229/255, 180/255, 1)
                        love.graphics.setLineWidth(5)
                        love.graphics.rectangle(
                        "line", 
                        board.border + board.square * (selector.pos_moves[i][1] - 1), 
                        board.border + board.square * (selector.pos_moves[i][2] - 1), 
                        90, 
                        90
                        )
                        love.graphics.setColor(1, 1, 1, 1)
                        love.graphics.setLineWidth(1)
                end
        end

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
