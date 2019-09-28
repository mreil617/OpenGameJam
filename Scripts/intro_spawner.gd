extends Node

const spawn_interval = 0.5 #seconds
var time_till_spawn = 0

const astronaut_one = preload("res://Prefabs/astronaut_one.tscn")
const astronaut_two = preload("res://Prefabs/astronaut_two.tscn")
const astronaut_three = preload("res://Prefabs/astronaut_three.tscn")
const astronauts = [astronaut_one, astronaut_two, astronaut_three]

func spawn():
	var astronaut = astronauts[randi() % 3].instance()
	astronaut.name = "astronaut"
	get_parent().get_child(randi() % 5 + 1).add_child(astronaut)
	
func _process(delta):
	time_till_spawn = time_till_spawn - delta
	if time_till_spawn <= 0:
		time_till_spawn = spawn_interval
		spawn()
		
