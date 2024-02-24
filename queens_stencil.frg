#lang forge/bsl

// option run_sterling "vis.js"

sig Queen {}

// Hint: you can access a queen's position by doing Board.position[r][c]
one sig Board {
    position : pfunc Int -> Int -> Queen
}

// This function calculates the absolute difference between two integers
fun absDifference[m: Int, n: Int]: Int {
  let difference = subtract[m, n] {
    difference > 0 => difference else subtract[0, difference]
  }
}

pred Singleton {

  all row, col : Int | all q: Queen|{
    (row < 0 or row > 7 or 
    col <0 or col > 7) implies no Board.position [row][col]
    
    one row, col: Int{
      q = Board.position[row][col]
    }
  }

  
  
  // Fill in this predicate to ensure that:
  // Each queen is positioned on exactly one square
  // The board is 8x8, so Int ranges from 0-7
}


// Make sure no two queens attack each other.
pred notAttacking {



  all row, row2, col, col2: Int |{
    all q,q2:Queen{
      q != q2 implies {
        Board.position[row][col] = q and Board.position[row2][col2] =q2 implies {absDifference[row,col] != absDifference[row2,col2]} 
        q = Board.position[row][col] implies q2 != Board.position[row][col2]
        q = Board.position[row][col] implies q2 != Board.position[row2][col]
    }
  }
  }

  // Fill in this predicate to enforce that no two queens attack each other:
  // No two queens can be in the same row or column
  //some queen.Board.
  // No two queens can be on the same diagonal (hint: think about absDifference)
}


run {
  Singleton 
  notAttacking 
} for exactly 8 Queen
