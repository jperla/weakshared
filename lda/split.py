#!/usr/bin/env python
import sys

# Counts the number of lines in the file
def file_len(fname):
    with open(fname) as f:
        for i, l in enumerate(f):
            pass
    return i + 1

N = 10
datafile = open(sys.argv[1])
num_points = file_len(sys.argv[1])
points_per_file = num_points / N

for i in xrange(N):
    with open('%i.txt' % i, 'w') as f:
        for i in xrange(points_per_file):
            f.write(datafile.readline())
