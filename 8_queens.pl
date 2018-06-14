% 8 queens problem, solution describes each queens position in a column:
%
% 8: - - - - - - - -
% 7: - - - - - - - -
% 6: - - - - - - - -
% 5: - - - - - - - -
% 4: - - - - - - - -
% 3: - - - - - - - -
% 2: - - - - - - - -
% 1: - - - - - - - -
%    1 2 3 4 5 6 7 8
%
solution(Queens) :-
    permutation([1,2,3,4,5,6,7,8], Queens),
    is_safe(Queens).

permutation([],[]).
permutation(List,[H|T]):-
    remove_item(H,List,List1),
    permutation(List1,T).

% remove a single item from a list
remove_item(Item,[Item|List],List). % simple case, item to remove is the first element
remove_item(Item,[Front|List],[Front|List1]):-  % item is somewhere in the list
    remove_item(Item,List,List1).

% check if a queen is safe from attacks
is_safe([]). % no queens == everything is save
is_safe([Queen|Others]):-
    is_safe(Others),
    no_attack(Queen,Others,1).

% check for possible attack moves
no_attack(_,[],_).
no_attack(Y,[Y1|Ylist],Xdist) :-
    Y1 - Y =\= Xdist,
    Y - Y1 =\= Xdist,
    Dist1 is Xdist + 1,
    no_attack(Y,Ylist,Dist1).

