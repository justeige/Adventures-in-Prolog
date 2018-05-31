% implementations for the list functions of the standard library (for learning purposes!)

% is an 'Element' part of the list?
% example: is_member(A, [B, A, C]). => true
% standard: member/2
is_member(Element, [Element | _Tail]).
is_member(Element, [_Head | Tail]) :-
    is_member(Element, Tail).


% is an 'Element' part of two lists?
% example: in_both(A, [B,C], [1,2]).
% A = B, B = 1 ;
% A = B, B = 2 ;
% A = C, C = 1 ;
% A = C, C = 2 ;
% false.
in_both(Element, List1, List2) :-
    is_member(Element, List1),
    is_member(Element, List2).

% whats the length (size) of a list?
% example: list_len([], A).
% A = 0.
% standard: length/2
list_len([], 0).
list_len([_Head, Tail], Result):-
    list_len(Tail, Length),
    Result is Length + 1.
