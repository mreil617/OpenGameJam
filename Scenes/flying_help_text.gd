extends Node

export (int) var speed = 1000

var target = Vector2()

func _ready():
	target = get_node("../UI/HBoxContainer").get_global_position()

func _physics_process(delta):
	var velocity = null
	var removes = []
	for child in get_child_count():
		if (target - get_child(child).transform.origin).length() > 10:
			velocity = (target - get_child(child).transform.origin).normalized() * speed
			get_child(child).move_and_slide(velocity)
		else:
			removes.append(get_child(child).name)
	
	for name in removes:
		remove_child(get_node(name))
		