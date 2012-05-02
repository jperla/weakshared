#!/usr/bin/env python

import random
from itertools import izip

def random_gaussian(center, covar=None):
    """Accepts 2 D-tuples.  
        First is the center and has length D.
        Optionally, also accpets the diagonal of the covariance matrix.
       Returns a D-tuple representing a point randomly drawn.
    """
    if covar is None:
        covar = [1.0] * len(center)

    return tuple(random.gauss(mu, sigma) for mu,sigma in izip(center, covar))

def draw_from_centers(centers, covar=None):
    """Accepts a list of D-tuples.  Each one is a Gaussian center.
        Also optionally accepts covariance matrix of gaussian centers.
        Returns a point in D-tuple.
    """
    c = random.choice(centers)
    return random_gaussian(c, covar)

centers = [(0, 0), (5, 0), (-2, 2), (3, 2), (-4, -4)]

N = 10
num_points = 100000
num_points = 1000
for i in xrange(N):
    with open('%i.txt' % i, 'w') as f:
        for i in xrange(num_points):
            p = draw_from_centers(centers)
            f.write('%s %s\n' % p)
