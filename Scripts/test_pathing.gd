extends KinematicBody2D

const flying_text_prefab = preload("res://Prefabs/text_bubble_flying.tscn")

var path : = PoolVector2Array() setget set_path

var health = null
var gold_worth = null
var speed = null
var attack_distance = null
var damage = null
var attack_cooldown = null

var attack_cooldown_remaining = 0

func _ready():
	var stats = get_node("Stats")
	health = stats.health
	gold_worth = stats.value
	speed = stats.speed
	attack_distance = stats.attack_distance
	damage = stats.damage
	attack_cooldown = stats.attack_cooldown
	
	var healthbar = get_node("HealthBar")
	healthbar.max_value = health
	
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
		if attack_cooldown_remaining <= 0 && name != "PlayerBody":
			get_node("../../PSpawn/Player").takeDamage(damage)
			attack_cooldown_remaining = attack_cooldown
		return
		
	for i in range(path.size()):
		var distance_to_next = start_point.distance_to(path[0])
		if distance <= distance_to_next and distance > 0.0:
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
	
func takeDamageEnemy(amount):
	health -= amount
	var healthbar = get_node("HealthBar")
	if healthbar != null:
		healthbar.set_value(health)
		if health <= 0:
			
			var flying_text = flying_text_prefab.instance()
			flying_text.get_node("TextNode").show_text(str(gold_worth), 1)
			flying_text.transform.origin = transform.origin
			get_node("../../FlyingHelpText").add_child(flying_text)
				
			get_node("../../UI/ResouceContainer/HBoxContainer/ResourceLabel").add_resources(gold_worth)
			get_parent().remove_child(self)