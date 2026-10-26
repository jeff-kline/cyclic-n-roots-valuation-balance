"""Examiner property test of scripts/local_field.py enclosure rules (read-only import).

For random balls X (center c, precision P) and random points x = c + delta with
v(delta) >= P, check that op(x) lies in op(X): the difference ball must have
s >= op(X).P.  Points are carried as balls of much higher precision.
"""
import random, sys
from pathlib import Path
sys.path.insert(0, str(Path(__file__).resolve().parents[3] / 'scripts'))
from local_field import Ball, rscalar, modulus, d, p

random.seed(20261026)

def rand_unit_tuple():
    while True:
        a = tuple(random.randrange(modulus) for _ in range(2 * d))
        if a[0] % p or a[d] % p:
            return a

def rand_ball(slo=-20, shi=20, gap=(1, 60)):
    s = random.randint(slo, shi)
    P = s + random.randint(*gap)
    return Ball(rand_unit_tuple(), s, P)

def point_in(X):
    """A point of X, carried with precision X.s + 200 (well below the 240 cap)."""
    delta = Ball(tuple(random.randrange(modulus) for _ in range(2 * d)), X.P, X.P + 200)
    return Ball(X.a, X.s, X.s + 200) + delta

def inside(y, Y):
    diff = y - Y
    return diff.s >= Y.P

fails = {'add': 0, 'mul': 0, 'inv': 0, 'shift': 0}
trials = 400
for _ in range(trials):
    X, Y = rand_ball(), rand_ball()
    x, y = point_in(X), point_in(Y)
    if not inside(x + y, X + Y): fails['add'] += 1
    if not inside(x * y, X * Y): fails['mul'] += 1
    if not inside(x.inverse(), X.inverse()): fails['inv'] += 1
    k = random.randint(-15, 15)
    if not inside(x.shift(k), X.shift(k)): fails['shift'] += 1
# cancellation probe: X - X' with equal centers to high order must not gain digits
canc = 0
for _ in range(100):
    X = rand_ball(gap=(5, 40)); x = point_in(X)
    D = X - x            # true value is -delta with v >= X.P; ball must not claim s < X.P
    if D.s < D.P: canc += 1
print('trials', trials, 'enclosure failures', fails, 'cancellation over-claims', canc)
assert not any(fails.values()) and canc == 0
