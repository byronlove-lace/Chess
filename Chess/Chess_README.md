
# Chess

## Goals
- [ ] Create 2D array for board
- [X] Create pawn game logic
    - [ ] Unit test
- [ ] Create bishop logic
- [ ] Create bishop logic

## Notes
### Game Logic

#### Condition Logic:
the condition logic should be external to the board
and implamented through logic gate evaluation 
        for square on board:
                if [x][y][2] is 'W'/'B':
                        if [x][y][1] = 'P'
                                ... pawn move evaluation ...
- asses possible moves off all availible pieces
- player chooses piece

### Pawn Logic
the pawn moves forward: [x][y +/- 1]
the pawn takes: [x +/- 1][y +/- 1]
*y here depends on colour 

pawn_conditions: cannot move forward if blocked

### Knight Logic
Knight Moves:


knight_conditions: 
        availible tiles: this could be quite easy to check as lua will simply return nil
        we start with the Knights possible movement pattern at the centre of the board
        if [x][y] is not nil then move is possible 
        *of course, knights movements won't be affected by z conditions

### Bishop Logic
bishop_moves:
[x +/- n][y +/- n] 

bishop_conditions:
        availible tiles 

### Rook Logic
rook_moves:
[x +/- n][y] or [y +/- n][x]

rook_conditions:
        castle_condtion: 
                [x][y][z]

### Conditions Considerations
conditions are linked to the pieces,
but they are also dependent on 
board_location - queen a pawn, castling_rules, en_passant
relative positioning to other pieces: attacking/blocking for all pieces aside from knights, 
relative positioning to specific pieces: check (cannot move into, must respond when it happens), check_mate, en_passant, castling
the previous actions of other pieces: en_passant, castling,
the lack of actions of other pieces
       
### Check
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

### Queening a Pawn
the logic for queenme should use last_move and check after the player has moved
> player given a list of choices 
> player chooses 
> piece moves 
> last_move set 
> queenme_check (if lastmove[1] is "P" ... if lastmove[3], 2, 2 is "8") then P == Q
> next turn starts 
