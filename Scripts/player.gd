extends KinematicBody2D

export (int) var speed = 200

var velocity = Vector2()
var health = 100
var max_health = 100
var damage = -10
var dead = false

func _ready():
	get_node("../PlayerHealth").set_value(max_health)
	
func _process(delta):
	if(health <= 0):
		dead = true
		respawn()
	
func get_input():
	look_at(get_global_mouse_position())
	velocity = Vector2()
	if Input.is_action_pressed('right'):
		velocity.x += 1
	if Input.is_action_pressed('left'):
		velocity.x -= 1
	if Input.is_action_pressed('backward'):
		velocity.y += 1
	if Input.is_action_pressed('forward'):
		velocity.y -= 1
	velocity = velocity.normalized() * speed
	
	if Input.is_action_just_pressed("Lmouse"):
		update_health(damage)
	
func _physics_process(delta):
	get_input()
	velocity = move_and_slide(velocity)
	
func respawn():
	dead = false
	self.set_position(get_node("../../../PSpawn").get_global_position())
	health = 0
	update_health(max_health)
	
func update_health(amount):
	health += amount
	get_node("../PlayerHealth").set_value(health)
