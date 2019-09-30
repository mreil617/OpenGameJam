extends Node2D


func _on_GoalArea_body_entered(body):
	print(" a entered")
	if body.get_parent().name == "Player":
		get_tree().get_root().get_node("Root").complete_goal()
		self.get_parent().queue_free()
