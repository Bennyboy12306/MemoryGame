class_name Menu
extends Control
@onready var home: Control = $Home
@onready var difficulty_select: VBoxContainer = $DifficultySelect
@onready var easy_label: Label = $DifficultySelect/EasyLabel
@onready var normal_label: Label = $DifficultySelect/NormalLabel
@onready var hard_label: Label = $DifficultySelect/HardLabel

signal play

func _ready() -> void:
	Globals.highscores_changed.connect(_load_highscores)

func _on_play_button_pressed() -> void:
	home.hide()
	difficulty_select.show()
	
func _on_back_button_pressed() -> void:
	difficulty_select.hide()
	home.show()

func _on_quit_button_pressed() -> void:
	get_tree().quit()

func _on_easy_button_pressed() -> void:
	Globals.grid_size = 2
	start()

func _on_normal_button_pressed() -> void:
	Globals.grid_size = 4
	start()

func _on_hard_button_pressed() -> void:
	Globals.grid_size = 5
	start()

func start():
	play.emit()
	queue_free()

func _load_highscores():
	easy_label.text = "Highscore: " + str(Globals.easy_highscore)
	normal_label.text = "Highscore: " + str(Globals.normal_highscore)
	hard_label.text = "Highscore: " + str(Globals.hard_highscore)
