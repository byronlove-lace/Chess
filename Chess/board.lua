#!/bin/lua

function table_len(table)
        local count = 0
        for i in pairs(table) do count = count + 1 end
        return count
end

local board = {}
local letters = 'abcdefgh'
local pieces = { "K", "Q", "R", "B", "N", "P" }

for l = 1, 8 do
        local letter = string.sub(letters, l, l)
        for n = 1, 8 do
                local square = letter..n
                board[square] = "[]"
        end
end
for k, v in pairs(board) do
        if string.sub(k, 2, 2) == "2" then
                board[k] = 'P'
        end
        if string.sub(k, 2, 2) == "7" then
                board[k] = 'P'
        end
end

board.b1, board.g1, board.b8, board.g8 = 'N', 'N', 'N', 'N' 
board.c1, board.f1, board.c8, board.f8 = 'B', 'B', 'B', 'B' 
board.a1, board.h1, board.a8, board.h8 = 'R', 'R', 'R', 'R' 
board.d1, board.d8 = 'Q', 'Q' 
board.e1, board.e8 = 'K', 'K' 

for k, v in pairs(board) do
        print(k, v)                
end

