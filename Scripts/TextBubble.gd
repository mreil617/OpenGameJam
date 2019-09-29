extends Node2D

var bubble_text = ""

func _draw():
	var label = Label.new()
	draw_rect(Rect2(Vector2(self.transform.origin.x, self.transform.origin.y - 10), Vector2(bubble_text.length() * 7, 10)), Color(0,0,0,0.5), true)
	draw_string(label.get_font(""), self.transform.origin, bubble_text, Color(1,1,1,1))
	label.free()
	
func show_text(text):
	bubble_text = text
	update()