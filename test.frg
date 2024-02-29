#lang forge/bsl

open "c4.frg"

test suite for wellformed { //wellformed tests 
    test expect {boardContra : {
        all b: Board | {
            allBoardsWellformed
            wellformed[b]
            notWellformed
        }
    } is unsat} 
    test expect { thisAndAll : {
        all b: Board | {
            allBoardsWellformed
            wellformed[b]
        }
    } is sat} 
}

test suite for balanced { //Balanced tests
    test expect { balancedCheckR : {
        all b: Board | {
            rTurn[b]
            balanced[b]
        }
    } is sat}
    test expect { balancedCheckY : {
        all b: Board | {
            yTurn[b]
            balanced[b]
        }
    } is sat}
    test expect { balancedCheckWrong : {
        all b: Board | {
            not yTurn[b] and not rTurn[b]
            balanced[b]
        }
    } is unsat}
}

test suite for winning { //Winning tests
    test expect { bothWin: 
        {
            all b: Board | {
                winning[b, Y]
                winning[b, R]
                wellformed[b]
            } 
        } is unsat
    }
    test expect {rWin: 
        {
            all b: Board | {
                some b1: Board | {
                    b1.board[0][0] = R
                    b1.board[0][1] = R
                    b1.board[0][2] = R
                    b1.board[0][3] = R
                    b1.board[0][4] = Y
                    b1.board[0][5] = Y
                    b1.board[0][6] = Y
                    no b1.board[1][0]
                    no b1.board[1][1]
                    no b1.board[1][2]
                    no b1.board[1][3]
                    no b1.board[1][4]
                    no b1.board[1][5]
                    no b1.board[1][6]
                    wellformed[b1]
                    winning[b1, R]
                }
            } 
        } is sat
    }
    test expect {yDiagWin: 
        {
            all b: Board | {
                some b1: Board | {
                    b1.board[0][0] = Y
                    b1.board[1][1] = Y
                    b1.board[2][2] = Y
                    b1.board[3][3] = Y
                    b1.board[0][4] = R
                    b1.board[0][5] = R
                    b1.board[0][6] = R
                    wellformed[b1]
                    winning[b1, Y]
                }
            } 
        } is sat
    }

}

test suite for move {
    /*
        For some reason, this test COMPLETELY broke the rest of the tests. 
        Not only did the sat contradiction clearly contradict other predicates 
        tested predicates above, but it also frequently broke the rest of the file
        whenever additions were made, syntactic or otherwise. These errors popped 
        up on the rest of the testing suites, and went away when the test was commented out. 
        As a result, our move tests are not as robust as we initially planned. 

        The only way we could even get the file to run was if we commented this section out, 
        deleted the entire script, ran the empty file, then repasted the code in and ran it again. 
        We could then finally run the test below after uncommenting it, only for it to spit out 
        garbage values we've clearly tested against, such as negative board coordinates with red or 
        yellow pieces in them. Even if we just commented out the test, syntax errors would pop up and
        sometimes stop the code from running (other times it would run anyway).

        We hope this documentation is helpful for troubleshooting forge!
    */

    // test expect { myBadMoveCheck : {

    //     all disj pre, post: Board, r, c: Int | {
    //         not init[pre] and not init[post] 
    //         #{row, col: Int | pre.board[row][col] = R} = 3
    //         move[pre, r, c, Y, post]
    //         wellformed[pre]
    //         wellformed[post]
    //         yTurn[pre]
    //         rTurn[pre]
    //         yTurn[post]
            
    //     }
    // } is unsat}
    test expect { myMoveCheck : {
        all b: Board | {
            all disj pre, post: Board, r, c: Int | {
                move[pre, r, c, R, post] implies {
                    rTurn[pre]
                    yTurn[post] 
                }
                move[pre, r, c, Y, post] implies {
                    yTurn[pre]
                    rTurn[post] 
                }
                wellformed[pre]
                wellformed[post]
            }
        }
    } is sat}
    
    
}
