extends Node2D

const level = 3
var has_key = false

func complete_goal():
	has_key = true
	get_node("RalphPath/Ralph").say_something("Bring that over here Ted!", 0, 1)