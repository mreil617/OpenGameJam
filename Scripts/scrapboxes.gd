extends Node

func _process(delta):
	if Input.is_action_just_pressed("Lmouse"):
		var nearby_chest = null
		for child in self.get_child_count():
			if get_child(child).can_open():
				self.get_node("../UI/ResouceContainer/HBoxContainer/ResourceLabel").add_resources(get_child(child).value)
				self.remove_child(get_child(child))
				return
				
		