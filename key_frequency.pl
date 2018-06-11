% count and sort the frequency distribution of a list of keys
freq_dist(List, Result) :- freq_dist(List, [], Result).
freq_dist([], Result, Result).
freq_dist([Key|L], S1, S3) :- insert_key(Key, S1, S2), freq_dist(L, S2, S3).

% insert keys into the list (sorted!)
% insert_key(Key, ListBefore, ListAfter)

% first key
insert_key(Key, [], [1 * Key]).

% key is already the front, increment the count
insert_key(Key, [Freq*Key|SortedList], [Freq1*Key|SortedList]) :-
    !,
    Freq1 is Freq + 1.

% key is not the first element but should be:
insert_key(Key, [Freq*OtherKey|SortedList], [1*Key, Freq*OtherKey|SortedList]) :-
    Key < OtherKey,
    !.

% new key belongs in the middle of the list
insert_key(Key, [Freq*OtherKey|SortedList], [Freq*OtherKey|SortedList1]) :-
    Key \== OtherKey,
    insert_key(Key,SortedList,SortedList1).
