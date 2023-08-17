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

local turn = "B"
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
                                                table.insert(moves, {row + 2, colum})
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
                                                table.insert(moves, {row - 2, colum})
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
        possible_moves = {}
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
                if board[i[1]][i[2]] == true then
                        table.insert(possible_moves, i) 
                end
        end
end

local movable_pieces = {}


for i = 1, #board do
        for j = 1, #board[i] do
                if string.sub(board[i][j][2], 1, 1) == turn then
                        if string.sub(board[i][j][2], 2, 2) == "P" then
                                table.insert(movable_pieces, p_moves(turn, i, j))
                        end
                end
        end
end
                
