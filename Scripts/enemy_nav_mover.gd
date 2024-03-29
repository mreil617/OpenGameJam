extends Node

func find_path(pos1, pos2) -> PoolVector2Array:
	return get_node("../NavNode").get_simple_path(pos1, pos2)
	
func _process(delta):
	if get_child_count() > 1:
		for child in get_child_count() - 1:
			var enemy = get_child(child + 1)
			if get_node("../PSpawn").has_node("Player"):
				enemy.path = find_path(enemy.global_position, get_node("../PSpawn/Player/KinematicBody2D").global_position)
			else:
				enemy.path = find_path(enemy.global_position, get_node("../TimeMachine/Player/KinematicBody2D").global_position)
			
	if has_node("../PSpawn/PlayerTwo"):
		get_node("../PSpawn/PlayerTwo/PlayerBody").path = find_path(get_node("../PSpawn/PlayerTwo/PlayerBody").get_global_position(), get_node("../PSpawn/Player/KinematicBody2D").get_global_position())
	
