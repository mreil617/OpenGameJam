extends Node2D

var playerInst = preload("res://Prefabs/Player.tscn")
var player_two_prefab = preload("res://Prefabs/player_two.tscn")

func _ready():
	if get_node("../RalphPath") != null:
		var player_two = player_two_prefab.instance()
		player_two.name = "Ralph"
		get_node("../RalphPath").add_child(player_two)
	
	var player_one = playerInst.instance()
	player_one.get_child(0).set_position(self.get_global_position())
	self.add_child(player_one)