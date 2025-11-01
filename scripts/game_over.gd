class_name GameOver
extends Control

@onready var color_rect: ColorRect = $VBoxContainer/ColorRect
@onready var score_label: Label = $VBoxContainer/ScoreLabel
@onready var highest_score_label: Label = $VBoxContainer/HighestScoreLabel

signal restart 
signal goto_menu

func init(correct_color: Color):
	Globals.submit_new_score()
	color_rect.color = correct_color
	score_label.text = "Score: " + str(Globals.score)
	var difficulty = Globals.grid_size_to_difficulty()
	highest_score_label.text = "Highscore: " + str(Globals.get_highscore_for_difficulty()) + " - Difficulty:" + str(difficulty)

func _on_restart_button_pressed() -> void:
	Globals.reset_score()
	restart.emit()
	queue_free()

func _on_menu_button_pressed() -> void:
	Globals.reset_score()
	goto_menu.emit()
	queue_free()
