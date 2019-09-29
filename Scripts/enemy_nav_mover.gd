extends Node

func find_path(pos1, pos2) -> PoolVector2Array:
	return get_node("../NavNode").get_simple_path(pos1, pos2)
	
func _process(delta):
	if get_child_count() > 1:
		for child in get_child_count() - 1:
			var enemy = get_child(child + 1)
			
			#var path = get_node("../NavNode").get_simple_path(enemy.global_position, get_node("../PSpawn/Player/KinematicBody2D").global_position)
			enemy.path = find_path(enemy.global_position, get_node("../PSpawn/Player/KinematicBody2D").global_position)
			
	if get_node("../PSpawn/PlayerTwo") != null:
		get_node("../PSpawn/PlayerTwo/PlayerBody").path = find_path(get_node("../PSpawn/PlayerTwo/PlayerBody").get_global_position(), get_node("../PSpawn/Player/KinematicBody2D").get_global_position())
	
