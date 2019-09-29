extends Node2D

var bubble_text = ""
var text_style = 0

func _draw():
	
	var label = Label.new()
	var font = label.get_font("")
	var size = font.get_string_size(bubble_text)
	
	var color = Color(1,1,1,1)
	if text_style == 1:
		color = Color(1,0.84,0,1)
		
	
	
	
	draw_rect(Rect2(Vector2(self.transform.origin.x, self.transform.origin.y - font.get_height()), Vector2(size.x + 2, font.get_height() + 2)), Color(0,0,0,0.7), true)
	draw_string(font, self.transform.origin, bubble_text, color)
	label.free()
	
func show_text(text, style = 0):
	text_style = style
	bubble_text = text
	update()