extends KinematicBody2D

var warmed_up = false
var speed = 500
var step = 0
var target = null
var active = false

func _ready():
	target = get_node("../TimeMachinePoints").get_child(step).get_global_position()

func _physics_process(delta):
	if active and not warmed_up:
		if (target - transform.origin).length() <= 10:
			step += 1
			speed += 100
			if step >= get_node("../TimeMachinePoints").get_child_count():
				step = 0
			target = get_node("../TimeMachinePoints").get_child(step).get_global_position()
			
		var velocity = (target - transform.origin).normalized() * speed 
		self.move_and_slide(velocity)
		
		if speed >= 1600:
			warmed_up = true
			target = get_node("../TimeMachinePoints").get_child(0).get_global_position()
	elif active and warmed_up:
		speed = 1000
		if (target - transform.origin).length() >= 10:
			var velocity = (target - transform.origin).normalized() * speed 
			self.move_and_slide(velocity)
		else:
			get_tree().change_scene("res://Scenes/Level2.tscn")
		
	
func _on_TimeMachineArea_body_entered(body):
	print("enter")
	if body.get_parent().name == "Player":
		if get_parent().has_key == false:
			print("false")
			body.get_parent().say_something("It's locked...", 0, 1)
			get_node("../RalphPath/Ralph").say_something("Key has to be here somewhere", 1, 1)
			get_node("../RalphPath/Ralph").say_something("Check those orange barrels", 1, 1)
		else:
			body.get_parent().say_something("Get in Ralph!",0,1)
			body.get_parent().say_something("Where are we headed anyway?",2,1)
			body.get_parent().say_something("Really??????",4,1)
			get_node("../RalphPath/Ralph").visible = false
			get_node("../RalphPath/Ralph").say_something("Theres someone I need you to meet", 3, 1)
			get_node("../RalphPath/Ralph").say_something("Almost there!", 3, 1)
			body.get_parent().hide()
			active = true
			
