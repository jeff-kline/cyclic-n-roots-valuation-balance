"""Conservative balls in Q_13(pi,t), Phi_13(1-pi)=0, t^2=2.

Every Ball represents pi^s*a + O(pi^P), with a integral. Coefficients of a
are stored modulo 13^20. No floating point is used. An uncertain zero has
s=P. Precision propagates by the nonarchimedean triangle inequality.
"""
import math
from fractions import Fraction

p, d, power = 13, 12, 20
modulus, cap = p**power, d*power
E = [(-1)**i*math.comb(p,i+1) for i in range(d)]
RZERO = (0,)*(2*d)
RONE = (1,)+(0,)*(2*d-1)

def rscalar(a, b=0):
    return (a % modulus,)+(0,)*(d-1)+(b % modulus,)+(0,)*(d-1)

def radd(a,b): return tuple((x+y)%modulus for x,y in zip(a,b))
def rneg(a): return tuple(-x%modulus for x in a)
def rsub(a,b): return tuple((x-y)%modulus for x,y in zip(a,b))

def rmul(a,b):
    c=[0]*(2*d-1); e=[0]*(2*d-1)
    for i in range(d):
        ar,ai=a[i],a[i+d]
        if ar or ai:
            for j in range(d):
                br,bi=b[j],b[j+d]
                c[i+j] += ar*br+2*ai*bi
                e[i+j] += ar*bi+ai*br
    for arr in (c,e):
        for k in range(2*d-2,d-1,-1):
            v=arr[k]%modulus
            if v:
                for j,x in enumerate(E): arr[k-d+j]-=v*x
    return tuple(x%modulus for x in c[:d]+e[:d])

def vp(a):
    if not a:return power
    k=0
    while a%p==0:a//=p;k+=1
    return k

def rval(a):
    return min((d*vp(x)+i%d for i,x in enumerate(a) if x),default=cap)

def rdivpi(a):
    out=[]
    for off in (0,d):
        assert a[off]%p==0
        last=-a[off]//p
        out.extend((a[off+i+1]+E[i+1]*last)%modulus for i in range(d-1))
        out.append(last%modulus)
    return tuple(out)

def rshift(a,k):
    assert k>=0
    for _ in range(k):
        out=[]
        for off in (0,d):
            last=a[off+d-1]
            out.extend(((a[off+i-1] if i else 0)-last*E[i])%modulus for i in range(d))
        a=tuple(out)
    return a

def rinv(a):
    ar,ai=a[0]%p,a[d]%p
    norm=(ar*ar-2*ai*ai)%p
    assert norm
    ni=pow(norm,-1,p)
    x=rscalar(ar*ni,-ai*ni)
    for _ in range(8):x=rmul(x,rsub(rscalar(2),rmul(a,x)))
    assert rmul(a,x)==RONE
    return x

class Ball:
    __slots__=('a','s','P')
    def __init__(self,a=RZERO,s=0,P=cap):
        P=min(P,cap+s)
        v=rval(a)
        if v+s>=P:
            self.a,self.s,self.P=RZERO,P,P
        else:
            for _ in range(v):a=rdivpi(a)
            self.a,self.s,self.P=a,s+v,P
    @staticmethod
    def scalar(a,b=0):return Ball(rscalar(a,b))
    def __add__(self,other):
        if isinstance(other,int):other=Ball.scalar(other)
        if self.s==self.P:return other.truncate(self.P)
        if other.s==other.P:return self.truncate(other.P)
        s=min(self.s,other.s);P=min(self.P,other.P)
        return Ball(radd(rshift(self.a,self.s-s),rshift(other.a,other.s-s)),s,P)
    __radd__=__add__
    def __neg__(self):return Ball(rneg(self.a),self.s,self.P)
    def __sub__(self,other):return self+-other
    def __rsub__(self,other):return -self+other
    def __mul__(self,other):
        if isinstance(other,int):other=Ball.scalar(other)
        if self.s==self.P or other.s==other.P:
            P=min(self.P+other.s,other.P+self.s)
            return Ball(RZERO,P,P)
        return Ball(rmul(self.a,other.a),self.s+other.s,
                    min(self.P+other.s,other.P+self.s))
    __rmul__=__mul__
    def inverse(self):
        if self.s>=self.P:raise ZeroDivisionError('Ball contains zero')
        return Ball(rinv(self.a),-self.s,self.P-2*self.s)
    def __truediv__(self,other):
        if isinstance(other,int):other=Ball.scalar(other)
        return self*other.inverse()
    def __pow__(self,k):
        if k<0:return self.inverse()**(-k)
        a=self;out=Ball.scalar(1)
        while k:
            if k%2:out=out*a
            a=a*a;k//=2
        return out
    def shift(self,k):return Ball(self.a,self.s+k,self.P+k)
    def truncate(self,P):return Ball(self.a,self.s,min(P,self.P))
    def residue(self):
        assert self.s==0 and self.P>0
        return [self.a[0]%p,self.a[d]%p]
    def info(self):
        if self.s==self.P:return {'valuation_at_least':self.P}
        return {'valuation':self.s,'unit_residue':[self.a[0]%p,self.a[d]%p],
                'absolute_precision':self.P}
    def conjugate(self):
        return Ball(self.a[:d]+tuple(-x%modulus for x in self.a[d:]),self.s,self.P)

zero,one=Ball.scalar(0),Ball.scalar(1)
pi=Ball(RONE,1)
omega=one-pi

def from_fraction(c):
    c=Fraction(c)
    return Ball.scalar(c.numerator)/Ball.scalar(c.denominator)

def from_anp(a):
    out=zero
    for c in a.to_list():
        out=out*omega+from_fraction(Fraction(int(c.numerator),int(c.denominator)))
    return out

def dot(a,b):return sum((x*y for x,y in zip(a,b)),zero)
def matvec(A,x):return [dot(row,x) for row in A]

def solve(A,b):
    """Complete-pivot Gauss-Jordan; all arithmetic is ball arithmetic."""
    n=len(A);A=[list(row)+[bb] for row,bb in zip(A,b)]
    cols=list(range(n));pivots=[]
    for r in range(n):
        _,i,j=min((A[i][j].s,i,j) for i in range(r,n) for j in range(r,n))
        A[r],A[i]=A[i],A[r]
        for row in A:row[r],row[j]=row[j],row[r]
        cols[r],cols[j]=cols[j],cols[r]
        pivot=A[r][r];assert pivot.s<pivot.P
        pivots.append(pivot.s);iv=pivot.inverse()
        A[r]=[x*iv for x in A[r]]
        for i in range(n):
            if i==r:continue
            c=A[i][r]
            A[i]=[x-c*y for x,y in zip(A[i],A[r])]
    out=[zero]*n
    for i,j in enumerate(cols):out[j]=A[i][-1]
    return out,pivots

def self_test():
    assert pow(2,6,13)==12
    assert Ball.scalar(13).s==12
    assert (omega**13-one).s>=cap
    for a,b,s in [(1,2,0),(8,3,-8),(13,13,4),(27,19,13)]:
        x=Ball.scalar(a,b).shift(s)
        assert (x*x.inverse()-one).s>=x.P-x.s
    for k in range(1,25):
        x=Ball.scalar(2,3).shift(k)
        assert x.s==k
        assert (x/pi**k-Ball.scalar(2,3)).s>=min(x.P-k,cap-k)
    # O(pi^17) cannot support a claimed term at pi^17.
    assert Ball.scalar(1).shift(17).truncate(17).s==17

if __name__=='__main__':
    self_test();print('local field self-tests passed')
