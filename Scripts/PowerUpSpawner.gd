extends Node

var initalSpawn = 3
var SpawnRate = 2
var lastSpawn = 1
var powerupsOut = 0
var HealthPackPre = preload("res://Prefabs/HealthPack.tscn")

func _ready():
	pass
		
func _process(delta):
	if(powerupsOut < 3):
		lastSpawn+=delta
		if int(lastSpawn) % SpawnRate  == 0:
			lastSpawn+=1
			spawn_hp()

func spawn_hp():
	var randPosition = Vector2(rand_range(0,1000),rand_range(0,500))
	powerupsOut += 1
	var pack = HealthPackPre.instance()
	pack.set_position(randPosition)
	self.add_child(pack)
	