class_name Order

enum CookedToppings {
	Lamb,
	Beef,
	Chicken,
	Turkey,
	Chips
}

var cooked_topings: Array[CookedToppings] = []

func rank_cooked_toppings(wrap_node):
	pass

enum Toppings {
	Tomato,
	Lettuce,
	Onion,
	Cabbage,
	Chili,
	Cucumber
}

func topping_to_string(topping: Toppings) -> String:
	match topping:
		Toppings.Tomato:
			return "Tomato"
		Toppings.Lettuce:
			return "Lettuce"
		Toppings.Onion:
			return "Onion"
		Toppings.Cabbage:
			return "Cabbage"
		Toppings.Chili:
			return "Chili"
		Toppings.Cucumber:
			return "Cucumber"
	
	push_warning("pint is bad")
	return ""


var toppings: Array[Toppings] = []

func rank_toppings(wrap_node):
	var used = {}
	
	for item in toppings:
		used[topping_to_string(item)] = false
	
	for child in wrap_node.get_children():
		if child.is_in_group("sauce"):
			used[child.get_meta("topping_type")] = true
			
	var fraction_used = used.values().reduce(func (acc, v): return acc + int(v), 0) / used.size()
		
	return fraction_used


enum Sauce {
	Chili,
	Ketchup,
	Mayo,
	Yogurt,
	BBQ,
}

func sauce_to_string(sauce: Sauce) -> String:
	match sauce:
		Sauce.Chili:
			return "chili"
		Sauce.Ketchup:
			return "ketchup"
		Sauce.Mayo:
			return "mayo"
		Sauce.Yogurt:
			return "yogurt"
		Sauce.BBQ:
			return "bbq"
	push_warning("pint is bad")
	return ""


var sauces: Array[Sauce] = []

func rank_sauces(wrap_node:Node) -> float:
	var used = {}
	
	for item in sauces:
		used[sauce_to_string(item)] = false
	
	for child in wrap_node.get_children():
		if child.is_in_group("sauce"):
			used[child.get_meta("sauce_name")] = true
			

	var fraction_used = used.values().reduce(func (acc, v): return acc + int(v), 0) / used.size()
			

	return fraction_used



enum Pint {
	Tenents,
	Belhaven,
	West,
	Bru
}

func pint_to_string(pint_enum: Pint) -> String:
	match pint_enum:
		Pint.Tenents:
			return "tenents"
		Pint.West:
			return "west"
		Pint.Bru:
			return "bru"
		Pint.Belhaven:
			return "belhaven"
			
	push_warning("pint is bad")
	return ""

var pint: Pint
var head_wanted: float

func integer_linear_ranking(x: float, s:float, m:float,c: float,):
	if abs(x) < s:
		return 1
	else:
		return abs(m * (abs(x) -s) + c)

func rank_pint(pint_node: Node):
	var type = pint_node.get_meta("beer_type")
	
	
	if not type:
		print("beer without type")
		return 1
		
	if type != pint_to_string(pint):
		return 0
				
	return integer_linear_ranking(pint_node.head_portion - head_wanted, 0.1, -0.6, 1) * integer_linear_ranking(abs(pint_node.beer_procress), 0.2, -1, 1)


func _init(new_cooked_topings: Array[CookedToppings], new_toppings: Array[Toppings], new_sauces: Array[Sauce], new_pint: Pint, new_head: float):
	cooked_topings = new_cooked_topings
	toppings = new_toppings
	sauces = new_sauces
	pint = new_pint
	head_wanted = new_head
