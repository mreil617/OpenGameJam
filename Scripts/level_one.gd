extends Node2D

const level = 1
var paused = false
var can_spawn = false
var has_key = true

func complete_goal():
	has_key = true
	get_node("RalphPath/Ralph").say_something("Bring that over here Ted!", 0, 1)