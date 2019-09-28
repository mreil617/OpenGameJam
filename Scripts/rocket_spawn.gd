extends KinematicBody2D

const speed = 250
var landed = false
var total_distance : float

func _ready():
	total_distance = global_position.distance_to(Vector2(global_position.x, 350))
	
func _process(delta):
	print(str(landed))
	if landed:
		return 
	
	var distance = global_position.distance_to(Vector2(global_position.x, 350))
	var percent_remaining = distance / total_distance 
	
	if percent_remaining > 0.005 and global_position.y < 350:
		
		var velocity = Vector2(0, 1)
		velocity = velocity.normalized() * (speed * percent_remaining)
		velocity = move_and_slide(velocity)
	
	else:
		landed = true
		get_node("../../Player").set_visible(true)
		print("Ran")