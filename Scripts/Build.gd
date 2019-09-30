extends TextureButton

var building = false
var cursorSprite = preload("res://Prefabs/BuildSprite.tscn")
var build
var canBuild = false
var tempTower = null

var TowerCost = 10
var TowerCost2 = 20
var TowerCost3 = 30

var Tower = preload("res://Prefabs/tower_one.tscn")
var Tower2 = preload("res://Prefabs/tower_two.tscn")
var Tower3 = preload("res://Prefabs/tower_three.tscn")

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
	if(get_node("../../BuildTool") != null):
		return not get_node("../../BuildTool").can_build
  
func _process(delta):
	
	TowerCost = int(get_parent().get_child(2).text)
	
	if(get_node("../../../UI/HBoxContainer/ResourceLabel").current_resources - TowerCost >= 0):
		self.set_modulate(Color(1,1,1,1))
	else:
		self.set_modulate(Color(1,1,1,.5))
				
	if(building):
		if(Input.is_action_just_pressed("exitMenu")):
			building = false
			canBuild = false
			get_node("../../../UI/BuildTool").remove_child(build)
			build.queue_free()
			#build.get_parent().remove_child(self)
		build.set_position(get_global_mouse_position())
		
		if(get_global_mouse_position().distance_to(get_node("../../../PSpawn/Player/KinematicBody2D").get_global_position()) < 100 and 
			get_node("../../../UI/HBoxContainer/ResourceLabel").current_resources - TowerCost >= 0):
			build.set_modulate(Color(1,1,1,1))
			canBuild = true
		else:
			build.set_modulate(Color(1,1,1,.5))
			canBuild = false
		if(canBuild && !overlapping()):
			if(Input.is_action_just_pressed("Lmouse")):
				if(!onPath()):
					if(get_node("../../../UI/HBoxContainer/ResourceLabel").current_resources - TowerCost >= 0):
						if(get_parent().get_child(1).text == "Turret1"):
							print("this")
							tempTower = Tower.instance()
							tempTower.set_position(get_global_mouse_position())
							get_node("../../../TowerHandler").add_child(tempTower)
							get_node("../../../UI/HBoxContainer/ResourceLabel").add_resources(-TowerCost)
						if(get_parent().get_child(1).text == "Turret2"):
							print("thiss")
							tempTower = Tower2.instance()
							tempTower.set_position(get_global_mouse_position())
							get_node("../../../TowerHandler").add_child(tempTower)
							get_node("../../../UI/HBoxContainer/ResourceLabel").add_resources(-TowerCost)
						if(get_parent().get_child(1).text == "Turret3"):
							print("thisss")
							tempTower = Tower3.instance()
							tempTower.set_position(get_global_mouse_position())
							get_node("../../../TowerHandler").add_child(tempTower)
							get_node("../../../UI/HBoxContainer/ResourceLabel").add_resources(-TowerCost)

func _on_TextureButton_pressed():
	if(building):
		building = false
		canBuild = false
		build.visible = false
		build.queue_free()
		#build.get_parent().remove_child(self)
	else:
		building = true
		build = cursorSprite.instance()
		build.get_child(0).texture = self.texture_normal
		get_node("../../").add_child(build)
