extends Area2D

func _on_HealthPack_body_entered(body):
	if body.get_parent().name == "NavNode":
		get_parent().powerupsOut -= 1
		get_parent().remove_child(self)
	else:
		if self.visible and body.get_parent().name != "Enemies" :
			body.get_parent().takeDamage(-50)
			print("body entered")
			self.visible = false
			get_parent().powerupsOut -= 1