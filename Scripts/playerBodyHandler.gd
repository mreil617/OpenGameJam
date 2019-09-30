extends Node

#below is code copied from enemy follower.. should instance this stuff
const text_bubble = preload("res://Prefabs/text_bubble.tscn")
var delayed_text = [] # 
var queued_text = []
var current_text_bubble = null
const text_time = 2
var remaining_text_time = 0

func say_something(text, delay = 0, style = 0):
	if delay != 0:
		print("delayed")
		delayed_text.append([text, delay, style])
		return
		
	if remaining_text_time <= 0:
		remaining_text_time = text_time
		if current_text_bubble == null:
			current_text_bubble = text_bubble.instance()
			current_text_bubble.transform.origin.y -= 10
			self.add_child(current_text_bubble) #attached to child instead of parent
			print("created bubble")
		current_text_bubble.show_text(text, style)
		print("said something: " + text)
		if text == "This way Ted":
			say_something(text, 5, style)
	else:
		queued_text.append([text, delay, style])

func _process(delta):
	var body = get_child(0)
	#delayed text
	var continued_delays = []
	for i in delayed_text.size():
		delayed_text[i][1] -= delta
		if delayed_text[i][1] <= 0:
			print("say delay")
			say_something(delayed_text[i][0], 0, delayed_text[i][2])
		else:
			print("continue delay")
			continued_delays.append(delayed_text[i])
	delayed_text = continued_delays
	
	#queued text
	if remaining_text_time > 0:
		remaining_text_time -= delta
		if get_parent().name != "TimeMachine":
			current_text_bubble.set_position(body.get_global_position())
		else:
			current_text_bubble.set_global_position(Vector2(100,100))
	
	if remaining_text_time <= 0 and current_text_bubble != null:
		if queued_text.size() > 0:
			var text = queued_text.pop_front()
			say_something(text[0], text[1], text[2])
		else:
			remove_child(current_text_bubble) #changed to use get child
			current_text_bubble = null
#end copyed code

func hide():
	get_child(0).can_move = false
	#get_child(0).visible = false
	get_child(1).visible = false
	
func takeDamage(amount):
	get_child(0).update_health(-amount)
	
