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

var ralph_phrases = ["There it is!", "This way Ted", "Hurry", "There coming for us!"]
var ralph_phrases_timeline = [0.0, 0.22, 0.6, 0.6]

const random_words = ["Where did we go wrong", "This place sucks!", "I want to go home", "Another day another dolla", "This is life"]
const ted_died_random_words = ["Did you hear someone tried to escape?", "Poor Ted", "At least someone is trying", "Who's next?", "We need more Teds"]
const random_word_time = 2 #will decide to say random word every this time
var remaining_random_word_time = 0

	
func _process(delta):
	if get_tree().get_root().get_node("Root").paused:
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
	else:
		remaining_random_word_time = random_word_time
		random_words()
			
	#events
	if name == "player_two" and unit_offset >= 0.7:
		if not get_tree().get_root().get_node("Root").player_has_control:
			get_tree().get_root().get_node("Root").paused = true
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
			get_node("../../Enemies/Spawners/Spawner").can_spawn = true
		
		
	#movement
	if name == "player_two" and unit_offset >= 0.7:
		
		offset += 1
	elif name == "Ralph":
		offset += 1
	else:
		offset += 0.5 * speed

func random_words():
	var random = randi() % 100 + 1
	if random == 100:
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