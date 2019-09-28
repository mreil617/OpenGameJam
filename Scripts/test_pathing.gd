extends KinematicBody2D

var path : = PoolVector2Array() setget set_path
const speed = 100
const attack_distance = 40
const damage = 10
const attack_cooldown = 2
var attack_cooldown_remaining = 0

func _ready():
	set_process(false)

func _process(delta):
	if attack_cooldown_remaining > 0:
		attack_cooldown_remaining -= delta
		
	var move_distance = speed * delta
	move_along_path(move_distance)
	
func move_along_path(distance: float):
	var start_point = position
	
	var total_distance = 0
	var last_point = position
	for j in range(path.size()):
		total_distance = total_distance + last_point.distance_to(path[j])
		last_point = path[j]
	
	if path.size() > 0 and total_distance <= attack_distance:
		if attack_cooldown_remaining <= 0:
			get_node("../Player").takeDamage(damage)
			attack_cooldown_remaining = attack_cooldown
		return
		
	for i in range(path.size()):
		var distance_to_next = start_point.distance_to(path[0])
		if distance <= distance_to_next and distance >= 0.0:
			position = start_point.linear_interpolate(path[0], distance / distance_to_next)
			break
		elif distance < 0.0:
			position = path[0]
			set_process(false)
			break
		distance -= distance_to_next
		start_point = path[0]
		path.remove(0)
	
func set_path(value: PoolVector2Array):
	path = value
	if value.size() == 0:
		return
	set_process(true)