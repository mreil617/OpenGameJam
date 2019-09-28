extends ProgressBar

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var player = get_node("../KinematicBody2D")
	if(!player.dead):
		self.rect_position.x = player.position.x-(self.rect_size.x/2)
		self.rect_position.y = player.position.y-86/8-(self.rect_size.y+10)
	else:
		get_parent().remove_child(self)
	#pass
