extends Node

const enemy_yellowship = preload("res://Prefabs/enemy_yellowship_nav.tscn")
const enemies = [enemy_yellowship]

const spawn_interval = 1
var time_till_spawn = 0

func spawn():
	var newEnemy = enemies[randi() % enemies.size()].instance()
	newEnemy.name = "enemy"
	newEnemy.transform.origin = self.transform.origin
	get_parent().get_parent().add_child(newEnemy)
	
func _process(delta):
	time_till_spawn -= delta
	if time_till_spawn <= 0:
		time_till_spawn = spawn_interval
		spawn()
