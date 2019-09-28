extends PathFollow2D

const gold_worth = 10
var health = 100

func _process(delta):
	offset += 1
	if unit_offset >= 1:
		get_parent().remove_child(self)

func takeDamage(amount):
	health -= amount
	get_node("KinematicBody2D/HealthBar").set_value(health)
	if health <= 0:
		get_node("../../../UI/VBoxContainer/HBoxContainer/Gold").add_gold(gold_worth)
		get_parent().remove_child(self)
		
