extends TextureButton

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var building = false
var cursorSprite
var build
var canBuild = false

const TowerCost = 10

var Tower

# Called when the node enters the scene tree for the first time.
func _ready():
	Tower = preload("res://Prefabs/tower_one.tscn")
	pass # Replace with function body.

func overlapping():
	var overlap = false
	var towers = get_node("../../../TowerHandler").get_children()
	#for i in towers:
		#print(i.overlapping)
#		if(i.overlapping):
#			overlap = true
#			break
#		else:
#			overlap = false
#	return overlap
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(building):
		if(Input.is_action_just_pressed("exitMenu")):
			building = false
			build.visible = false
			build.get_parent().remove_child(self)
		build.set_position(get_global_mouse_position())
		if(get_global_mouse_position().distance_to(get_node("../../../PSpawn/Player/KinematicBody2D").get_global_position()) < 100):
			build.set_modulate(Color(1,1,1,1))
			canBuild = true
		else:
			build.set_modulate(Color(1,1,1,.5))
			canBuild = false
				
	if(canBuild && !overlapping()):
		if(Input.is_action_just_pressed("Lmouse")):
			if(get_node("../../../UI/VBoxContainer/HBoxContainer/Gold").current_gold - TowerCost >= 0):
				var tempTower = Tower.instance()
				tempTower.set_position(get_global_mouse_position())
				get_node("../../../TowerHandler").add_child(tempTower)
				get_node("../../../UI/VBoxContainer/HBoxContainer/Gold").add_gold(-TowerCost)
#	pass

func _on_TextureButton_pressed():
	if(building):
		building = false
		build.visible = false
		build.get_parent().remove_child(self)
	else:
		building = true
		cursorSprite = load("res://BuildSprite.tscn")
		build = cursorSprite.instance()
		build.texture = self.texture_normal
		get_node("../../").add_child(build)
