offspring(prince_charles).
offspring(princess_ann).
offspring(prince_andrew).
offspring(prince_edward).

male(prince_charles).
male(prince_andrew).
male(prince_edward).
female(princess_ann).

older(prince_charles, princess_ann).
older(princess_ann, prince_andrew).
older(prince_andrew, prince_edward).

is_older(X, Z) :- (older(X, Y), older(Y, Z)); older(X, Z).

higher_priority(X, Y) :- male(X), female(Y).
higher_priority(X, Y) :- (male(X), male(Y); female(X), female(Y)), is_older(X, Y).

get_successor(SortedList) :- 
findall(X, offspring(X), List),bubble_sort(List, SortedList).

bubble_sort(List,SortedList):-b_sort(List,[],SortedList).
b_sort([],Acc,Acc).
b_sort([H|T],Acc,SortedList):-bubble(H,T,NT,Max),b_sort(NT,[Max|Acc],SortedList).
   
bubble(X,[],[],X).


bubble(X,[Y|T],[Y|NT],Max):- higher_priority(Y,X),bubble(X,T,NT,Max).
bubble(X,[Y|T],[X|NT],Max):- higher_priority(X,Y),bubble(Y,T,NT,Max).