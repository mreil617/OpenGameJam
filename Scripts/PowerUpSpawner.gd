extends Node

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var initalSpawn = 3
var SpawnRate = 10
var lastSpawn = 1
var HealthPackPre

# Called when the node enters the scene tree for the first time.
func _ready():
	HealthPackPre = preload("res://HealthPack.tscn")
	for i in range(initalSpawn):
		spawn_hp()
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	lastSpawn+=delta
	if int(lastSpawn) % SpawnRate  == 0:
		lastSpawn+=1
		spawn_hp()
#	pass

func spawn_hp():
	print("spawn")
	var pack = HealthPackPre.instance()
	pack.set_position(Vector2(rand_range(0,1000),rand_range(0,500)))
	self.add_child(pack)
	