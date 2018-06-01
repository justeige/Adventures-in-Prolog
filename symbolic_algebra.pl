% basic symbolic algebra
% rules for differential calculus

% f (x) = x
% f'(x) = 1
derive(X,X,1).

% f (x) = 0 * x + C
% f'(x) = 0
derive(Constant, _, 0) :- atomic(Constant).

% f (x) = -A
% f'(x) = (-1) * A'
derive(-A, X, -U) :- derive(A,X,U).

% f (x) = A + B
% f'(x) = A' + B'
derive(A+B, X, U+V) :- derive(A,X,U), derive(B, X, V).

% f (x) = A - B
% f'(x) = A' - B'
derive(A-B, X, U-V) :- derive(A,X,U), derive(B, X, V).

% f (x) = A * B
% f'(x) = A' * B  + B' * A
derive(A*B, X, B*U + A*V) :- derive(A, X, U), derive(B, X, V).



% dn = distribute negations using DeMorgans's laws
% --A = A
dn(-(-(A)), B) :- !, dn(A, B).

% (-1) * (A + B) = -A-B
dn(-(A+B), U+V) :- !, dn(-(A), U), dn(-(B), V).

% (-1) * (A * B) = (-1) * A * B
dn(-(A*B), U*V) :- !, dn(-(A), U), dn(B, V).

dn(A+B, U+V) :- !, dn(A, U), dn(B, V).
dn(A*B, U*V) :- !, dn(A, U), dn(B, V).
dn(A,A).

% TODO simplify expressions!
