extends Area2D

func _on_HealthPack_body_entered(body):
	body.get_parent().takeDamage(-50)
	print("body entered")
	get_parent().remove_child(self)

