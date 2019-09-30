extends Node

func _on_Play_pressed():
	get_node("../Paths/Spawner").start_game()
	get_node("PlayButton").visible = false

func _on_WASDHint_pressed():
	get_node("HintPanel").visible = false
	get_node("../").give_player_control()

func _on_SkipButton_pressed():
	get_node("../Paths/RalphPath/player_two").unit_offset = 0.65
	get_node("../Paths/RalphPath/player_two").clear_text()
	get_node("../Paths/RalphPath/player_two").say_something("Folow me!", 1, 1)
	
	get_node("../Paths/Path3/player_one").unit_offset = 0.65
	get_node("../Paths/Path3/player_one").clear_text()
	
	get_node("SkipButton").visible = false
	
