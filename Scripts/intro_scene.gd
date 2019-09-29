extends Node2D

const player = preload("res://Prefabs/Player.tscn")

var paused = false
var player_has_control = false

func give_player_control():
	var cur_player = get_node("Paths/Path3/player_one")
	var new_player = player.instance()
	new_player.name = "player"
	add_child(new_player)
	new_player.get_child(0).transform.origin = cur_player.transform.origin
	remove_child(cur_player)
	player_has_control = true
	paused = false
	

func _on_ExitArea_body_entered(body):
	get_tree().change_scene("res://Scenes/sTemp2.tscn")
