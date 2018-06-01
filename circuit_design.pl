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


