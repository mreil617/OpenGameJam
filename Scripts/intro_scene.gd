extends Node2D

const player = preload("res://Prefabs/Player.tscn")

var paused = false
var player_has_control = false
var ted_died = false
var players_spawned = false
	
func _ready():
	if globals.ted_died:
		get_node("UI/PlayButton/Label").text = "Replay"
		
func give_player_control():
	var cur_player = get_node("Paths/Path3/player_one")
	cur_player.say_something("hello", 0, 1)
	var new_player = player.instance()
	new_player.name = "player"
	add_child(new_player)
	new_player.get_child(0).transform.origin = cur_player.transform.origin
	cur_player.queue_free()
	player_has_control = true
	paused = false
	
func _on_ExitArea_body_entered(body):
	get_tree().change_scene("res://Scenes/Level1.tscn")
