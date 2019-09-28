extends Label

var current_gold = 0
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	text = str(current_gold) + "g"

func add_gold(amount):
	current_gold = current_gold + amount
	text = str(current_gold) + "g"