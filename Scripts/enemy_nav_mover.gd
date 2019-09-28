extends Node

func _process(delta):
	if get_child_count() > 1:
		for child in get_child_count() - 1:
			var enemy = get_child(child + 1)
			var path = get_node("../NavNode").get_simple_path(enemy.global_position, get_node("../PSpawn/Player/KinematicBody2D").global_position)
			enemy.path = path
