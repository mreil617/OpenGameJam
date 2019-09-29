extends Node2D

func _on_TimeMachineArea_body_entered(body):
	print(body.get_parent().name + " entered time machine")
	if body.get_parent().name == "Player":
		body.get_parent().say_something("It's locked...", 0, 1)
		get_node("../RalphPath/Ralph").say_something("Key has to be here somewhere", 1, 1)
		get_node("../RalphPath/Ralph").say_something("I'll watch the time machine", 1, 1)
