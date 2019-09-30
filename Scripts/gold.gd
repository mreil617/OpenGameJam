extends Label


var total_collected_resources = 0
var current_resources = 0

func _ready():
	text = str(current_resources)

func add_resources(amount):
	if total_collected_resources < 10 and total_collected_resources + amount >= 10:
		get_tree().get_root().get_node("Root/RalphPath/Ralph").say_something("Build defenses with that scrap!", 0, 1)
	
	if current_resources >= 100:
		get_tree().get_root().get_node("Root/RalphPath/Ralph").say_something("Put that scrap to use!", 0, 1)
	
	total_collected_resources += amount
	current_resources = current_resources + amount
	text = str(current_resources)