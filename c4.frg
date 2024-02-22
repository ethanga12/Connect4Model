#lang forge/bsl

abstract sig Player {}

one sig R, Y extends Player{}

sig Board {
    board: pfunc Int -> Int -> Player
}

one sig Game {
    first: one Board,
    next: pfunc Board -> Board
}

pred wellformed[b: Board] {
    all row, col: Int | {
        (row < 0 or row > 6 or col < 0 or col > 7) implies 
            no b.board[row][col]
    }
}

pred allBoardsWellformed { all b: Board | wellformed[b]}

pred init[b: Board] {
    all row, col: Int | no b.board[row][col]
}

pred rTurn[b: Board] {
    #{row, col: Int | b.board[row][col] = R}
    = 
    #{row, col: Int | b.board[row][col] = Y}
}

pred yTurn[b: Board] {
    #{row, col: Int | b.board[row][col] = R}
    = 
    add[#{row, col: Int | b.board[row][col] = Y}, 1]
}

pred balanced[b: Board] {
    yTurn[b] or rTurn[b] 
}

pred winning[b: Board, p: Player] {
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

pred move[pre: Board,
            r, c: Int,
            turn: Player,
            post: Board] {
    no pre.board[r][c]
    turn = R implies rTurn[pre]
    turn = Y implies yTurn[pre]

    all p: Player | not winning[pre, p]

    r >= 0
    r <= 6
    c >= 0
    c <= 7

    post.board[r][c] = turn

    all r2: Int, c2: Int | (r != r2 or c != c2) implies {
        post.board[r2][c2] = pre.board[r][c]
    }
}

pred doNothing[pre, post: Board] {
    some p: Player | winning[pre, p]

    all r, c: Int | {
        pre.board[r][c] = post.board[r][c]
    }
}

pred game_trace {
    init[Game.first]

    all b: Board | {
        some Game.next[b] implies {
            (some r, c: Int, p: Player | 
                move[b, r, c, p, Game.next[b]])
            or 
            doNothing[b, Game.next[b]]
            -- TODO: ensure X moves first (from lecture)
        }
    }
}


run {
    all b: Board | {
         wellformed[b]
   
        some pre, post: Board | {
            some row, col: Int, p: Player | 
                move[pre, row, col, p, post]
        }
    }
}


// run { 
//     game_trace
//     all b: Board | { 
//         some r,c: Int | {
//             r >=0 r <= 6
//             c >=0 c <= 7
//             no b.board[r][c]
//         }
//     }
// } for 10 Board for {next is linear}
