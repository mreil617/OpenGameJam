extends Label

var current_resources = 15
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	text = str(current_resources)

func add_resources(amount):
	current_resources = current_resources + amount
	text = str(current_resources)