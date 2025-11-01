extends Node

@onready var main: Main = get_tree().root.get_node_or_null("Main")

const GAME_SAVE_LOCATION = "user://MemoryGameHighscores.json"
const SAVE_LOCATION = "user://"
const FILE_EXTENSION = ".json"
const TOTAL_TIME: int = 10

signal highscores_changed

var grid_size: int  = 2

var score: int = 0

var colors: Array[Color] = [
	Color(0.0, 0.0, 1.0, 1.0),
	Color(1.0, 0.0, 0.0, 1.0),
	Color(0.0, 1.0, 0.0, 1.0),
	Color(1.0, 1.0, 0.0, 1.0)
]

var easy_highscore: int
var normal_highscore: int
var hard_highscore: int

var hidden_color: Color = Color(0.292, 0.292, 0.292, 1.0)

var selected_color: Color = Color(1.0, 1.0, 1.0, 1.0)

func _ready() -> void:
	highscores_changed.connect(save_highscores)
	if not has_saved_game():
		save_highscores()

func get_random_color() -> Color:
	var index = randi_range(0, colors.size() - 1)
	return colors[index]

func reset_score():
	score = 0

func grid_size_to_difficulty() -> String:
	match(grid_size):
		2: return "Easy (2x2)"
		4: return "Normal (4x4)"
		5: return "Hard (5x5)"
	return "Error"
	
func get_highscore_for_difficulty() -> int:
	match(grid_size):
		2: return easy_highscore
		4: return normal_highscore
		5: return hard_highscore
	return -1
	
func has_saved_game() -> bool:
	return FileAccess.file_exists(GAME_SAVE_LOCATION)
	
func submit_new_score():
	var highscore_changed: bool = false
	match(grid_size):
		2:
			if score > easy_highscore:
				easy_highscore = score
				highscore_changed = true
		4:
			if score > normal_highscore:
				normal_highscore = score
				highscore_changed = true
		5:
			if score > hard_highscore:
				hard_highscore = score
				highscore_changed = true
	if highscore_changed:
		highscores_changed.emit()

func save_highscores():
	var highscores: Dictionary = {
		"easy": easy_highscore,
		"normal": normal_highscore,
		"hard": hard_highscore
	}
	
	var file = FileAccess.open(GAME_SAVE_LOCATION, FileAccess.WRITE)	
	var json = JSON.stringify(highscores)
	
	file.store_string(json)
	file.close()

func load_highscores():
	if has_saved_game():
		var file = FileAccess.open(GAME_SAVE_LOCATION, FileAccess.READ)
		var data = JSON.parse_string(file.get_as_text())
		file.close()
		
		await get_tree().process_frame # Wait for main scene to finish loading
		easy_highscore = data.easy
		normal_highscore = data.normal
		hard_highscore = data.hard
		highscores_changed.emit()
