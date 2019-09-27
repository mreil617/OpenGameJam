extends KinematicBody2D

export (int) var speed = 200

var velocity = Vector2()
var health = 100
var max_health = 100
var damage = -10
var dead = false

func _ready():
	get_node("../Player_Health").set_value(max_health)
	
func _process(delta):
	if(health == 0):
		dead = true
		print("died")
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
	update_health(max_health)
	self.position.x = OS.get_window_size().x/2
	self.position.y = OS.get_window_size().y/2
	
func update_health(amount):
	health += amount
	get_node("../Player_Health").set_value(health)