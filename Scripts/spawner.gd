extends Node

const spawn_interval = 1 #seconds
var time_till_spawn = 0

const enemy_green_alien = preload("res://Prefabs/enemy_green_alien.tscn")
const enemy_yellow_alien = preload("res://Prefabs/enemy_yellow_alien.tscn")
const enemies = [enemy_green_alien, enemy_yellow_alien]

func spawn():
	var newEnemy = enemies[randi() % 2].instance()
	newEnemy.name = "enemy"
	get_parent().get_child(randi() % 2 + 1).add_child(newEnemy)
	
func _process(delta):
	time_till_spawn = time_till_spawn - delta
	if time_till_spawn <= 0:
		time_till_spawn = spawn_interval
		spawn()
		
