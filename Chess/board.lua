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
local last_move = {"WP", "d2", "d4"} 
-- piece, from, to

-- Pawn Logic
-- is there a better way to handle turn state here? 

function p_moves(turn, row, column) 
        local position = {row, column}
        local moves = {}        
        
        if turn == "W" then
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
                        if column < 8 then if string.sub(board[row + 1][column + 1][2], 1, 1) == "B" then
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

                        return {"P", position, moves} 
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

                        return {"P", position, moves} 
                end
        end
end

function n_moves(turn, row, column) 

        local possible_moves = {}
        local position = {row, column}
        local knight_moves = { 
        {row + 2, column + 1}, 
        {row + 2, column - 1}, 
        {row - 2, column + 1}, 
        {row - 2, column - 1}, 
        {row + 1, column + 2}, 
        {row + 1, column - 2}, 
        {row - 1, column + 2}, 
        {row - 1, column - 2}, 
}
        for i = 1, #knight_moves do

                local r = knight_moves[i][1]
                local c = knight_moves[i][2]
                if board[r] ~= nil then
                        if board[r][c] ~= nil then
                                if string.sub(board[r][c][2], 2, 2) ~= turn then
                                        table.insert(possible_moves, knight_moves[i]) 
                                end
                        end
                end
        end
        return {"N", position, possible_moves}
end

function valid_move(max_moves)
        valid_moves = {}
        for i = 1, #max_moves do
                for j = 1, #max_moves[i] do
                        local r = max_moves[i][j][1] 
                        local c = max_moves[i][j][2] 
                        if board[r] ~= nil then
                                if board[r][c] ~= nil then
                                        if string.sub(board[r][c][2], 1, 1) == "W" then
                                                break
                                        end
                                        if string.sub(board[r][c][2], 1, 1) == "B" then
                                                table.insert(valid_moves, {r, c}) 
                                                break
                                        end
                                        if board[r][c][2] == "E" then
                                                table.insert(valid_moves, {r, c})
                                        end
                                end
                        end
                end
        return valid_moves                
        end
end

function b_moves(turn, row, column)

        local position = {row, column}
        local bishop_moves = {}
        local north_east = {} 
        local north_west = {}
        local south_east = {}
        local south_west = {}
        local possible_moves = {}

        for i = 1, 7 do
                north_east[i] = {row + i, column + i}
                north_west[i] = {row + i, column - i}
                south_east[i] = {row - i, column + i}
                south_west[i] = {row - i, column - i}
        end

        bishop_moves = {
                north_east, 
                north_west,
                south_east,
                south_west,
        }

        return {'B', position, valid_move(bishop_moves)}
end
                        
function r_moves(turn, row, column)
        local north = {}
        local south = {}
        local west = {}
        local east = {}

        for i = 1, 7 do
                north[i] = {row + 1}
                south[i] = {row - 1}
                west[i] = {column + 1}
                east[i] = {column - 1}
        end

        local rook_moves = {north, south, east, west}
        return {"R", position, valid_move(rook_moves)}
end

local movable_pieces = {}

for i = 1, #board do
        for j = 1, #board[i] do
                if string.sub(board[i][j][2], 1, 1) == turn then
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

