extends Node

const enemy_yellowship = preload("res://Prefabs/enemy_yellowship_nav.tscn")
const enemy_greenalien = preload("res://Prefabs/enemy_greenalien_nav.tscn")
const enemy_redalien= preload("res://Prefabs/enemy_redalien_nav.tscn")
const enemy_bluealien = preload("res://Prefabs/enemy_bluealien_nav.tscn")
const enemy_blackalien = preload("res://Prefabs/enemy_blackalien_nav.tscn")
const enemy_boss_one = preload("res://Prefabs/Boss1.tscn")
const enemy_boss_two = preload("res://Prefabs/Boss2.tscn")
const enemy_boss_three = preload("res://Prefabs/Boss3.tscn")
const enemies = [enemy_yellowship,enemy_greenalien, enemy_redalien, enemy_bluealien, enemy_blackalien]

var can_spawn = false
var spawn_interval = 2.5
var time_till_spawn = spawn_interval
var spawnBoss = false
var enemies_killed = 0
var kills_for_boss = 10
var randNum = 0
var keep_spawning = true
var newEnemy = null

func spawn():
	if(!spawnBoss and keep_spawning):
		newEnemy = enemies[randi() % enemies.size()].instance()
		newEnemy.name = "enemy"
		newEnemy.transform.origin = self.transform.origin
		get_parent().get_parent().add_child(newEnemy)
	else:
		keep_spawning = false
		if(get_tree().get_root().get_node("Root").level == 1):
			newEnemy = enemy_boss_one.instance()
		elif(get_tree().get_root().get_node("Root").level == 2):
			newEnemy = enemy_boss_two.instance()
		elif(get_tree().get_root().get_node("Root").level == 3):
			newEnemy = enemy_boss_three.instance()
		newEnemy.name = "enemy"
		newEnemy.transform.origin = self.transform.origin
		get_parent().get_parent().add_child(newEnemy)
	
func _process(delta):
	#print(enemies_killed)
	time_till_spawn -= delta
	if(get_tree().get_root().get_node("Root").level == 1):
		spawn_interval = 5
	elif(get_tree().get_root().get_node("Root").level == 2):
		spawn_interval = 4
	elif(get_tree().get_root().get_node("Root").level == 3):
		spawn_interval = 3
	if time_till_spawn <= 0 and can_spawn:
		time_till_spawn = spawn_interval
		if(enemies_killed >= kills_for_boss and !spawnBoss):
			spawn_interval = 2
			randNum = randi()%100+enemies_killed
			print(randNum)
			if(randNum >= 60 and keep_spawning):
				spawnBoss = true
				spawn()
		else:
			if(keep_spawning):
				spawn()
		
