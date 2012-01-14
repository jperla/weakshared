import org.apache.commons.math.optimization.linear.SimplexSolver
import scala.io.Source

object HelloWorld {
  def main(args: Array[String]) {
    val source = Source.fromFile("small.csv")
    //val source = Source.fromPath("small.csv")
    //val lines = source.getLines()
    val lines = source.mkString.split("\n")
    source.close()

    val table = lines.map(l => l.split(",").map(i => i.toDouble)) 

    println("Hello, world!")
    for(l <- table) {
        for (i <- l) {
            println(i)
        }
    }
  }
}
