extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var playerInst

# Called when the node enters the scene tree for the first time.
func _ready():
	playerInst = preload("res://Player.tscn")
	var player = playerInst.instance()
	player.get_child(0).set_position(Vector2(self.position.x,self.position.y*4))
	self.add_child(player)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
