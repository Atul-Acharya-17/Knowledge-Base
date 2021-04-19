
% sumsum is a competitor of appy
competitor(sumsum, appy).

% galactica-s3 is a smart phone technology
smart_phone_tech(galactica-s3).

% sumsum developed galactica-s3
develop(sumsum, galactica-s3).

% stevey stole galactica-s3
steal(stevey, galactica-s3).

% stevey is the boss of appy
boss(stevey).

% smart phone technology is business
business(P) :- smart_phone_tech(P).

% competitor of appy is a rival
rival(C) :- competitor(C, appy).

% It is unethical for a boss to steal business from rival companies
unethical(B) :- steal(B, P), boss(B), rival(R), develop(R, P), business(P).
