#!/bin/sh
../../scala-2.9.1.final/bin/scalac -classpath *.jar integerprog.scala && ../../scala-2.9.1.final/bin/scala -classpath *.jar integerprog.IntProg
