extends Node

const enemy_yellowship = preload("res://Prefabs/enemy_yellowship_nav.tscn")
const enemy_greenalien = preload("res://Prefabs/enemy_greenalien_nav.tscn")
const enemy_redalien= preload("res://Prefabs/enemy_redalien_nav.tscn")
const enemy_bluealien = preload("res://Prefabs/enemy_bluealien_nav.tscn")
const enemy_blackalien = preload("res://Prefabs/enemy_blackalien_nav.tscn")
const enemies = [enemy_yellowship,enemy_greenalien, enemy_redalien, enemy_bluealien, enemy_blackalien]

var can_spawn = false
const spawn_interval = 2.5
var time_till_spawn = spawn_interval

func spawn():
	var newEnemy = enemies[randi() % enemies.size()].instance()
	newEnemy.name = "enemy"
	newEnemy.transform.origin = self.transform.origin
	get_parent().get_parent().add_child(newEnemy)
	
func _process(delta):
	time_till_spawn -= delta
	if time_till_spawn <= 0 and can_spawn:
		time_till_spawn = spawn_interval
		spawn()
