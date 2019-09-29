extends Area2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var colliding = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_CollisionTest_body_entered(body):
	colliding = false
	pass # Replace with function body.
