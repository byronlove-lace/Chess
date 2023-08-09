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

--[[
-- also have table.insert(table, val, position)
-- color evidenced in odd / even turn 
-- structure: 2D array containing 
lets assume we have the table set up in 2D arr
8x8
we'll assume the first index will account for letters
second for numbers

the pawn moves forward: [x][y + 1]
the pawn takes: [x +/- 1][y + 1]
pawn_conditions: cannot move forward if blocked
* this is why a 3D list may be better, since we could simply say 
pawn can move if [x][y + 1][2] == 'Empty'
where the 3d array can contain: 1. square, 2. Occupancy, 3. Possible other state condition re
** oooooh I can use the flexibility of the table here! 
(actually, this is prolly a bad idea: too much complexity)
*** don't bother with square; it's evident from indexing and can be gotten with a simple function
*** I should include color; while chess notation uses odds/evens turn number to indicate 
white / black, this is to summarize the moves in a game; it's not good for programming chess
hi
e.g. color needs to be assessible to verify if an attack is possible or is the piece friendly *
*** NEED TO CONFIRM IF LUA will maintain order of nested tables 

CONDITION LOGIC:
the condition logic should be external to the board
and implamented through logic gate evaluation 
        for square on board:
                if [x][y][2] is 'W'/'B':
                        if [x][y][1] = 'P'
                                ... pawn move evaluation ...
                                
                                
- asses possible moves off all availible pieces
- player chooses piece

Knight Moves:


knight_conditions: 
        availible tiles: this could be quite easy to check as lua will simply return nil
        we start with the Knights possible movement pattern at the centre of the board
        if [x][y] is not nil then move is possible 
        *of course, knights movements won't be affected by z conditions

bishop_moves:
[x +/- n][y +/- n] 

bishop_conditions:
        availible tiles 

rook_moves:
[x +/- n][y] or [y +/- n][x]

rook_conditions:
        castle_condtion: 
                [x][y][z]

I know what some of the conditions are
but how do i structure that data 
conditions are linked to the pieces,
but they are also dependent on 
board_location - queen a pawn, castling_rules, en_passant
relative positioning to other pieces: attacking/blocking for all pieces aside from knights, 
relative positioning to specific pieces: check (cannot move into, must respond when it happens), check_mate, en_passant, castling
the previous actions of other pieces: en_passant, castling,
the lack of actions of other pieces
*could this be something I could use linked lists to
deal with -- I have no idea, i don't even know how linked
lists work 
        



*a central rule of chess and one of the hardest to account 
for will be movement in check
since the only pieces player can move while in check
are ones that will get the player out of check 

check_evaluation needs to happen at the end of every turn:
        all possible attack vectors of the moved piece are listed
        for i in attack_vectors:
                if [x][y][1] == 'K'
        check = true

        opp_turn: 
        if_check = true then
                
        :
-- o
]]
