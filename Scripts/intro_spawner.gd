extends Node

const spawn_interval = 0.5 #seconds
var time_till_spawn = 0
var total_spawns = 0

var spawned_player = false
var should_spawn_player = false

const player_one = preload("res://Prefabs/player_one.tscn")
const player_two = preload("res://Prefabs/player_two.tscn")

const astronaut_one = preload("res://Prefabs/astronaut_one.tscn")
const astronaut_two = preload("res://Prefabs/astronaut_two.tscn")
const astronaut_three = preload("res://Prefabs/astronaut_three.tscn")

const astronauts = [astronaut_one, astronaut_two, astronaut_three]

const path_reset_time = spawn_interval * 2.5
var remaining_path_reset_time = path_reset_time
var available_paths = [1,2,3,4,5]
var unavaliable_paths = []

const speeds = [0.9, 1, 1.1]

func start_game():
	time_till_spawn = spawn_interval * 2
	should_spawn_player = true
	
func spawn():
	
	if globals.ted_died and total_spawns % 75 == 0 and not spawned_player:
		var playertwo = player_two.instance()
		playertwo.name = "player_two_ted_dead"
		get_parent().get_child(2).add_child(playertwo)
		playertwo.say_something("We shouldn't of tried that", 2, 1)
		playertwo.say_something("I got my best friend killed", 6, 1)
		playertwo.say_something("TEDDDDDDDDDDDDDDDDDD", 8.5, 1)
		playertwo.say_something("Stuck here forever", 18, 1)
		
	if should_spawn_player and not spawned_player:
		var playertwo = player_two.instance()
		playertwo.name = "player_two"
		get_parent().get_child(6).add_child(playertwo)
		playertwo.say_something("Hey Ted", 2, 1)
		playertwo.say_something("I found a way out", 6, 1)
		playertwo.say_something("No, really", 8, 1)
		playertwo.say_something("These... things...", 8.5, 1)
		playertwo.say_something("They have a time machine", 8.5, 1)
		playertwo.say_something("...", 18, 1)
		playertwo.say_something("I know where they keep it", 18, 1)
		playertwo.say_something("Folow me!", 25, 1)
		
		var playerone = player_one.instance()
		playerone.name = "player_one"
		get_parent().get_child(3).add_child(playerone)
		playerone.say_something("How are you Ralph", 3, 1)
		playerone.say_something("Ready for another day?", 3, 1)
		playerone.say_something("Your crazy", 7, 1)
		playerone.say_something("A what??", 15, 1)
		playerone.say_something("This isn't a movie Ralph", 15, 1)
		
		should_spawn_player = false
		spawned_player = true
		time_till_spawn = spawn_interval * 2
		
		if get_parent().get_child(2).has_node("player_two_ted_dead"):
			get_parent().get_child(2).remove_child(get_parent().get_child(2).get_node("player_two_ted_dead"))
			
	else:
		if remaining_path_reset_time <= 0:
			for i in unavaliable_paths.size() - 1:
				available_paths.append(unavaliable_paths[i])
			var last = unavaliable_paths.pop_back()
			unavaliable_paths = [last]
			remaining_path_reset_time = path_reset_time
			
		var astronaut = astronauts[randi() % astronauts.size()].instance()
		astronaut.name = "astronaut"
		astronaut.speed = speeds[randi() % speeds.size()]
		var path_idx = randi() % available_paths.size()
		get_parent().get_child(available_paths[path_idx]).add_child(astronaut)
			
		unavaliable_paths.append(available_paths[path_idx])
		available_paths.remove(path_idx)
	
	total_spawns += 1
	
func _process(delta):
	remaining_path_reset_time -= delta
	
	time_till_spawn = time_till_spawn - delta
	if time_till_spawn <= 0:
		time_till_spawn = spawn_interval
		spawn()
		
