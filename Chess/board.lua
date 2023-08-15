#!/bin/lua

function table_len(table)
        local count = 0
        for i in pairs(table) do count = count + 1 end
        return count
end

local board = {}
local letters = 'abcdefgh'

for i = 1, 8 do
        board[i] = {}
        for j = 1, 8 do
                local letter = string.sub(letters, j, j) 
                local square = letter..i
                board[i][j] = {square, "E"}
        end
end


for i = 1, #board do
        for j = 1, #board[i] do
                if string.sub(board[i][j][1], 2, 2) == "2" then
                        board[i][j][2] = "WP"
                end
                if string.sub(board[i][j][1], 2, 2) == "7" then
                        board[i][j][2] = "BP"
                end
                if string.match(board[i][j][1], "[bg][1]") then
                        board[i][j][2] = "WN"
                end
                if string.match(board[i][j][1], "[bg][8]") then
                        board[i][j][2] = "BN"
                end
                if string.match(board[i][j][1], "[cf][1]") then
                        board[i][j][2] = "WB"
                end
                if string.match(board[i][j][1], "[cf][8]") then
                        board[i][j][2] = "BB"
                end
                if string.match(board[i][j][1], "[ah][1]") then
                        board[i][j][2] = "WR"
                end
                if string.match(board[i][j][1], "[ah][8]") then
                        board[i][j][2] = "BR"
                end
                if board[i][j][1] == "d1" then
                        board[i][j][2] = "WQ"
                end
                if board[i][j][1] == "d8" then
                        board[i][j][2] = "BQ"
                end
                if board[i][j][1] == "e1" then
                        board[i][j][2] = "BQ"
                end
                if board[i][j][1] == "e8" then
                        board[i][j][2] = "BK"
                end
        end
end

-- Game Logic

local turn = "W"
local last_move = {"BP", "7b", "5b"} 
-- piece, from, to



-- Pawn Logic
-- is there a better way to handle turn state here? 

function p_moves(turn, row, column) 
        local position = {row, column}
        local moves = {}        
        
        if turn == "W" then
                -- single
                if board[row + 1][column][2] == "E" then
                        table.insert(moves, {row + 1, column}) 

                -- double
                        if string.sub(board[row][column][1], 2, 2) == "2" then
                                if board[row + 2][column][2] == "E" then
                                        table.insert(moves, {row + 2, colum})
                                end
                        end
                end

                -- take right
                if string.sub(board[row + 1][column + 1][2], 1, 1) == "B" then
                        table.insert(moves, {row + 1, colum + 1})
                end

                -- take left
                if string.sub(board[row + 1][column - 1][2], 1, 1) == "B" then
                        table.insert(moves, {row + 1, colum - 1})
                end
                
                -- en passant 
                if string.sub(board[row][column][1], 2, 2) == "5" then
                        if last_turn[1] == "BP" then
                                -- ep right
                                if board[row][column + 1][1] == last_turn[3] then
                                        if board[row + 1][column + 1][1] == "E" then
                                                table.insert(moves, {row + 1, colum + 1})
                                        end
                                end
                                -- ep left
                                if board[row][column - 1][1] == last_turn[3] then
                                        if board[row + 1][column - 1][1] == "E" then
                                                table.insert(moves, {row + 1, colum - 1})
                                        end
                                end
                        end
                end

                return {"P", position, moves} 
        end

        if turn == "B" then
                -- single
                if board[row - 1][column][2] == "E" then
                        table.insert(moves, {row - 1, column}) 

                -- double
                        if string.sub(board[row][column][1], 2, 2) == "7" then
                                if board[row - 2][column][2] == "E" then
                                        table.insert(moves, {row - 2, colum})
                                end
                        end
                end

                -- take left
                if string.sub(board[row - 1][column + 1][2], 1, 1) == "B" then
                        table.insert(moves, {row - 1, colum + 1})
                end

                -- take right
                if string.sub(board[row - 1][column - 1][2], 1, 1) == "B" then
                        table.insert(moves, {row - 1, colum - 1})
                end
                
                -- en passant 
                if string.sub(board[row][column][1], 2, 2) == "4" then
                        if last_turn[1] == "WP" then
                                -- ep left
                                if board[row][column + 1][1] == last_turn[3] then
                                        if board[row - 1][column + 1][1] == "E" then
                                                table.insert(moves, {row - 1, colum + 1})
                                        end
                                end
                                -- ep right
                                if board[row][column - 1][1] == last_turn[3] then
                                        if board[row - 1][column - 1][1] == "E" then
                                                table.insert(moves, {row - 1, column - 1})
                                        end
                                end
                        end
                end

                return {"P", position, moves} 
        end
end

local movable_pieces = {}

for i = 1, #board do
        for j = 1, #board[i] do
                if string.sub(board[i][j][2], 1, 1) == turn then
                        if string.sub(board[i][j][2], 2, 2) == "P" then
                                table.insert(movable_pieces, p_moves(turn, i, j))
                        
-- NOTES
        -- where do i put this logic?
        -- it doesn't really work within the moves / movable pieces table
        -- it should prolly be part of a wider game logic, like for castling
                -- if any of the left pawns move, then castle becomes impossible on that side
                -- castle_left = false
                -- if castle = true then additional moves are added to the kings movelist... 
                -- (need to think about that some more)
                -- likewise if any pawn is on the opposite side of the table
                -- queen_pawn = true
        -- !! the logic for queenme should use last_move and check after the player has moved
        -- player given a list of choices > player chooses > piece moves > last_move set >
        --    > queenme_check (if lastmove[1] is "P" ... if lastmove[3], 2, 2 is "8") then P == Q
        --    > next turn starts 
        --    queenme doesn't need to be included here as it doesn't pertain to a list of possible 
        --    moves 
