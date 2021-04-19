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

ask():-	write("Welcome to Subway. Please answer the following questions."), nl, ask(meal), show(meals), readMeal, nl, show_order.

ask(meal):- write("What kind of meal would you like? ").
ask(bread):- write("What bread would you like? ").
ask(main):- write("What sandwich would you like? ").
ask(sauce):- write("What sauces would you like? ").
ask(veggies):- write("What vegetables would you like?").
ask(sides):- write("Do you want any sides? "). 
ask(toppings):- write("Would you like any additional").

show(ItemList) :- call(ItemList, Item), nl, display(Item), nl.

readMeal():- nl, read(X), meals(M), member(X, M) -> write("Chosen Item: "), write(X), assert(orders(X)), nl, procedure(X); write("Invalid Choice... Please try again"), nl, readMeal().

readSingleInput(List):- nl, read(X), call(List, L), member(X, L) -> write("Chosen Item: "), write(X), assert(orders(X)), nl; write("Invalid Choice... Please try again"), nl, readSingleInput(List).
readMultipleInput(List):- nl, write("Press 0 to stop reading"), nl, read(X), call(List, L), (member(X, L) -> write("Chosen Item: "), write(X), assert(orders(X)), nl, readMultipleInput(List); X==0->doNothing(), nl; (write("Invalid Choice... Please try again"), nl, readMultipleInput(List))).

procedure(normal):- ask(bread), show(breads), readSingleInput(breads),
                    ask(main), show(main), readSingleInput(main),
                    ask(toppings), show(toppings), readMultipleInput(toppings),
                    ask(veggies), show(veggies), readMultipleInput(veggies),
                    ask(sauce), show(sauces), readMultipleInput(sauces),
                    ask(sides), show(sides), readMultipleInput(sides).

procedure(veggie):- ask(bread), show(breads), readSingleInput(breads),
                    ask(main), show(veg), readSingleInput(veg),
                    ask(toppings), show(toppings), readMultipleInput(toppings),
                    ask(veggies), show(veggies), readMultipleInput(veggies),
                    ask(sauce), show(sauces), readMultipleInput(sauces),
                    ask(sides), show(sides), readMultipleInput(sides).

procedure(vegan):- ask(bread), show(breads), readSingleInput(breads),
                    ask(main), show(veg), readSingleInput(veg),
                    ask(toppings), show(vegan_toppings), readMultipleInput(vegan_toppings),
                    ask(veggies), show(veggies), readMultipleInput(veggies),
                    ask(sauce), show(vegan_sauces), readMultipleInput(vegan_sauces),
                    ask(sides), show(sides), readMultipleInput(sides).

procedure(healthy):- ask(bread), show(breads), readSingleInput(breads),
                    ask(main), show(main), readSingleInput(main),
                    ask(toppings), show(toppings), readMultipleInput(toppings),
                    ask(veggies), show(veggies), readMultipleInput(veggies),
                    ask(sauce), show(non_fatty_sauces), readMultipleInput(non_fatty_sauces).

procedure(value):- ask(bread), show(breads), readSingleInput(breads),
                    ask(main), show(main), readSingleInput(main),
                    ask(veggies), show(veggies), readMultipleInput(veggies),
                    ask(sauce), show(sauces), readMultipleInput(sauces),
                    ask(sides), show(sides), readMultipleInput(sides).

display([L]):- write(L).
display([H|T]):- write(H), nl, display(T), !.

show_order():- write("Your order is: "), nl, findall(X, orders(X), List), display(List).

doNothing():- true.