"""Deliberate-error control: weaken Ball.inverse to P - s (true rule P - 2s); the property test must catch it."""
import runpy, sys
from pathlib import Path
sys.path.insert(0, str(Path(__file__).resolve().parents[3] / 'scripts'))
import local_field as lf
orig_inv = lf.Ball.inverse
def bad_inv(self):
    if self.s >= self.P: raise ZeroDivisionError
    return lf.Ball(lf.rinv(self.a), -self.s, self.P - self.s)
lf.Ball.inverse = bad_inv
try:
    runpy.run_path(str(Path(__file__).with_name('ball_property_test.py')), run_name='__main__')
    print('MUTANT inverse NOT caught')
except AssertionError:
    print('MUTANT inverse caught')
