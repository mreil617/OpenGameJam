extends ProgressBar

func _process(delta):
	var player = get_node("../KinematicBody2D")
	if(!player.dead):
		self.rect_position.x = player.position.x-(self.rect_size.x/2)
		self.rect_position.y = player.position.y-86/8-(self.rect_size.y+10)
	else:
		get_parent().remove_child(self)
