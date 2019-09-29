extends Node

var initalSpawn = 3
var SpawnRate = 10
var lastSpawn = 1
var HealthPackPre = preload("res://Prefabs/HealthPack.tscn")

func _ready():
	for i in range(initalSpawn):
		spawn_hp()
		
func _process(delta):
	lastSpawn+=delta
	if int(lastSpawn) % SpawnRate  == 0:
		lastSpawn+=1
		spawn_hp()

func spawn_hp():
	print("spawn")
	var pack = HealthPackPre.instance()
	pack.set_position(Vector2(rand_range(0,1000),rand_range(0,500)))
	self.add_child(pack)
	