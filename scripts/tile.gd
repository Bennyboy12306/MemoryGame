class_name Tile
extends ColorRect

var stored_color: Color

func init() -> void:
	stored_color = Globals.get_random_color()
	color = stored_color

func show_hidden_color():
	color = Globals.hidden_color
	
func show_selected_color():
	color = Globals.selected_color
