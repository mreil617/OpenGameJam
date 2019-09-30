extends Node2D

var move_off_screen = false

func _on_NPCArea_body_entered(body):
	if body.get_parent().name == "Ralph":
		body.get_parent().ralph_can_progress = false
		body.get_parent().say_something("Hello?", 0, 1)
		say_something("Can I help you?", 2, 1)
		body.get_parent().say_something("Dad?", 3.5, 1)
		say_something("Who are you guy?", 5, 1)
		say_something("Why are you wearing that crazy outfit?", 5, 1)
		body.get_parent().say_something("Dad it's me, Ralph", 8.5, 1)
		body.get_parent().say_something("We made a horrible mistake", 8.5, 1)
		body.get_parent().say_something("That plan to go to space worked", 8.5, 1)
		body.get_parent().say_something("...but now we're all slaves", 8.5, 1)
		say_something("Are you mocking me boy?", 16, 1)
		body.get_parent().say_something("Dad I figured it...", 17, 1)
		body.get_parent().say_something("No time to explain", 17, 1)
		body.get_parent().say_something("You have to stop me.", 17, 1)
		say_something("...", 20, 1)
		say_something("Your the competition arn't you", 22, 1)
		say_something("I hope when someone does get to space...", 22, 1)
		say_something("they sell you to the aliens", 22, 1)
		say_something("Now get lost", 22, 1)
		say_something(".. off screen", 28, 1)
		 

#below is code copied from enemy follower.. should instance this stuff
const text_bubble = preload("res://Prefabs/text_bubble.tscn")
var delayed_text = [] # 
var queued_text = []
var current_text_bubble = null
const text_time = 2
var remaining_text_time = 0

func say_something(text, delay = 0, style = 0):
	print("npc say something")
	if delay != 0:
		delayed_text.append([text, delay, style])
		return
		
	if remaining_text_time <= 0:
		remaining_text_time = text_time
		if current_text_bubble == null:
			current_text_bubble = text_bubble.instance()
			current_text_bubble.transform.origin.y -= 10
			self.add_child(current_text_bubble) #attached to child instead of parent
			print("attached bubble")
		current_text_bubble.show_text(text, style)
		if text == "Now get lost":
			move_off_screen = true
		if text == ".. off screen":
			get_node("../RalphPath/Ralph").ralph_can_progress = true
	else:
		queued_text.append([text, delay, style])

func _process(delta):
	if move_off_screen:
		transform.origin.x -= 1
		if transform.origin.x < -1:
			move_off_screen = false
	var body = get_child(0)
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
		#if get_parent().name != "TimeMachine":
		#	current_text_bubble.set_position(Vector2(body.get_global_position().x,body.get_global_position().y))
		#else:
		#	current_text_bubble.set_global_position(Vector2(100,100))
	
	if remaining_text_time <= 0 and current_text_bubble != null:
		if queued_text.size() > 0:
			var text = queued_text.pop_front()
			say_something(text[0], text[1], text[2])
		else:
			remove_child(current_text_bubble) #changed to use get child
			current_text_bubble = null
#end copyed code
