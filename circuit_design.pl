% ----------------------------------------
% truth-tables for all common logic gates
% ----------------------------------------

% inverter
not(1, 0).
not(0, 1).

% and-gate
and(0,0,0).
and(0,1,0).
and(1,0,0).
and(1,1,1).

% or-gate
or(0,0,0).
or(0,1,1).
or(1,0,1).
or(1,1,1).

% nand-gate
nand(0,0,1).
nand(0,1,1).
nand(1,0,1).
nand(1,1,0).

% nor-gate
nor(0,0,1).
nor(0,1,0).
nor(1,0,0).
nor(1,1,0).

% exclusive-or-gate
xor(0,0,0).
xor(0,1,1).
xor(1,0,1).
xor(1,1,0).

% exclusive-nor-gate
xnor(0,0,1).
xnor(0,1,0).
xnor(1,0,0).
xnor(1,1,1).


% ------------------------------------------------
% sequential logic elements
% ------------------------------------------------

% data-flip-flop
% dff(Data, Clock, Output, NextState).
dff(_D, 0, Q, Q).
dff(D, 1, _Q, D).

% shift-register (4 D-flip-flops in serial)
% C = Clock input
% D = Data input
% Q = Current state
% N = Next state
%
%s(_F1,_F2,_F3,_F4) = state of all four d-flip-flops
shift4(C, D, s(Q1, Q2, Q3, Q4), s(N1, N2, N3, N4)) :-
    dff(D,  C, Q1, N1),
    dff(Q1, C, Q2, N2),
    dff(Q2, C, Q3, N3),
    dff(Q3, C, Q4, N4).

shift([], _, _, []).
shift([C|Cs], [S,Ss], A, [Q|L]) :-
    shift4(C,S,A,N),
    N = s(_, _, _, Q),
    shift(Cs, Ss, N, L).

% divide-by-two pulse divider
pulse_div(Clock, Q, Next) :-
    not(Q, D),
    dff(D,Clock,Q,Next).

% apply pulse division on a list
% P = pulse, Ps = tail pulses
% Q = out,   Qs = tail outs
% S = inital state of the circuit
%
% example: divide_seq([1,1,1,1,1,1,1,1], 1, Q).
%          Q = [0, 1, 0, 1, 0, 1, 0, 1].
divide_seq([], _, []).
divide_seq([P|Ps], S, [Q|Qs]) :-
    pulse_div(P, S, Q),
    divide_seq(Ps, Q, Qs).


% sequential parity checker
% C = Clock input
% D = Data input
% Q = Parity output
% N = Next state
seq_parity(C, X, Z, Z1) :-
    xor(X, Z, _T),
    dff(X, C, Z, Z1).

% check a list of clock pulses
% C = Clock pulse, Cs = tail pulses
% S = Serial Input, Ss = tail serials
% N = initial state
%
parity([], _S, _N, []).
parity([C|Cs], [S|Ss], N, [Z|L]) :-
    seq_parity(C, S, N, Z),
    parity(Cs, Ss, Z, L).



% gray-code-counter:
% gray codes are a binary format that changes only one bit at the time:
% 001
% 011
% 010
% 110 ...
%
neta(A, B, Q) :-
    and(A, B, T1),
    not(A, NA), not(B, NB), and(NA, NB, T2),
    or(T1, T2, Q).

netb(A, B, C, Q1, Q2) :-
    and(A, C, T1),
    not(C, NC), and(B, NC, T2),
    not(A, NA), and(NA, C, T3),
    or(T1, T2, Q1), or(T2, T3, Q2).

grayc_counter(C, s(Qa,Qb,Qc), s(Za,Zb,Zc)) :-
    netb(Qa, Qb, Qc, D1, D2),
    neta(Qa, Qb, D3),
    dff(C, D1, Qa, Za),
    dff(C, D2, Qb, Zb),
    dff(C, D3, Qc, Zc).

test_counter([],_,[]).
test_counter([C|Cs], S, [N|Ns]) :-
    grayc_counter(C, S, N),
    test_counter(Cs, N, Ns).
















