/*
    Knowledge Base to store options
*/

meals([healthy, normal, value, vegan, veggie]).
breads([wheat, honey_oat, italian, hearty_italian, flatbread]).
main([chicken, beef, ham, bacon, salmon, tuna, turkey, veggie_patty, veggie_delight]).
veg([veggie_patty, veggie_delight]).
veggies([cucumber, green_peppers, lettuce, red_onions, tomatoes]).
sauces([chipotle, bbq, ranch, sweet_chilli, mayo, honey_mustard, sweet_onion]).
vegan_sauces([chipotle, bbq, ranch, sweet_chilli, honey_mustard, sweet_onion]).
non_fatty_sauces([honey_mustard, sweet_onion]).
toppings([american, monterey_jack, cheddar, avocado, egg_mayo]).
vegan_toppings([avocado]).
sides([chips, cookies, hashbrowns, drinks]).

orders(subway_sandwich).


/*
    Questions asked by the prolog terminal to the user
*/
ask():-	write("Welcome to Subway. Please answer the following questions."), nl, 
        ask(meal), show(meals), readMeal, nl, show_order.

ask(meal):- write("What kind of meal would you like? ").
ask(bread):- write("What bread would you like? ").
ask(main):- write("What sandwich would you like? ").
ask(sauce):- write("What sauces would you like? ").
ask(veggies):- write("What vegetables would you like?").
ask(sides):- write("Do you want any sides? "). 
ask(toppings):- write("Would you like any additional toppings").

/*
    Single rule to display lists of all the options
    Uses the display rule to actually display the List
*/
show(ItemList) :- call(ItemList, Item), nl, display(Item), nl.


/*
    Display a List
*/
display([L]):- write(L).
display([H|T]):- write(H), write(", "), display(T), !.


/*
    Read the meal option from the user
*/
readMeal():- nl, read(X), meals(M), 
             member(X, M) -> write("Chosen Item: "), write(X), assert(orders(X)), nl, procedure(X);
             write("Invalid Choice... Please try again"), nl, readMeal().


/*
    Read single input options from the user
*/
readSingleInput(List):- nl, read(X), call(List, L), 
                        member(X, L) -> write("Chosen Item: "), write(X), assert(orders(X)), nl; 
                        write("Invalid Choice... Please try again"), nl, readSingleInput(List).


/*
    Read multiple input options from the user (for toppings, veggies, sauces and sides)
*/
readMultipleInput(List):- nl, write("Press 0 to stop reading"), nl, read(X), call(List, L), 
                          (member(X, L) -> write("Chosen Item: "), write(X), assert(orders(X)), nl,
                          readMultipleInput(List); X==0->doNothing(), nl; (write("Invalid Choice... Please try again"), 
                          nl, readMultipleInput(List))).


/*
    Procedure for normal meal 
*/
procedure(normal):- ask(bread), show(breads), readSingleInput(breads),
                    ask(main), show(main), readSingleInput(main),
                    ask(toppings), show(toppings), readMultipleInput(toppings),
                    ask(veggies), show(veggies), readMultipleInput(veggies),
                    ask(sauce), show(sauces), readMultipleInput(sauces),
                    ask(sides), show(sides), readMultipleInput(sides).

/*
    Procedure for veggie meal
*/
procedure(veggie):- ask(bread), show(breads), readSingleInput(breads),
                    ask(main), show(veg), readSingleInput(veg),
                    ask(toppings), show(toppings), readMultipleInput(toppings),
                    ask(veggies), show(veggies), readMultipleInput(veggies),
                    ask(sauce), show(sauces), readMultipleInput(sauces),
                    ask(sides), show(sides), readMultipleInput(sides).

/*
    Procedure for vegan meal
*/
procedure(vegan):- ask(bread), show(breads), readSingleInput(breads),
                    ask(main), show(veg), readSingleInput(veg),
                    ask(toppings), show(vegan_toppings), readMultipleInput(vegan_toppings),
                    ask(veggies), show(veggies), readMultipleInput(veggies),
                    ask(sauce), show(vegan_sauces), readMultipleInput(vegan_sauces),
                    ask(sides), show(sides), readMultipleInput(sides).

/*
    Procedure for healthy meal
*/
procedure(healthy):- ask(bread), show(breads), readSingleInput(breads),
                    ask(main), show(main), readSingleInput(main),
                    ask(toppings), show(toppings), readMultipleInput(toppings),
                    ask(veggies), show(veggies), readMultipleInput(veggies),
                    ask(sauce), show(non_fatty_sauces), readMultipleInput(non_fatty_sauces).

/*
    Procedure for value meal
*/
procedure(value):- ask(bread), show(breads), readSingleInput(breads),
                    ask(main), show(main), readSingleInput(main),
                    ask(veggies), show(veggies), readMultipleInput(veggies),
                    ask(sauce), show(sauces), readMultipleInput(sauces),
                    ask(sides), show(sides), readMultipleInput(sides).

/*
    Show final order
*/
show_order():- write("Your order is: "), nl, 
               findall(X, orders(X), List), display(List).

/*
    Do Nothing
*/
doNothing():- true.