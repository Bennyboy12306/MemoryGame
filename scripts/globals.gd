extends Node

const TOTAL_TIME: int = 10

var grid_size: int  = 2

var score: int

var colors: Array[Color] = [
	Color(0.0, 0.0, 1.0, 1.0),
	Color(1.0, 0.0, 0.0, 1.0),
	Color(0.0, 1.0, 0.0, 1.0),
	Color(1.0, 1.0, 0.0, 1.0)
]

var hidden_color: Color = Color(0.292, 0.292, 0.292, 1.0)

var selected_color: Color = Color(1.0, 1.0, 1.0, 1.0)

func get_random_color() -> Color:
	var index = randi_range(0, colors.size() - 1)
	return colors[index]
