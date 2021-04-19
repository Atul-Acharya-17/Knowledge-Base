
% Define the royal family
offspring(prince_charles, queen_elizabeth).
offspring(princess_ann, queen_elizabeth).
offspring(prince_andrew, queen_elizabeth).
offspring(prince_edward, queen_elizabeth).

% Gender of the royal family 
male(prince_charles).
male(prince_andrew).
male(prince_edward).
female(princess_ann).

% Birth order of the royal family
older(prince_charles, princess_ann).
older(princess_ann, prince_andrew).
older(prince_andrew, prince_edward).

/* 
If X is older than Y
And Y is older than Z
Then X is older than Z
*/
is_older(X, Z) :- (older(X, Y), older(Y, Z)); older(X, Z).

/*
The throne is passed down along the male line
according to the order of birth before the consideration along the female line – similarly
according to the order of birth
*/
higher_priority(X, Y) :- male(X), female(Y).
higher_priority(X, Y) :- (male(X), male(Y); female(X), female(Y)), is_older(X, Y).

% Find the succession list
get_successor(SortedList) :- 
findall(X, offspring(X, queen_elizabeth), List),bubble_sort(List, SortedList).

bubble_sort(List,SortedList):-b_sort(List,[],SortedList).
b_sort([],Acc,Acc).
b_sort([H|T],Acc,SortedList):-bubble(H,T,NT,Max),b_sort(NT,[Max|Acc],SortedList).
   
bubble(X,[],[],X).


bubble(X,[Y|T],[Y|NT],Max):- higher_priority(Y,X),bubble(X,T,NT,Max).
bubble(X,[Y|T],[X|NT],Max):- higher_priority(X,Y),bubble(Y,T,NT,Max).