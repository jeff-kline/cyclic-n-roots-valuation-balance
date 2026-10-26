"""Only the two fixed n=26 Hensel discs; rigorous pi-adic balls, no search."""
import json,resource,sys,time,hashlib
from pathlib import Path
assert __debug__ and sys.prefix!=sys.base_prefix
resource.setrlimit(resource.RLIMIT_CPU,(180,185))
start=time.process_time();base=Path(__file__).resolve().parent
sys.path.insert(0,str(base))  # -I drops the script directory from sys.path
from local_field import Ball,from_anp,dot,matvec,solve,self_test,cap
self_test()
def progress(label):print(label,round(time.process_time()-start,3),flush=True)

# Rebuild our sealed exact data from definitions. Stop before finite-field
# probes. The source is read only; it performs no writes at this stage.
source=base/'check_certificates.py'
text=source.read_text().split('# Split-prime witness,')[0]
# Only the imported process limit is replaced in memory; the sealed file is
# unchanged. This combined calculation has the charter's 180-second limit.
text=text.replace('resource.setrlimit(resource.RLIMIT_CPU, (90, 95))','')
ns={};exec(compile(text,str(source),'exec'),ns)
I,J,B,Ic,rows,cols=[ns[k] for k in ['I','J','B','Ic','rows','cols']]
F=[[from_anp(a) for a in row] for row in ns['F']]
G=[[from_anp(a) for a in row] for row in ns['G']]
V=[[from_anp(a) for a in row] for row in ns['V']]
u=[from_anp(a) for a in ns['u']];f=[from_anp(a) for a in ns['f']]
mi=[[from_anp(a) for a in row] for row in ns['M'].inv().to_list()]
zero,one=Ball.scalar(0),Ball.scalar(1)
zp=[from_anp(a) for a in ns['zp']]
progress('exact data reconstructed')
assert [min(a.s for a in row) for row in G]==[0]*14
vr=[4 if i%2==0 else 8 for i in Ic]
assert [min(a.s for a in row) for row in V]==vr
VN=[[a.shift(-e) for a in row] for row,e in zip(V,vr)]
allrows=G+VN;weights=[1]*14+[-1]*14
dirs=[[one,zero,-zp[12]],[zero,one,-6*zp[12]]]
der=[[dot(row,di) for di in dirs] for row in allrows]

def chart(x,y):return [x,y,zp[12]*(one-x-6*y)]
def grad_hess(z):
    values=matvec(allrows,z);assert all(a.s==0 for a in values)
    ratios=[[a/v for a in rr] for rr,v in zip(der,values)]
    grad=[sum((c*rr[j] for c,rr in zip(weights,ratios)),zero) for j in range(2)]
    H=[[sum((-c*rr[i]*rr[j] for c,rr in zip(weights,ratios)),zero)
        for j in range(2)] for i in range(2)]
    return grad,H

records=[]
for sign in [1,-1]:
    x,y=Ball.scalar(9,4*sign),Ball.scalar(8,3*sign)
    history=[]
    for step in range(9):
        z=chart(x,y);grad,H=grad_hess(z)
        det=H[0][0]*H[1][1]-H[0][1]*H[1][0]
        assert det.s==0
        r=min(a.s for a in grad);history.append(r)
        if r>=150:break
        delta,_=solve(H,grad);x,y=x-delta[0],y-delta[1]
    else:raise AssertionError('Hensel target precision not reached')
    # Unit Hessian and integral rational functions imply the unique exact root
    # is within O(pi^r). The following balls now enclose that root, not merely
    # the final Newton iterate.
    z=[a.truncate(r) for a in z]
    grad,H=grad_hess(z)
    g=matvec(G,z);v=matvec(V,z)
    assert [a.s for a in g]==[0]*14 and [a.s for a in v]==vr
    assert min(a.s for a in grad)>=r
    assert (z[0]-zp[14]*z[2]).s>=r
    progress('Hensel lift '+str(sign))
    gi=[a.inverse() for a in g];vi=[a.inverse() for a in v]
    rhs=[gi[B.index(k)]-dot([F[k][i] for i in Ic],vi) for k in cols]
    wi=matvec(list(map(list,zip(*mi))),rhs)
    w=[zero]*26
    for i,a in zip(rows,wi):w[i]=a
    for i,a in zip(Ic,vi):w[i]=a
    fw=matvec(F,w)
    wres=[fw[k]-gi[b] for b,k in enumerate(B)]
    assert min(a.s for a in wres)>50
    h=[sum((F[i][j]/f[j] for j in J),zero)-(u[i].inverse() if i in I else zero)
       for i in range(26)]
    kappa=dot(w,h)
    assert kappa.s>50
    gg=[zero]*26;vv=[zero]*26
    for k,a in zip(B,g):gg[k]=a*a
    for i,a in zip(Ic,v):vv[i]=a*a
    L=[[(vv[i] if i==j else zero)-sum((F[i][k]*gg[k]*F[k][j] for k in B),zero)
        for j in range(26)] for i in range(26)]
    gauge=[4,20];keep=[i for i in range(26) if i not in gauge]
    # Kernel span{u,w}; its evaluation on these two coordinates is invertible.
    assert (u[20]*w[4]).s<(u[20]*w[4]).P
    ss,piv=solve([[L[i][j] for j in keep] for i in keep],[-h[i] for i in keep])
    s=[zero]*26
    for i,a in zip(keep,ss):s[i]=a
    residual=[a+b for a,b in zip(matvec(L,s),h)]
    assert min(a.s for a in residual)>0
    q2=sum(((fw[j]/f[j])**2 for j in J),zero)-sum(((w[i]/u[i])**2 for i in I),zero)
    mu=q2-dot(h,s)
    assert mu.s<mu.P,'mu not separated from zero at certified precision'
    # Independently equivalent contraction, with the same certified s enclosure.
    mu_alt=q2+dot(s,matvec(L,s))
    assert (mu-mu_alt).s>mu.s
    records.append({'sign':sign,'z_residue':[[9,4*sign%13],[8,3*sign%13],[9,4*sign%13]],
      'newton_gradient_valuation_bounds':history,'root_absolute_precision':r,
      'g_valuations':[a.s for a in g],'v_valuations':[a.s for a in v],
      'w_min_valuation':min(a.s for a in w),'w_constraint_residual_bound':min(a.s for a in wres),
      'kappa':kappa.info(),'L_restricted_pivot_valuations':piv,
      's_min_valuation':min(a.s for a in s),'s_min_precision':min(a.P for a in s),
      'Ls_plus_h_residual_bound':min(a.s for a in residual),
      'q2':q2.info(),'h_dot_s':dot(h,s).info(),'mu':mu.info(),
      'mu_alternative':mu_alt.info(),'mu_contraction_agreement_bound':(mu-mu_alt).s})
    progress('mu certified '+str(sign))

assert records[0]['mu']['valuation']==records[1]['mu']['valuation']
a,b=records[0]['mu']['unit_residue'];assert records[1]['mu']['unit_residue']==[a,-b%13]
out={'status':'PI_ADIC_NONZERO_MU_CERTIFICATE','pi':'1-omega_13','residue_field':'F13[t]/(t^2-2)',
 'working_ring_precision':cap,'normalization':'u as factored polynomial in sealed checker; g=Gz; z0+6*z1+zeta^14*z2=1; w20=0',
 'source_sha256':hashlib.sha256(source.read_bytes()).hexdigest(),'endpoints':records,
 'cpu_seconds':time.process_time()-start,'python':sys.version.split()[0],'isolated':True,
 'scope':'Only the two fixed nondegenerate endpoint directions; no M1 conclusion.'}
(base.parent/'build'/'mu-certificate.json').write_text(json.dumps(out,indent=2)+'\n')
print(json.dumps(out,indent=2))
