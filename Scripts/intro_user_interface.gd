extends Node

func _on_Play_pressed():
	if get_tree().get_root().get_node("Root").level == 4:
		get_tree().change_scene("res://Scenes/intro_scene.tscn")
		get_node("PlayButton").visible = false
		get_node("Title2").visible = false
	else:
		get_node("../Paths/Spawner").start_game()
		get_node("PlayButton").visible = false
		get_node("Title").visible = false

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
	
