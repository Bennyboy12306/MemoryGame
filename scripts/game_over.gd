class_name GameOver
extends Control

@onready var color_rect: ColorRect = $VBoxContainer/ColorRect

signal restart 
signal goto_menu

func init(correct_color: Color):
	color_rect.color = correct_color

func _on_restart_button_pressed() -> void:
	Globals.score = 0
	restart.emit()
	queue_free()

func _on_menu_button_pressed() -> void:
	Globals.score = 0
	goto_menu.emit()
	queue_free()
