extends PathFollow2D

const gold_worth = 10
var health = 100
var speed = 1

const text_bubble = preload("res://Prefabs/text_bubble.tscn")
var delayed_text = [] # 
var queued_text = []
var current_text_bubble = null
const text_time = 2
var remaining_text_time = 0

#level one phrases
var ralph_phrases = ["There it is!", "Hurry", "There coming for us!"]
var ralph_phrases_timeline = [0.0, 0.44, 0.8]

const random_word_chance = 2 #percent out of 100
const random_words = ["Where did we go wrong", "Welcome to the future", "I want to go home", "I miss Earth", "Another day another dolla", "This is life"]
const ted_died_random_words = ["Did you hear someone tried to escape?", "Poor Ted", "At least someone is trying", "Who's next?", "We need more Teds"]
const random_word_time = 3 #each person will not say a work more frequently then this
var remaining_random_word_time = 0

func clear_text():
	delayed_text = []
	queued_text = []
	remaining_text_time = 0
	
	if current_text_bubble != null:
		remove_child(current_text_bubble)
		current_text_bubble = null
	
func _process(delta):
	if globals.paused:
		return
		
	#delayed text
	var continued_delays = []
	for i in delayed_text.size():
		delayed_text[i][1] -= delta
		if delayed_text[i][1] <= 0:
			say_something(delayed_text[i][0], 0, delayed_text[i][2])
		else:
			continued_delays.append(delayed_text[i])
	delayed_text = continued_delays
	
	#queued text
	if remaining_text_time > 0:
		remaining_text_time -= delta
	
	if remaining_text_time <= 0 and current_text_bubble != null:
		if queued_text.size() > 0:
			var text = queued_text.pop_front()
			say_something(text[0], text[1], text[2])
		else:
			remove_child(current_text_bubble)
			current_text_bubble = null
	
	#random words
	if remaining_random_word_time > 0:
		remaining_random_word_time -= delta
	elif name != "Ralph":
		remaining_random_word_time = random_word_time
		random_words()
			
	#events
	if name == "player_two" and unit_offset >= 0.7:
		if not get_tree().get_root().get_node("Root").player_has_control:
			globals.paused = true
			get_tree().get_root().get_node("Root/UI/HintPanel").visible = true
			return
	
	if unit_offset >= 1 and name != "player_two" and name != "Ralph":
		get_parent().remove_child(self)		
	elif name == "player_two" and unit_offset >= 1:
		say_something("This way Ted", 0, 1)
	elif name == "Ralph" and ralph_phrases.size() > 0 and unit_offset >= ralph_phrases_timeline[0]:
		ralph_phrases_timeline.pop_front()
		var text = ralph_phrases.pop_front()
		say_something(text, 0, 1)
		if text == "There coming for us!":
			print("toggling")
			get_node("../../Enemies/Spawners/Spawner").can_spawn = true
		
		
	#movement
	if name == "player_two" and unit_offset >= 0.7:
		offset += 1.5
	elif name == "Ralph":
		offset += 1.5
	else:
		offset += 0.5 * speed
		
	if current_text_bubble != null:
		current_text_bubble.set_position(get_child(0).get_position())
		current_text_bubble.set_global_rotation(0)

func random_words():
	var random = randi() % 100 + 1
	if 100 - random_word_chance <= random:
		var word = ""
		if globals.ted_died:
			word = ted_died_random_words[randi() % ted_died_random_words.size()]
		else:
			word = random_words[randi() % random_words.size()]
		self.say_something(word, 0, 0)
		
func takeDamage(amount):
	health -= amount
	var healthbar = get_node("KinematicBody2D/HealthBar")
	if healthbar != null:
		healthbar.set_value(health)
		if health <= 0:
			get_node("../../../UI/VBoxContainer/HBoxContainer/Gold").add_gold(gold_worth)
			get_parent().remove_child(self)
			
		
func say_something(text, delay = 0, style = 0):
	if delay != 0:
		delayed_text.append([text, delay, style])
		return
		
	if remaining_text_time <= 0:
		remaining_text_time = text_time
		if current_text_bubble == null:
			current_text_bubble = text_bubble.instance()
			current_text_bubble.transform.origin.y -= 10
			self.add_child(current_text_bubble)
		current_text_bubble.show_text(text, style)
		if text == "This way Ted" and name != "Ralph":
			say_something(text, 5, style)
	else:
		queued_text.append([text, delay, style])