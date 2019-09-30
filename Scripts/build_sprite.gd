extends Node2D

var can_build = false

func _on_Area2D_body_entered(body):
	can_build = true
	print("can build")

func _on_Area2D_body_exited(body):
	can_build = false
	print("cannot build")
