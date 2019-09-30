extends Area2D

var time = 0

func _process(delta):
	if(!self.visible):
		time += delta
		if(time/delta >= 4):
			self.visible = true
	
func _on_HealthPack_body_entered(body):
	if body.get_parent().name == "NavNode":
		get_parent().powerupsOut -= 1
		#get_parent().remove_child(self)
		queue_free()
	else:
		if self.visible and body.get_parent().name == "Player" :
			body.get_parent().takeDamage(-50)
			print("body entered")
			get_parent().powerupsOut -= 1
			queue_free()
