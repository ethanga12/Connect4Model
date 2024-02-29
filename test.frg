#lang forge/bsl

open "c4.frg"

test suite for wellformed {
    test expect { boardContradicition : {
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

test suite for balanced {
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

test suite for winning {
    test expect { bothWin: 
        {
            all b: Board | {
                winning[b, Y]
                winning[b, R]
            } 
        } is unsat
    }

}

test suite for move {
    test expect { moveCheck : {
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
