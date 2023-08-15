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

                
for i = 1, #board do
        for j = 1, #board[i] do
                if string.sub(board[i][j][2], 1, 1) == turn then
                        if string.sub(board[i][j][2], 2, 2) == "P" then
                                -- single
                                if board[i + 1][j][2] == "E" then
                                        -- single

                                -- double
                                if string.sub(board[i][j][1], 2, 2) == "2" then
                                        if board[i + 1][j][2] == "E" then
                                                if board[i + 2][j][2] == "E" then
                                                       -- double 

                                -- queenme
                                if string.sub(board[i][j][1], 2, 2) == "7" then
                                        if board[i + 1][j][2] == "E" then
                                                -- queenme

                                -- take right
                                if string.sub(board[i + 1][j + 1][2], 1, 1) == "B" then
                                        -- take right

                                -- take left
                                if string.sub(board[i + 1][j - 1][2], 1, 1) == "B" then
                                        -- take left
                                
                                -- en passant 
                                if string.sub(board[i][j][1], 2, 2) == "5" then
                                        if last_turn[1] == "BP" then
                                                if board[i][j + 1][1] == last_turn[3] then
                                                        if board[i + 1][j + 1][1] == "E" then
                                                                -- en passant right
                                                if board[i][j - 1][1] == last_turn[3] then
                                                        if board[i + 1][j - 1][1] == "E" then
                                                                -- en passant left
                                if board[i][j][1] == "5" then
                                        if board[i + 1][j][2] == "E" then


                        





