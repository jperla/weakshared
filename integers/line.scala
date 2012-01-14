import scala.io.Source
import java.util.ArrayList
import org.apache.commons.math.optimization.linear._
import java.util.Collection;
import org.apache.commons.math.optimization.GoalType;

import org.apache.commons.math.optimization.RealPointValuePair;
import org.apache.commons.math.optimization.linear.NoFeasibleSolutionException



object HelloWorld {
  type Guess = Array[Int]

  def getLHS(row : Array[Double]) : Array[Double] = {
    val sizeOfSolution = row.size - 1
    var lhs = new Array[Double](sizeOfSolution)
    for (i <- 0 until lhs.size) {
        lhs(i) = row(i)
    }
    return lhs
  }
  
  def solveRelaxation(table : Array[Array[Double]], guessed : Guess) : Double = {
    val sizeOfSolution = table(0).size - 1

    var objective = new Array[Double](sizeOfSolution)
    for(i <- 0 until objective.size) {
        objective.update(i, 1)
    }

    // describe the optimization problem
    var f = new LinearObjectiveFunction(objective, 0.0);
    var constraints = new ArrayList() : Collection[LinearConstraint];

    // set constraints of guessed equality vars
    for (i <- 0 until guessed.size) {
      val value = guessed(i)
      var one = new Array[Double](sizeOfSolution)
      one(i) = 1
      constraints.add(new LinearConstraint(one, Relationship.EQ, value));
    }

    // set constraints of vars to be less than 1
    for (i <- guessed.size until sizeOfSolution) {
      val value = 1
      var one = new Array[Double](sizeOfSolution)
      one(i) = 1
      constraints.add(new LinearConstraint(one, Relationship.LEQ, value));
    }

    // set constraints of rest of table
    for (row <- table) {
      val lhs = getLHS(row)
      val value = row(row.size-1)
      constraints.add(new LinearConstraint(lhs, Relationship.LEQ, value));
    }

    /*
    for(c1 <- constraints.toArray()) {
        val c = c1.asInstanceOf[LinearConstraint]
        println("Constraint: " + c.getCoefficients() + " " + c.getRelationship().toString + " " + c.getValue())
    }
    */

    // create and run the solver
    //var solution : RealPointValuePair = try { new SimplexSolver().optimize(f, constraints, GoalType.MAXIMIZE, true) } catch { case e : Exception => new RealPointValuePair(Array[Double](0,0), Double.NegativeInfinity) };
    var solver = new SimplexSolver()
    solver.setMaxIterations(1000)
    var solution : RealPointValuePair = try { solver.optimize(f, constraints, GoalType.MAXIMIZE, true) } catch { case e : NoFeasibleSolutionException => new RealPointValuePair(Array[Double](0,0), Double.NegativeInfinity) };

    // get the solution
    val p = solution.getPoint();
    val max = solution.getValue();

    /*
    for (i <- 0 until p.size) {
        println("p: " + arrayToString(p))
    }
    */
    println("max: " + max)

    return max
  }

  def nextSubtree(sizeOfSolution : Int, guess : Guess) : Guess = {
    val s = guess.size
    println("nextSubtree of " + arrayToString(guess))
    if (guess(s-1) == 0) {
      println("last is 0")
      guess(s-1) = 1
      return guess
    } else {
      println("last is 1")
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


  def arrayToString[T] (guess : Array[T]) : String = {
    if (guess != null) {
      if (guess.size == 0) {
        return "()"
      } else {
        return "(" + (guess.map(i => i.toString).reduceLeft(_ + ", " + _)) + ")"
      }
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
    val source = Source.fromFile("program.csv")
    val lines = source.mkString.split("\n")
    source.close()
    val table = lines.map(l => l.split(",").map(i => i.toDouble))

    val sizeOfSolution = table(0).size - 1
    println("size of solution: " + sizeOfSolution);
    var lowerBound = 0.0
    var bestGuess = Array[Int]()
    var upperBound = Double.NegativeInfinity

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
          var bound = solveRelaxation(table, guess)
          if (bound < lowerBound) {
            println("skip subtree")
            oldGuess = guess.clone()
            guess = nextSubtree(sizeOfSolution, guess.clone())
          } else {
            if (bound > upperBound) {
                upperBound = bound
            }
            oldGuess = guess.clone()
            guess = nextSolution(sizeOfSolution, guess.clone())
          }
        }

        println("guess: " + arrayToString(guess));
        println("best guess: " + arrayToString(bestGuess));
        println(lowerBound + " < value < " + upperBound);
    }

    println("num iterations: " + i);
    println("guess: " + arrayToString(guess));
    println("best guess: " + arrayToString(bestGuess));
  }
}
