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
			var level = get_tree().get_root().get_node("Root").level
			if level == 1:
				get_tree().change_scene("res://Scenes/Level2.tscn")
			elif level == 2:
				get_tree().change_scene("res://Scenes/Level3.tscn")
			elif level == 3:
				get_tree().change_scene("res://Scenes/intro_scene.tscn")
			else:
				print("ERROR: time machine doesnt know what level we're on")
		
	
func _on_TimeMachineArea_body_entered(body):
	if body.get_parent().name == "Player" and not active:
		if get_parent().has_key == false:
			body.get_parent().say_something("It's locked...", 0, 1)
			var ralph = get_node("../RalphPath/Ralph")
			ralph.say_something("Key has to be here somewhere", 1, 1)
			ralph.say_something("Check those orange barrels", 1, 1)
		else:
			active = true
			body.global_position = Vector2(0,0)
			var playerRoot = body.get_parent()
			playerRoot.say_something("Get in Ralph!",0,1)
			playerRoot.say_something("Where are we headed anyway?",2,1)
			playerRoot.say_something("Really??????",4,1)
			body.get_node("../../../PSpawn").remove_child(playerRoot)
			self.add_child(playerRoot)
			
			var ralph = get_node("../RalphPath/Ralph")
			ralph.global_position = Vector2(0,0)
			ralph.get_parent().remove_child(ralph)
			self.add_child(ralph)
			
			ralph.say_something("Theres someone I need you to meet", 3, 1)
			ralph.say_something("Almost there!", 3, 1)
			playerRoot.hide()
