extends KinematicBody2D

const speed = 250
var total_distance : float

func _ready():
	total_distance = global_position.distance_to(Vector2(global_position.x, 350))
	
func _process(delta):
	if global_position.y < 350:
		var distance = global_position.distance_to(Vector2(global_position.x, 350))
		print(distance)
		var percent_remaining = distance / total_distance 
		print(percent_remaining)
		
		var velocity = Vector2(0, 1)
		velocity = velocity.normalized() * (speed * percent_remaining)
		velocity = move_and_slide(velocity)