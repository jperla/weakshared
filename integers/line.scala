import scala.io.Source
import java.util.ArrayList
import org.apache.commons.math.optimization.linear._
import java.util.Collection;
import org.apache.commons.math.optimization.GoalType;



object HelloWorld {
  type Guess = Array[Int]
  
  def solveRelaxation(table : Array[Array[Double]], guessed : Guess) : Double = {
    // describe the optimization problem
    var f = new LinearObjectiveFunction(Array[Double]( 2, -1 ), -5.0);
    var constraints = new ArrayList() : Collection[LinearConstraint];
    constraints.add(new LinearConstraint(Array[Double]( 1, 2 ), Relationship.LEQ, 6.0));
    constraints.add(new LinearConstraint(Array[Double]( 3, 2 ), Relationship.LEQ, 12.0));
    constraints.add(new LinearConstraint(Array[Double]( 0, 1 ), Relationship.GEQ, 0.0));
    // create and run the solver
    var solution = new SimplexSolver().optimize(f, constraints, GoalType.MAXIMIZE, false);
    // get the solution
    val p = solution.getPoint();
    val min = solution.getValue();

    /*
    for (i <- 0 until p.size) {
        println("p: " + p(i))
    }
    println("min: " + min)
    */

    return Double.PositiveInfinity 
  }

  def nextSubtree(sizeOfSolution : Int, guess : Guess) : Guess = {
    val s = guess.size
    // go back to last zero

    var i = s-1
    while (i >= 0 && guess(i) == 1) {
        i -= 1
    }
    var lastZero = i
    
    if (lastZero > -1) {
      val newGuess = new Array[Int](lastZero + 1)
      for(i <- 0 until newGuess.size) {
        newGuess.update(i, guess(i))
      }
      newGuess.update(lastZero, 1)
      return newGuess
    } else {
      // all 1's, so return null? itself?
      return null
    }
  }

  // this is depth first
  def nextSolution(sizeOfSolution : Int, guess : Guess) : Guess = {
    val s = guess.size
    if (s == sizeOfSolution) {
      if (guess(s - 1) == 1) {
        // done, hit end, remove 1's, 
        return nextSubtree(sizeOfSolution, guess)
      } else {
        guess(s - 1) = 1
        return guess
      }
    } else {
      return guess ++ Array(0)
    }
  }


  def arrayToString(guess : Array[Int]) : String = {
    if (guess != null) {
      return "(" + (guess.map(i => i.toString).reduceLeft(_ + ", " + _)) + ")"
    } else {
      return "null"
    }
  }

  def isFeasible(table : Array[Array[Double]], guess : Array[Int]) : Boolean = {
    for(row <- table) {
        val sum = guess.zip(row).map(i => i._1 * i._2).reduceLeft(_+_)
        if (sum > row(row.size-1)) {
            return false
        }
    }
    return true
  }

  def main(args: Array[String]) {
    // get the data into array of array (table)
    val source = Source.fromFile("medium.csv")
    val lines = source.mkString.split("\n")
    source.close()
    val table = lines.map(l => l.split(",").map(i => i.toDouble))

    val sizeOfSolution = table(0).size - 1
    println("size of solution: " + sizeOfSolution);
    var lowerBound = 0.0
    var bestGuess = Array[Int]()
    var upperBound = Double.PositiveInfinity

    var oldGuess = Array[Int]()
    var guess = Array[Int](0)
    var i = 0
    while(guess != null && oldGuess != guess) {
        i += 1

        if (guess.size == sizeOfSolution) {
            if (isFeasible(table, guess)) {
              // todo: n squared?
              val score = guess.reduceLeft[Int](_+_)
              if (score > lowerBound) {
                lowerBound = score
                bestGuess = guess.clone()
              }
            }

            oldGuess = guess.clone()
            guess = nextSubtree(sizeOfSolution, guess.clone())
        } else {
          var upperBound = solveRelaxation(table, guess)
          if (upperBound < lowerBound) {
            println("skip subtree")
            oldGuess = guess.clone()
            guess = nextSubtree(sizeOfSolution, guess.clone())
          } else {
            oldGuess = guess.clone()
            guess = nextSolution(sizeOfSolution, guess.clone())
          }
        }

        println("guess: " + arrayToString(guess));
        println("lower bound: " + lowerBound);
    }

    println("num iterations: " + i);
    println("guess: " + arrayToString(guess));
    println("best guess: " + arrayToString(bestGuess));
  }
}
