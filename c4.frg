#lang forge/bsl
option run_sterling "c4vis.js"

/*
*/

abstract sig Player {}

one sig R, Y extends Player{} //red and yellow players!

sig Board { //Board sig
    board: pfunc Int -> Int -> Player
}

one sig Game { //Game sig
    first: one Board,
    next: pfunc Board -> Board
}

pred wellformed[b: Board] { //Tests that the board is wellformed
    all row, col: Int | {
        (row < 0 or row > 6 or col < 0 or col > 7) implies 
            no b.board[row][col]
        ((b.board[row][col] = R or b.board[row][col] = Y) and row >= 1) implies { //inductive falling
            b.board[subtract[row, 1]][col] = R or b.board[subtract[row, 1]][col] = Y
        }
    }
    #{row, col: Int | b.board[row][col] = R} >= #{row, col: Int | b.board[row][col] = Y} and #{row, col: Int | b.board[row][col] = R} < add[#{row, col: Int | b.board[row][col] = Y}, 2] //R moves first
}

pred notWellformed { //counter predicate for testing
    some b: Board | {
        b.board[2][0] = R
        no b.board[1][0]
    }
    some b: Board | {
        b.board[0][-9] = R
    }
     some b: Board | {
        b.board[-7][-7] = R
    }

}
pred allBoardsWellformed { all b: Board | wellformed[b]} // predicate for testing

pred init[b: Board] { //initializes game state
    all row, col: Int | no b.board[row][col]
}

pred rTurn[b: Board] { //checks if it is red's turn
    #{row, col: Int | b.board[row][col] = R}
    = 
    #{row, col: Int | b.board[row][col] = Y}
}

pred yTurn[b: Board] {//checks if it is yellow's turn
    #{row, col: Int | b.board[row][col] = R}
    = 
    add[#{row, col: Int | b.board[row][col] = Y}, 1]
}

pred balanced[b: Board] {//checks the board is balanced
    yTurn[b] or rTurn[b] 
}

pred winningCheck[b: Board, p: Player] { //checks if a player is winning
    (some r, c: Int | { //inductive horizontal winning
        b.board[r][c] = p
        b.board[r][add[c, 1]] = p
        b.board[r][add[c, 2]] = p
        b.board[r][add[c, 3]] = p
    })
    or 
    (some r, c: Int | {//inductive vertical winning
        b.board[r][c] = p
        b.board[add[r, 1]][c] = p
        b.board[add[r, 2]][c] = p
        b.board[add[r, 3]][c] = p
    })
    or 
    (some r, c: Int | {//inductive diagonal winning
        b.board[r][c] = p
        b.board[add[r, 1]][add[c, 1]] = p
        b.board[add[r, 2]][add[c, 2]] = p
        b.board[add[r, 3]][add[c, 3]] = p
    })
}

pred winning[b: Board, p: Player] { //Ensures one winner
    wellformed[b]
    winningCheck[b, p]
    p = R implies {
        not winningCheck[b, Y]
    }
    p = Y implies {
        not winningCheck[b, R]
    }

    
    
    
}

pred move[pre: Board,
            r, c: Int,
            turn: Player,
            post: Board] { //move with bounds
    wellformed[pre] //ensure wellformed at the beginning
    no pre.board[r][c]
    turn = R implies rTurn[pre]
    turn = Y implies yTurn[pre]

    all p: Player | not winning[pre, p]

    r >= 0
    r <= 6
    c >= 0
    c <= 7

    post.board[r][c] = turn
    wellformed[post] //ensure welformed at the end
    all r2: Int, c2: Int | (r != r2 or c != c2) implies {
            post.board[r2][c2] = pre.board[r2][c2]
    }
   
}

pred doNothing[pre, post: Board] { //do nothing if someone wins
    some p: Player | winning[pre, p]

    all r, c: Int | {
        pre.board[r][c] = post.board[r][c]
    }
}

pred game_trace {
    init[Game.first]
    no sprev: Board | Game.next[sprev] = Game.first //no Loop
    all b: Board | some Game.next[b] implies {
            balanced[b]
            some r, c: Int, p: Player | 
                move[b, r, c, p, Game.next[b]]
            or 
            doNothing[b, Game.next[b]]
    }
}

//NON TRACE RUNS, USE THESE TO SEE BASE RULES FUNCITON (play around if you like!)
// run {
//     all b: Board | {
//          wellformed[b]
   
//         some pre, post: Board | {
//             wellformed[pre]
//             wellformed[post]
//             some row, col: Int, p: Player | {
//                 wellformed[pre]
//                 winning[pre, p]
//             }
//         }
//         // some pre, post: Board | {
//         //     some row, col: Int, p: Player | 
//         //         winning[pre, p]
//         // }
//     }
// } for 2 Board

//TRACE BASED AND HIGHER LEVEL RUN STATEMENTS
// run { 
//     game_trace //game trace
//     some b : Board | { //draw conditions
//         #{row, col: Int | b.board[row][col] = R} = 28
//         wellformed[b]
//         balanced[b]
//         not winning[b, R] and not winning[b, Y]
        
//     }
    
// } for 1 Board, 7 Int // increased bitwidth to 7 for draw instance
