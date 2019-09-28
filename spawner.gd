extends Node

const spawn_interval = 1 #seconds
var time_till_spawn = 0

const enemy_yellow_alien = preload("res://enemy_yellow_alien.tscn")

func spawn():
	var newEnemy = enemy_yellow_alien.instance()
	newEnemy.name = "enemy"
	get_parent().get_child(randi() % 2 + 1).add_child(newEnemy)
	
func _process(delta):
	time_till_spawn = time_till_spawn - delta
	if time_till_spawn <= 0:
		time_till_spawn = spawn_interval
		spawn()
		
