"""Fixed exact order-26 certificate, reconstructed from the paper's formulas.

No imported output certificate, finite-precision arithmetic, or point search.
All Python workloads must run in the owning workstream's isolated environment.
"""
import json
import math
import resource
import sys
from fractions import Fraction

if not __debug__:
    raise RuntimeError("Verification assertions require Python without -O.")
if sys.prefix == sys.base_prefix:
    raise RuntimeError("Use an explicitly selected venv interpreter.")
resource.setrlimit(resource.RLIMIT_CPU, (90, 95))
from sympy import QQ, Poly, cyclotomic_poly, symbols
from sympy.polys.matrices import DomainMatrix

X = symbols("X")
K = QQ.alg_field_from_poly(Poly(cyclotomic_poly(13, X), X), alias="omega")
om = K.from_sympy(K.ext.as_expr())
one, zero = K.one, K.zero
zet = -om**7
zp = [zet**i for i in range(26)]
assert zet**26 == one and zet**13 == -one
F = [[zp[i*j % 26] for j in range(26)] for i in range(26)]

def product(roots):
    a = [one]
    for r in roots:
        b = [zero] * (len(a)+1)
        for j, c in enumerate(a):
            b[j] -= r*c
            b[j+1] += c
        a = b
    return a

U = product([om**e for e in range(7)])
W = product([-om**o for o in [2, 3, 4, 7, 9, 10, 12]])
u = [zero]*26
for i in range(8):
    u[i] = W[1]*U[i] + U[1]*W[i]
    u[13+i] = W[1]*U[i] - U[1]*W[i]
f = [sum((a*b for a, b in zip(row, u)), zero) for row in F]
I = [i for i, a in enumerate(u) if a]
J = [i for i, a in enumerate(f) if a]
assert I == [0,1,2,3,5,7,13,15,17,18,19,20]
assert J == [3,9,13,14,15,16,18,20,22,23,24,25]
B = [i for i in range(26) if i not in J]
Ic = [i for i in range(26) if i not in I]
rows, free = I[:-1], [17,19,21]
cols = [i for i in B if i not in free]
M = DomainMatrix([[F[i][j] for j in cols] for i in rows], (11,11), K)
Z = DomainMatrix([[-F[i][j] for j in free] for i in rows], (11,3), K)
sol = M.inv().matmul(Z).to_list()
G = [[zero]*3 for _ in B]
for a, k in enumerate(free):
    G[B.index(k)][a] = one
for k, row in zip(cols, sol):
    G[B.index(k)] = row
assert all(sum((F[i][k]*G[b][a] for b,k in enumerate(B)), zero) == zero
           for i in I for a in range(3))
V = [[sum((F[i][k]*G[b][a] for b,k in enumerate(B)), zero)
      for a in range(3)] for i in Ic]

# Exact affine reflection identities, including the sign on u.
assert sorted((20-i)%26 for i in I) == I
assert sorted((12-j)%26 for j in J) == J
assert all(zp[(-10-12*i)%26]*u[(20-i)%26] == -u[i] for i in range(26))
for k in range(26):
    assert (-20-12*k-12*(20-k)) % 26 == 0
    assert (-20-20*k-20*(12-k)) % 26 == 0
    for j in range(26):
        assert ((k-12)*(20-j)-10-(-10-20*(12-k)+(12-k)*j)) % 26 == 0
        assert ((k-20)*(12-j)-10-(-10-12*(20-k)+(20-k)*j)) % 26 == 0
R = [[zero,zero,zp[14]],[zero,one,zero],[zp[12],zero,zero]]
for b,k in enumerate(B):
    lhs = [zp[(-10-20*k)%26]*a for a in G[B.index((12-k)%26)]]
    rhs = [sum((G[b][j]*R[j][a] for j in range(3)),zero) for a in range(3)]
    assert lhs == rhs
Lchart = [one,K.convert(6),zp[14]]
assert [sum((Lchart[j]*R[j][a] for j in range(3)),zero)
        for a in range(3)] == Lchart

# Exact valuation: in the pi basis the 12 possible term valuations are
# distinct modulo 12. Thus no cancellation of the minimum is possible.
# Phi_13(1-pi) is Eisenstein and 13/pi^12 reduces to -1.
def ascending(a):
    return [Fraction(int(c.numerator),int(c.denominator)) for c in reversed(a.to_list())]

def vp13(n):
    n=abs(n)
    assert n
    r=0
    while n%13 == 0:
        n//=13
        r+=1
    return r

def initial(a):
    if not a:
        return (10**9,0)
    cs=ascending(a)
    ps=[sum((cs[j]*math.comb(j,k)*(-1)**k for j in range(k,len(cs))),Fraction(0))
        for k in range(len(cs))]
    terms=[]
    for j,c in enumerate(ps):
        if not c:
            continue
        e=vp13(c.numerator)-vp13(c.denominator)
        unit=c/(Fraction(13)**e)
        residue=(unit.numerator%13)*pow(unit.denominator%13,-1,13)%13
        residue=residue*(-1 if e%2 else 1)%13
        terms.append((12*e+j,residue))
    return min(terms)

def normal(row):
    terms=[initial(a) for a in row]
    v=min(a[0] for a in terms)
    raw=[a[1] if a[0]==v else 0 for a in terms]
    pivot=next(a for a in raw if a)
    return v,[a*pow(pivot,-1,13)%13 for a in raw]

gn=[normal(row) for row in G]
vn=[normal(row) for row in V]
expected=[[1,4,7],[1,1,6],[1,3,9],[1,0,0],[1,7,4],[0,1,0],
          [1,5,10],[0,0,1],[1,9,3],[1,11,11],[1,8,2],
          [1,0,0],[0,1,0],[0,0,1]]
assert gn == [(0,row) for row in expected]
assert vn == [(4 if i%2==0 else 8,[1,6,1]) for i in Ic]
assert initial(M.det())[0] == 31

# Split-prime witness, evaluated from exact characteristic-zero matrices.
def residue(a,q,w):
    return sum(c.numerator*pow(c.denominator,-1,q)*pow(w,i,q)
               for i,c in enumerate(ascending(a)))%q

assert sum(pow(5992,i,10037) for i in range(13))%10037==0
assert -pow(5992,7,10037)%10037==5215
assert residue(M.det(),10037,5992)==3759
q=53
assert all(q%d for d in range(2,8))
assert pow(4,26,q)==1 and pow(4,13,q)==52 and pow(4,2,q)!=1
assert 4 == -pow(16,7,q)%q
FM=[[residue(a,q,16) for a in row] for row in F]
GM=[[residue(a,q,16) for a in row] for row in G]
VM=[[residue(a,q,16) for a in row] for row in V]
um=[residue(a,q,16) for a in u]
fm=[residue(a,q,16) for a in f]
def dot(a,b):
    return sum(x*y for x,y in zip(a,b))%q
z=[1,8,19]
gm=[dot(row,z) for row in GM]
vm=[dot(row,z) for row in VM]
assert all(gm) and all(vm)
assert residue(M.det(),q,16)==46
assert [i for i,a in enumerate(um) if a]==I
assert [i for i,a in enumerate(fm) if a]==J
gi=[pow(a,-1,q) for a in gm]
vi=[pow(a,-1,q) for a in vm]
grad=[(sum(r[a]*s for r,s in zip(GM,gi))-sum(r[a]*s for r,s in zip(VM,vi)))%q
      for a in range(3)]
assert grad==[0,0,0]
H=[[(sum(VM[i][a]*VM[i][b]*vi[i]**2 for i in range(14))-
     sum(GM[i][a]*GM[i][b]*gi[i]**2 for i in range(14)))%q
    for b in range(3)] for a in range(3)]
assert H==[[6,47,5],[47,3,13],[5,13,11]]
assert (H[1][1]*H[2][2]-H[1][2]*H[2][1])%q==23
def solve_mod(a,b):
    a=[list(row)+[v] for row,v in zip(a,b)]
    for j in range(len(a)):
        k=next(k for k in range(j,len(a)) if a[k][j])
        a[j],a[k]=a[k],a[j]
        inv=pow(a[j][j],-1,q)
        a[j]=[v*inv%q for v in a[j]]
        for k in range(len(a)):
            if k!=j:
                c=a[k][j]
                a[k]=[(v-c*w)%q for v,w in zip(a[k],a[j])]
    return [row[-1] for row in a]
rhs=[(gi[B.index(k)]-sum(FM[k][i]*vi[c] for c,i in enumerate(Ic)))%q
     for k in cols]
wi=solve_mod([[FM[k][i] for i in rows] for k in cols],rhs)
w=[0]*26
for i,a in zip(rows,wi):
    w[i]=a
for i,a in zip(Ic,vi):
    w[i]=a
assert all(dot(FM[k],w)==gi[b] for b,k in enumerate(B))
h=[(sum(FM[i][j]*pow(fm[j],-1,q) for j in J)-
    (pow(um[i],-1,q) if i in I else 0))%q for i in range(26)]
assert dot(w,h)==4

# Both F169 points, with all denominators and full reduced chart Hessians.
def add(a,b): return ((a[0]+b[0])%13,(a[1]+b[1])%13)
def neg(a): return (-a[0]%13,-a[1]%13)
def mul(a,b): return ((a[0]*b[0]+2*a[1]*b[1])%13,(a[0]*b[1]+a[1]*b[0])%13)
def sc(a): return (a%13,0)
def inv(a):
    c=pow((a[0]*a[0]-2*a[1]*a[1])%13,-1,13)
    return (a[0]*c%13,-a[1]*c%13)
def linear(row,z):
    v=(0,0)
    for a,b in zip(row,z):
        v=add(v,mul(sc(a),b))
    return v
assert pow(2,6,13)==12
points=[]
for sign in [1,-1]:
    z=[(9,sign*4%13),(8,sign*3%13),(9,sign*4%13)]
    assert linear([1,6,1],z)==(1,0) and z[0]==z[2]
    grad=[(0,0),(0,0)]
    H=[[(0,0),(0,0)],[(0,0),(0,0)]]
    for weight,collection in [(1,gn),(-1,vn)]:
        for _,row in collection:
            den=linear(row,z)
            assert den!=(0,0)
            iv=inv(den)
            ds=[row[0]-row[2],row[1]-6*row[2]]
            for a in range(2):
                grad[a]=add(grad[a],mul(sc(weight*ds[a]),iv))
                for b in range(2):
                    H[a][b]=add(H[a][b],mul(sc(-weight*ds[a]*ds[b]),mul(iv,iv)))
    assert grad==[(0,0),(0,0)]
    assert H==[[(7,sign*9%13),(8,sign%13)],[(8,sign%13),(4,0)]]
    det=add(mul(H[0][0],H[1][1]),neg(mul(H[0][1],H[1][0])))
    assert det==(1,sign*7%13)
    assert (det[0]**2-2*det[1]**2)%13==7
    points.append({"z":z,"hessian":H,"determinant":det})

print(json.dumps({
    "status":"PASS", "arithmetic":"exact Q(omega_13), F53, F169",
    "isolated_environment":True, "support_I":I,"support_J":J,
    "rank_A":11,"minor_mod_10037":3759,"minor_pi_valuation":31,
    "G_normalized_rows":gn,"V_normalized_rows":vn,
    "Uu_equals_minus_u":True,"monomial_intertwining":True,
    "R_on_free_coordinates":True,"invariant_affine_chart":True,
    "split_prime":{"point":[1,8,19],"chart_determinant":23,"kappa":4},
    "ramified_residual_points":points,
    "scope":"Fixed certificates only. Exact kappa=0 follows from the manuscript's symmetry and Hensel proof; no mu or branch computation."
},indent=2))
