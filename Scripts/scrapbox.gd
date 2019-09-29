extends Node2D

var nearby_player = false
var mouse_within = false
var value

func _ready():
	value = randi() % 8 + 2
	
func can_open() -> bool:
	if nearby_player and mouse_within:
		return true
	return false

func _on_ScrapboxArea_body_entered(body):
	if body.get_parent().name == "Player":
		nearby_player = true

func _on_ScrapboxArea_body_exited(body):
	if body.get_parent().name == "Player":
		nearby_player = false


func _on_ScrapboxArea_mouse_entered():
	mouse_within = true


func _on_ScrapboxArea_mouse_exited():
	mouse_within = false
