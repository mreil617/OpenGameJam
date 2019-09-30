extends Node2D

const min_scrap = 3
const max_scrap = 7

var nearby_player = false
var mouse_within = false
var value

func _ready():
	value = randi() % (max_scrap - min_scrap) + min_scrap
	
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
