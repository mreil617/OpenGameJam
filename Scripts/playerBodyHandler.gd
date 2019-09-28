extends Node

func takeDamage(amount):
	get_child(0).update_health(-amount)