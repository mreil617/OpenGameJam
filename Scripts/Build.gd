extends TextureButton

var building = false
var cursorSprite = preload("res://Prefabs/BuildSprite.tscn")
var build
var canBuild = false

const TowerCost = 10

var Tower = preload("res://Prefabs/tower_one.tscn")

func overlapping():
	var overlap = false
	var towers = get_node("../../../TowerHandler").get_children()
	for i in towers:
		if(i.IsOverlapping):
			overlap =  true
			break
		else:
			overlap = false
	return overlap
	
func onPath():
	return not get_node("../../BuildTool").can_build
  
func _process(delta):
	if(building):
		if(Input.is_action_just_pressed("exitMenu")):
			building = false
			build.visible = false
			build.get_parent().remove_child(self)
		build.set_position(get_global_mouse_position())
		
		if(get_global_mouse_position().distance_to(get_node("../../../PSpawn/Player/KinematicBody2D").get_global_position()) < 100 and 
			get_node("../../../UI/ResouceContainer/HBoxContainer/ResourceLabel").current_resources - TowerCost >= 0):
			build.set_modulate(Color(1,1,1,1))
			canBuild = true
		else:
			build.set_modulate(Color(1,1,1,.5))
			canBuild = false
	if(canBuild && !overlapping()):
		if(Input.is_action_just_pressed("Lmouse")):
			if(!onPath()):
				if(get_node("../../../UI/ResouceContainer/HBoxContainer/ResourceLabel").current_resources - TowerCost >= 0):
					var tempTower = Tower.instance()
					tempTower.set_position(get_global_mouse_position())
					get_node("../../../TowerHandler").add_child(tempTower)
					get_node("../../../UI/ResouceContainer/HBoxContainer/ResourceLabel").add_resources(-TowerCost)

func _on_TextureButton_pressed():
	if(building):
		building = false
		build.visible = false
		build.get_parent().remove_child(self)
	else:
		building = true
		build = cursorSprite.instance()
		build.get_child(0).texture = self.texture_normal
		get_node("../../").add_child(build)
