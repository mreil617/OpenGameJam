extends PathFollow2D

const text_bubble = preload("res://Prefabs/text_bubble.tscn")
const gold_worth = 10
var health = 100

var queued_text = []
var current_text_bubble = null
const text_time = 2
var remaining_text_time = 0

const random_words = ["Where did we go wrong", "This place sucks!", "I want to go home", "Another day another dolla", "This is life"]
const random_word_time = 2 #will decide to say random word every this time
var remaining_random_word_time = 0

func _process(delta):
	if remaining_text_time > 0:
		remaining_text_time -= delta
	
	if remaining_text_time <= 0 and current_text_bubble != null:
		if queued_text.size() > 0:
			say_something(queued_text.pop_front())
		else:
			remove_child(current_text_bubble)
			current_text_bubble = null
	
	if remaining_random_word_time > 0:
		remaining_random_word_time -= delta
	else:
		remaining_random_word_time = random_word_time
		random_words()
		
	#movement
	offset += 1
	if unit_offset >= 1:
		get_parent().remove_child(self)

func random_words():
	var random = randi() % 100 + 1
	if random == 100:
		var word = random_words[randi() % random_words.size()]
		self.say_something(word)
		
func takeDamage(amount):
	health -= amount
	var healthbar = get_node("KinematicBody2D/HealthBar")
	if healthbar != null:
		healthbar.set_value(health)
		if health <= 0:
			get_node("../../../UI/VBoxContainer/HBoxContainer/Gold").add_gold(gold_worth)
			get_parent().remove_child(self)
		
func say_something(text):
	if remaining_text_time <= 0:
		remaining_text_time = text_time
		if current_text_bubble == null:
			current_text_bubble = text_bubble.instance()
			current_text_bubble.transform.origin.y -= 10
			self.add_child(current_text_bubble)
		current_text_bubble.show_text(text)
	else:
		queued_text.append(text)