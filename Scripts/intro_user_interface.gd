extends Node

func _on_Play_pressed():
	get_node("../Paths/Spawner").start_game()
	get_node("Button").visible = false

func _on_WASDHint_pressed():
	get_node("HintPanel").visible = false
	get_node("../").give_player_control()
