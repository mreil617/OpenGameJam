extends Node

const enemy_yellowship = preload("res://Prefabs/enemy_yellowship_nav.tscn")
const enemy_greenalien = preload("res://Prefabs/enemy_greenalien_nav.tscn")
const enemy_redalien= preload("res://Prefabs/enemy_redalien_nav.tscn")
const enemy_bluealien = preload("res://Prefabs/enemy_bluealien_nav.tscn")
const enemy_blackalien = preload("res://Prefabs/enemy_blackalien_nav.tscn")
const enemy_boss_one = preload("res://Prefabs/Boss1.tscn")
const enemies = [enemy_yellowship,enemy_greenalien, enemy_redalien, enemy_bluealien, enemy_blackalien]

var can_spawn = false
const spawn_interval = 2.5
var time_till_spawn = spawn_interval
var spawnBoss = false
var enemies_killed = 0
var kills_for_boss = 10
var randNum = 0
var keep_spawning = true

func spawn():
	if(!spawnBoss and keep_spawning):
		var newEnemy = enemies[randi() % enemies.size()].instance()
		newEnemy.name = "enemy"
		newEnemy.transform.origin = self.transform.origin
		get_parent().get_parent().add_child(newEnemy)
	else:
		keep_spawning = false
		var newEnemy = enemy_boss_one.instance()
		newEnemy.name = "enemy"
		newEnemy.transform.origin = self.transform.origin
		get_parent().get_parent().add_child(newEnemy)
	
func _process(delta):
	#print(enemies_killed)
	time_till_spawn -= delta
	if time_till_spawn <= 0 and can_spawn:
		time_till_spawn = spawn_interval
		if(enemies_killed >= kills_for_boss and !spawnBoss):
			randNum = randi()%100+enemies_killed
			print(randNum)
			if(randNum >= 60 and keep_spawning):
				spawnBoss = true
				spawn()
		else:
			if(keep_spawning):
				spawn()
		
