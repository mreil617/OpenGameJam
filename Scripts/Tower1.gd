extends Node

const duel_laser = preload("res://Prefabs/duel_laser.tscn")

const damage = 20
const bullet_speed = 5
const cooldown = 2 #seconds
var remaining_cooldown = 0
var IsOverlapping = false

var enemies_in_range = []
var lasers = []

func _on_RangeArea_body_entered(body):
	enemies_in_range.append(body)

func _on_RangeArea_body_exited(body):
	enemies_in_range.remove(enemies_in_range.find(body))

func _process(delta):
	remaining_cooldown = remaining_cooldown - delta
	
	if enemies_in_range.size() > 0 && remaining_cooldown <= 0:
		remaining_cooldown = cooldown
		var turretBody = get_node("KinematicBody2D")
		var targetPosition = enemies_in_range.front().transform.origin
		turretBody.look_at(targetPosition)
		turretBody.rotate(275 * PI / 180) #adjusts rotation from lookat to be slightly in-front
		##enemies_in_range.front().get_parent().takeDamage(damage)
		
		var laser = duel_laser.instance()
		laser.name = "laser"
		laser.get_child(0).transform.origin = self.transform.origin
		add_child(laser)
		lasers.append(laser)
	
	if enemies_in_range.size() > 0:
		var targetPosition = enemies_in_range.front().transform.origin
		for lsr in lasers:
			lsr.get_child(0).look_at(targetPosition)
			lsr.get_child(0).rotate(275 * PI / 180)
			var velocity = (targetPosition - lsr.get_child(0).transform.origin).normalized() * bullet_speed
			var collision = lsr.get_child(0).move_and_collide(velocity)
			if collision != null:
#				collision.collider.get_parent().takeDamage(damage)
				collision.collider.takeDamageEnemy(damage)
				remove_child(lsr)
				lasers.remove(lasers.find(lsr))
	else:
		for lsr in lasers:
			remove_child(lsr)
		lasers.clear()
		

func _on_HoverArea_mouse_entered():
	get_node("RangeSprite").visible = true
	IsOverlapping = true

func _on_HoverArea_mouse_exited():
	get_node("RangeSprite").visible = false
	IsOverlapping = false
