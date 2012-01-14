#!/usr/bin/env python


import random

def flip_coin(bias=0.5):
    return (random.random() < bias)

def rand_in_range(maxmin):
    return (random.random() * 2 * maxmin) - maxmin

def make_constraint(n):
    r = 2.3
    ratio = 0.5
    constraint = []
    for i in xrange(n):
        if flip_coin(ratio):
            constraint.append(rand_in_range(r))
        else:
            constraint.append(0)
    constraint.append(rand_in_range(r * n))
    return constraint

def does_solution_meet_constraint(solution, constraint):
    assert (len(solution) + 1) == len(constraint)
    s = sum((a * b) for a, b in zip(solution, constraint))
    if s <= constraint[-1]:
        return True
    else:
        return False

n = 20
num_constraints = n * 30

solution = [random.randint(0,1) for i in xrange(n)]

constraints = []
while len(constraints) < num_constraints:
    constraint = make_constraint(n)

    if does_solution_meet_constraint(solution, constraint):
        constraints.append(constraint)

#print solution
#print constraints

def save_program(solution, constraints):
    import csv
    with open('program.csv', 'w') as f:
        w = csv.writer(f)
        w.writerows(constraints)

    with open('solution.csv', 'w') as f:
        w = csv.writer(f)
        w.writerow(solution)

save_program(solution, constraints)
