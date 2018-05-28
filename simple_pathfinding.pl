% -----------------------------------------------
% example of a naive depth-first graph search
% -----------------------------------------------


% path data
link(a, b). link(a, c).
link(b, d). link(c, d).
link(c, f). link(d, e).
link(d, f). link(f, a).

% there is a path between a start and end node if:
% - start and end are the same
% - there is a link between start and next with a path between next and
% end (recursion!)

% simple case: no path:
path(Node, Node, [Node]).

path(Start, End, [Start | Rest]) :-
    link(Start, Next),
    path(Next, End, Rest).

% concat predicate
conc([], L, L).
conc([X | L1], L2, [X, L3]) :-
    conc(L1, L2, L3).
