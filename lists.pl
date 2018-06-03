% implementations for the list functions of the standard library (for learning purposes!)

% is an 'Element' part of the list?
% example: is_member(A, [B, A, C]). => true
is_member(Element, [Element | _Tail]).
is_member(Element, [_Head | Tail]) :-
    is_member(Element, Tail).

% deterministic version: discards alternative choices with a cut:
is_member_det(Element, [Element|_]) :- !.
is_member_det(Element, [_|Tail]) :- is_member_det(Element, Tail).

% is an 'Element' part of two lists?
% example: in_both(A, [B,C], [1,2]).
% A = B, B = 1 ;   % <- Prolog tries to solve
% A = B, B = 2 ;
% A = C, C = 1 ;
% A = C, C = 2 ;
% false.
%
% example: in_both(x, [a,b,c,x], [1,2,3]). % <- Prolog has only facts
% false.
in_both(Element, List1, List2) :-
    is_member(Element, List1),
    is_member(Element, List2).

% whats the length (size) of a list?
% example: list_len([], A).
% A = 0.
list_len([], 0).
list_len([_Head, Tail], Result):-
    list_len(Tail, Length),
    Result is Length + 1.


% flatten a nested data struct into a linear sequence
% example: flatten([a, [b,c],d], List).
% List = [a, b, c, d]
flatten_slow([], []).
flatten_slow([Head|Tail], List) :-
    flatten_slow(Head, List1),
    flatten_slow(Tail, List2),
    append(List1, List2, List). % append gets called quite a lot in this version...
flatten_slow(X, [X]).

% flatten using a flat-pair: this approach does not need to construct
% partial output lists.
flatten_fast(X, Y) :- my_flatpair(X, Y-[]).

my_flatpair([], L-L).
my_flatpair([Head|Tail], L1-L3) :-
    my_flatpair(Head, L1-L2),
    my_flatpair(Tail, L2-L3).
my_flatpair(X, [X|Z]-Z).



