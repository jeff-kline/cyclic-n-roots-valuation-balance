# Claim packet (statements only; no proofs) — cyclic n-roots valuation note, 2026-10-26

Extracted verbatim from paper/main.tex (LaTeX source lines noted). Proofs are deliberately omitted.
Section 4's setting (order 26) is included because Theorem 4.1's statement depends on it; its
subsections 4.1-4.3 contain the proof and are omitted here. Additional claimed facts used in the
proof of Theorem 4.1 (listed after the excerpts) are also stated without proof.

## Setting and equation (lines 52-67)
```latex
for prime order \cite{Haagerup}. Among composite square-free orders, finiteness
is known only for $n=6$ and $n=10$, by Gr\"obner-basis computation
(see the tables in \cite{FR}). The question for $2p$, with $p$ an arbitrary
odd prime, motivates this note but is not resolved here.

Put $\zeta=e^{2\pi i/n}$ and $F=(\zeta^{ij})_{0\le i,j<n}$.
We use the unnormalized Fourier matrix, bilinear transpose, and
coordinatewise reciprocals. Work where all coordinates of $x$ and
$f=Fx$ are nonzero. The equations are
\begin{equation}\label{eq:critical}
 E(x):=F(Fx)^{-1}-x^{-1}=0.
\end{equation}
After fixing $x_0=1$, these are the Fourier equations for cyclic roots:
set $a_j=x_{j+1}/x_j$. Indeed, $F^{-1}(x^{-1})=(Fx)^{-1}$ says that
the cyclic correlations $\sum_j x_{j+r}/x_j$ vanish for $r\ne0$.
This correspondence is credited to the existing literature,
```
## Theorem 2.1, Corollary 2.2, Remark 2.3 (lines 98-107, 122-133, 145-152)
```latex
\begin{theorem}[Valuation multiset]\label{thm:valuations}
Let $F$ be an invertible symmetric constant matrix over $\C$. Suppose
$x\in\C((t))^n$ satisfies \eqref{eq:critical} and all coordinates of
$x$ and $Fx$ are nonzero. Then
\[
 \{\nu(x_i):0\le i<n\}=\{\nu((Fx)_k):0\le k<n\}
\]
as multisets. This also holds for Puiseux series after a finite change
of parameter.
\end{theorem}
\begin{corollary}[Exact complementarity at every gap]\label{cor:gaps}
Under Theorem~\ref{thm:valuations}, choose a real $c$ which is not a
coordinate valuation, and put
\[
 I=\{i:\nu(x_i)<c\},\qquad J=\{k:\nu((Fx)_k)<c\}.
\]
If the cut is proper, then $0<|I|=|J|<n$, and constant vectors $u,v$ exist with
\[
 \supp u=I,\quad\supp(Fu)=J,\qquad
 \supp v=I^c,\quad\supp(F^{-1}v)=J^c.
\]
\end{corollary}
\begin{remark}
An infinite normalized cyclic-root variety contains an algebraic curve.
On its smooth projective model a nonconstant coordinate has a pole.
The Laurent expansion there, with $x_0=1$, has a nonconstant valuation
vector and a proper gap. Thus the corollary gives necessary data for an
infinite solution set, without asserting that arbitrary such data occur
along a solution curve.
\end{remark}
```
## Section 3 setup, Proposition 3.1, definitions of kappa and mu, Theorem 3.2 (lines 154-186, 198-231)
```latex
\section{The normal equations and two scalar conditions}
Continue with any invertible symmetric $F$. Fix $|I|=|J|=m$, put $q=n-m$,
and suppose
\begin{equation}\label{eq:endpoint}
 \supp u=I,\quad\supp f=J,\quad f=Fu,\quad
 A=F[J^c,I],\quad\rank A=m-1.
\end{equation}
The right kernel is the line $u_I$. Let the columns of $G\in\C^{q\times d}$
span $\ker A^T$, where $d=q-m+1$. Set
\[
 V=F[I^c,J^c]G,\quad g_{J^c}=Gz,\quad g_J=0,\qquad v=Fg.
\]
Work where all entries of $Gz$ and $Vz=v_{I^c}$ are nonzero. Define
\begin{equation}\label{eq:psi}
 \Psi(z)=\sum_{k\in J^c}\log(Gz)_k-\sum_{i\in I^c}\log(Vz)_i.
\end{equation}
Only logarithmic derivatives are used. The equal factor counts make
this a projective critical-point problem.

\begin{proposition}\label{prop:normal}
A vector $w$ with
\begin{equation}\label{eq:w}
 w_{I^c}=v_{I^c}^{-1},\qquad (Fw)_{J^c}=g_{J^c}^{-1}
\end{equation}
exists exactly when $\nabla\Psi(z)=0$, and is unique modulo $u$.
Set
\[
 H=V^T\diag(v_{I^c}^{-2})V-G^T\diag(g_{J^c}^{-2})G,\qquad
 L=\diag(v^2)-F\diag(g^2)F.
\]
At a critical point, $\dim\ker L=1+\dim\ker H$.
If $\rank H=d-1$, then $\ker L=\operatorname{span}\{u,w\}$.
\end{proposition}

Fix a critical point $z$ of $\Psi$ and assume projective nondegeneracy:
$\rank H=d-1$. Put
\begin{equation}\label{eq:kappa}
 h=F(1/f\text{ on }J)-(1/u\text{ on }I),\qquad\kappa=w^Th,
\end{equation}
with zero entries elsewhere. Since $u^Th=|J|-|I|=0$, $\kappa$ is
independent of the choice of $w$. Symmetry of $L$ gives
\begin{equation}\label{eq:solvable}
 Ls=-h\text{ is solvable}\quad\Longleftrightarrow\quad\kappa=0.
\end{equation}
When this holds, define
\begin{equation}\label{eq:mu}
 \mu=\sum_{j\in J}\left(\frac{(Fw)_j}{f_j}\right)^2
       -\sum_{i\in I}\left(\frac{w_i}{u_i}\right)^2+s^TLs.
\end{equation}
Changing $s$ by $\ker L$ has no effect. Replacing $w$ by $w+cu$ changes
the two sums by $2c\kappa+c^2(|J|-|I|)=0$.
Under $u\mapsto au$, $g\mapsto bg$, we have
$\kappa\mapsto(ab)^{-1}\kappa$ and, when defined,
$\mu\mapsto(ab)^{-2}\mu$. Their vanishing is independent of scale.

\begin{theorem}[Local scalar reduction]\label{thm:local}
At such a critical point, under \eqref{eq:endpoint}, the nonzero-coordinate
conditions, and projective nondegeneracy, there is a convergent effective function
$Q_{\rm eff}(\tau)$ with $Q_{\rm eff}'(0)=\kappa$. If $\kappa=0$, then
\[
 Q_{\rm eff}'(\tau)=-\mu\tau+O(\tau^2).
\]
A nonconstant formal solution branch of \eqref{eq:critical} with boundary
direction $u$ and first transverse direction $w$ exists exactly when
$Q_{\rm eff}'\equiv0$. This concerns the specified directions, up to
scaling and change of parameter.
\end{theorem}
```
## Section 4 setting and Theorem 4.1 (lines 269-303)
```latex
\section{One order-26 support with opposite outcomes for \texorpdfstring{$\kappa$}{kappa}}
Set $\omega=e^{2\pi i/13}$, $\zeta=-\omega^7$, and $K=\Q(\omega)$. Take
\begin{align*}
 I&=\{0,1,2,3,5,7,13,15,17,18,19,20\},\\
 J&=\{3,9,13,14,15,16,18,20,22,23,24,25\},\\
 B=J^c&=\{0,1,2,4,5,6,7,8,10,11,12,17,19,21\}.
\end{align*}
For $E=\{0,1,2,3,4,5,6\}$ and $O=\{2,3,4,7,9,10,12\}$, write
\[
 U(X)=\prod_{e\in E}(X-\omega^e)=\sum a_iX^i,\qquad
 W(X)=\prod_{o\in O}(X+\omega^o)=\sum b_iX^i.
\]
Let $u$ be the length-$26$ coefficient vector of
\[
 b_1U(X)+a_1W(X)+X^{13}\{b_1U(X)-a_1W(X)\}.
\]
Exact arithmetic gives $\supp u=I$ and $\supp Fu=J$.
Put $D_0=I\setminus\{20\}$, $T_0=\{17,19,21\}$, $C_0=B\setminus T_0$.
The normal system uses
\begin{equation}\label{eq:Gexplicit}
 M=F[D_0,C_0],\qquad G_{T_0}=\mathrm{Id}_3,\qquad
 G_{C_0}=-M^{-1}F[D_0,T_0].
\end{equation}
Under $\zeta\mapsto5215$ modulo $10037$, $\det M=3759$.
Thus $\rank F[B,I]=11$, and $z=(g_{17},g_{19},g_{21})$ are free
coordinates. The modular minor proves nonvanishing only; exact cyclotomic
identities prove the support zeros.

\begin{theorem}\label{thm:26}
These supports and this $u$ admit algebraic nondegenerate projective
critical points of \eqref{eq:psi} with $\kappa\ne0$. They also admit
two distinct algebraic nondegenerate projective critical points with
$\kappa=0$. No assertion about $\mu$ or actual solution branches is made
at the latter points.
\end{theorem}
```
## Further claimed facts used in the proof of Theorem 4.1 (statements only)
F1. At the split prime 53 (zeta -> 4, omega -> 16), z = (1,8,19) is a nondegenerate critical point of the
    reduced Psi with all 28 denominators nonzero, chart Hessian determinant 23, and kappa = 4.
F2. Monomial involutions (Ux)_i = zeta^(-10-12i) x_(20-i), (Sg)_k = zeta^(-10-20k) g_(12-k) (indices mod 26)
    satisfy U^2 = S^2 = 1, F U = S^(-T) F, F S = U^(-T) F; U u = -u; S induces
    R(z0,z1,z2) = (zeta^14 z2, z1, zeta^12 z0) on the free coordinates; consequently
    kappa(u, Rz) = -kappa(u, z) on the normal critical locus.
F3. At pi = 1 - omega, after normalising rows, the G rows reduce to 14 explicit vectors over F_13 (valuation 0)
    and every V row reduces to a multiple of (1,6,1) (valuation 4 or 8). Over F_169 = F_13[t]/(t^2-2) the reduced
    function has the two nondegenerate critical points (9 +- 4t, 8 +- 3t, 9 +- 4t) on (1,6,1).z = 1, used
    here; the reduction of R fixes both; the affine chart z0 + 6 z1 + zeta^14 z2 = 1 is exactly R-invariant; the
    unique Hensel lifts are therefore R-fixed and have kappa = 0 exactly, with all 28 forms nonzero.
F4. Algebraicity: each Hensel lift is algebraic over K = Q(omega_13); embedding a number field of definition into C
    by an embedding extending omega -> e^(2 pi i/13) preserves nonvanishing, Hessian rank and the value of kappa.
