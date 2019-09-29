extends Node

const spawn_interval = 0.5 #seconds
var time_till_spawn = 0

var spawned_player = false
var should_spawn_player = false

const player_one = preload("res://Prefabs/player_one.tscn")
const player_two = preload("res://Prefabs/player_two.tscn")

const astronaut_one = preload("res://Prefabs/astronaut_one.tscn")
const astronaut_two = preload("res://Prefabs/astronaut_two.tscn")
const astronaut_three = preload("res://Prefabs/astronaut_three.tscn")

const astronauts = [astronaut_one, astronaut_two, astronaut_three]

func start_game():
	should_spawn_player = true
	
func spawn():
	if should_spawn_player and not spawned_player:
		var playertwo = player_two.instance()
		playertwo.name = "player_two"
		get_parent().get_child(6).add_child(playertwo)
		playertwo.say_something("Hey Ted", 2)
		playertwo.say_something("I found a way out", 6)
		playertwo.say_something("No, really", 8)
		playertwo.say_something("These... things...", 8.5)
		playertwo.say_something("They have a time machine", 8.5)
		playertwo.say_something("...", 18)
		playertwo.say_something("I know where they keep it", 18)
		playertwo.say_something("Folow me!", 25)
		
		var playerone = player_one.instance()
		playerone.name = "player_one"
		get_parent().get_child(3).add_child(playerone)
		playerone.say_something("How are you Ralph", 3)
		playerone.say_something("Ready for another day?", 3)
		playerone.say_something("Your crazy", 7)
		playerone.say_something("A what??", 15)
		playerone.say_something("This isn't a movie Ralph", 15)
		
		should_spawn_player = false
		spawned_player = true
	else:
		var astronaut = astronauts[randi() % 3].instance()
		astronaut.name = "astronaut"
		get_parent().get_child(randi() % 5 + 1).add_child(astronaut)
	
func _process(delta):
	time_till_spawn = time_till_spawn - delta
	if time_till_spawn <= 0:
		time_till_spawn = spawn_interval
		spawn()
		
