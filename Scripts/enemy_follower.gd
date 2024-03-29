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

var ralph_can_progress = true

#level one phrases
var ralph_phrases = []
var ralph_phrases_timeline = []
var ralph_phrases_one = ["There it is!", "Hurry", "They're coming for us!"]
var ralph_phrases_one_timeline = [0.0, 0.44, 0.8]

var ralph_phrases_two = ["Dad!", "Where is he?!", "This can't be right", "Ahhhhh!!!", "Ted HELP", "I'll wait here", "Destroy those beasts!", "Gotta look for Dad", "Have to find Dad", "Where is he!?", "Dad!", "Ted get over here!"]
var ralph_phrases_two_timeline = [0.01, 0.18, 0.3, 0.3673, 0.45, 0.4965, 0.52, 0.63, 0.69, 0.74, 0.86, .98]

var ralph_phrases_three = ["Hope she's here", "Sally!", "Here we go again", "Ahhhhh!!!", "Ted HELP", "Sally look out!", "You got this Ted", "Keep us safe", "Sally!", "Thank you!", "Let's get out of here", "Get in Ted!"]
var ralph_phrases_three_timeline = [0.01, 0.08, 0.17, 0.36, 0.36, 0.46, 0.56, 0.65, 0.79, 0.83, 0.89, 0.96]


const random_word_chance = 2 #percent out of 100
const random_words = ["Where did we go wrong", "Welcome to the future", "I want to go home", "I miss Earth", "Another day another dolla", "This is life"]
const winning_words = ["Where did we go wrong", "How did they defeat us?", "We deserve this", "Do they have a time machine", "Darn Ted"]
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

func _ready():
	ralph_phrases_one = ["There it is!", "Hurry", "They're coming for us!"]
	ralph_phrases_one_timeline = [0.0, 0.44, 0.8]

	ralph_phrases_two = ["Dad! Where are you?", "Where is he?!", "This can't be right", "Ahhhhh!!!", "Ted HELP", "I'll wait here", "Destroy those beasts!","Gotta look for Dad", "Have to find Dad", "Where is he!?", "Dad!" , "Ted get over here!"]
	ralph_phrases_two_timeline = [0.01, 0.18, 0.3, 0.3673, 0.45, 0.4965, 0.4965, 0.52, 0.63, 0.74, 0.86, .98]

	ralph_phrases_three = ["Hope she's here", "Sally!", "Here we go again Ted", "Ahhhhh!!!", "Ted HELP", "Sally look out!", "You got this Ted", "Keep us safe", "Sally!", "Thank you!", "Let's get out of here", "Get in Ted!"]
	ralph_phrases_three_timeline = [0.01, 0.08, 0.17, 0.36, 0.36, 0.46, 0.56, 0.65, 0.79, 0.83, 0.89, 0.96]

	
	var level = get_tree().get_root().get_node("Root").level
	if level == 1:
		ralph_phrases = ralph_phrases_one
		ralph_phrases_timeline = ralph_phrases_one_timeline
	elif level == 2:
		ralph_phrases = ralph_phrases_two
		ralph_phrases_timeline = ralph_phrases_two_timeline
	elif level == 3:
		ralph_phrases = ralph_phrases_three
		ralph_phrases_timeline = ralph_phrases_three_timeline
	elif level != 0:
		print("WARNING unknown level")
		
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
	elif name != "Ralph" and name != "player_one" and name != "player_two":
		remaining_random_word_time = random_word_time
		random_words()
			
	#events
	if name == "player_two" and unit_offset >= 0.7:
		if not get_tree().get_root().get_node("Root").player_has_control:
			globals.paused = true
			get_tree().get_root().get_node("Root/UI/HintPanel").visible = true
			return
	var level = get_tree().get_root().get_node("Root").level
	if unit_offset >= 1 and name != "player_two" and name != "Ralph":
		get_parent().remove_child(self)		
	elif unit_offset >= 1 and name == "Ralph" and (level == 2 or level == 3):
		if get_node("../../TimeMachine").player_present:
			get_node("../../TimeMachine").begin_takeoff()
	elif name == "player_two" and unit_offset >= 1:
		say_something("This way Ted", 0, 1)
	elif name == "Ralph" and ralph_phrases.size() > 0 and unit_offset >= ralph_phrases_timeline[0]:
		ralph_phrases_timeline.pop_front()
		var text = ralph_phrases.pop_front()
		say_something(text, 0, 1)
		if text == "They're coming for us!":
			get_node("../../Enemies/Spawners/Spawner").can_spawn = true
		elif text == "Ahhhhh!!!":
			get_node("../../Enemies/Spawners/Spawner").can_spawn = true
		elif text == "I'll wait here":
			ralph_can_progress = false
		elif text == "Where is he?!":
			get_node("../../PSpawn/Player").say_something("Why are we looking for your Dad?", 0, 1)
		elif text == "Keep us safe":
			ralph_can_progress = false
		
	#movement
	if name == "player_two" and unit_offset >= 0.7:
		offset += 1.5
	elif name == "Ralph" and ralph_can_progress:
		offset += 1.5
	elif name != "Ralph":
		offset += 0.5 * speed
		
	if current_text_bubble != null:
		if get_parent() != null and get_parent().name != "TimeMachine":
		#if get_parent() != null and get_parent().name != "Enemies" and get_parent().name != "TimeMachine":
			current_text_bubble.set_position(get_child(0).get_position())
		#elif get_parent() != null and get_parent().name == "Enemies":
		#	print("this")
			#current_text_bubble.set_position(Vector2(get_child(0).get_position().x, get_child(0).get_position().y-10))
		else:#elif get_parent() != null and get_parent().name == "TimeMachine":
			current_text_bubble.set_global_position(Vector2(100,100))
		current_text_bubble.set_global_rotation(0)
			

func random_words():
	var random = randi() % 100 + 1
	if 100 - random_word_chance <= random:
		var word = ""
		if globals.ted_died:
			word = ted_died_random_words[randi() % ted_died_random_words.size()]
		elif globals.game_won:
			word = winning_words[randi() % winning_words.size()]
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