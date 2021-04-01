competitor(sumsum, appy).
smart_phone_tech(galactica-s3).
develop(sumsum, galactica-s3).
steal(stevey, galactica-s3).
boss(stevey).
business(P) :- smart_phone_tech(P).
rival(C) :- competitor(C, appy).

unethical(X) :- steal(X, P),boss(X),rival(R),develop(R, P),business(P).