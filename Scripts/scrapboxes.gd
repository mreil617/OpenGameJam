extends Node

const flying_text_prefab = preload("res://Prefabs/text_bubble_flying.tscn")

func _process(delta):
	if Input.is_action_just_pressed("Lmouse"):
		var nearby_chest = null
		for child in self.get_child_count():
			if get_child(child).can_open():
				
				var flying_text = flying_text_prefab.instance()
				flying_text.get_node("TextNode").show_text(str(get_child(child).value), 1)
				flying_text.transform.origin = get_child(child).transform.origin
				get_node("../FlyingHelpText").add_child(flying_text)
				
				self.get_node("../UI/ResouceContainer/HBoxContainer/ResourceLabel").add_resources(get_child(child).value)
				self.remove_child(get_child(child))
				return