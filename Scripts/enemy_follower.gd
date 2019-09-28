extends PathFollow2D

const gold_worth = 10
var health = 100

func _process(delta):
	offset += 1

func takeDamage(amount):
	health -= amount
	get_node("KinematicBody2D/HealthBar").set_value(health)
	if health <= 0:
		get_node("../../../UI/Gold").add_gold(gold_worth)
		get_parent().remove_child(self)
		