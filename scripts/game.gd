class_name Game
extends Control

@onready var grid_container: GridContainer = $GridContainer
@onready var timer: Timer = $Timer
@onready var score_label: Label = $ScoreLabel
@onready var timer_label: Label = $TimerLabel
@onready var buttons: HBoxContainer = $Buttons

signal game_over

const TILE: PackedScene = preload("uid://dtksnmutgp7j0")

var time_remaining: int

var selected_tile: Tile

func _ready() -> void:
	score_label.text = "Score: " + str(Globals.score)
	time_remaining = Globals.TOTAL_TIME
	grid_container.columns = Globals.grid_size
	
	var num_tiles = Globals.grid_size ** 2
	
	for i in num_tiles:
		var tile_instance = TILE.instantiate()
		grid_container.add_child(tile_instance)
		tile_instance.init()
		
	var selected_tile_index: int
		
	selected_tile_index = randi_range(0, num_tiles - 1)
	selected_tile = grid_container.get_child(selected_tile_index) as Tile


func _on_timer_timeout() -> void:
	time_remaining -= 1
	timer_label.text = str(time_remaining)
	check_remaining_time()

func check_remaining_time():
	if time_remaining == 0:
		timer.stop()
		for child in grid_container.get_children() as Array[Tile]:
			child.show_hidden_color()
		selected_tile.show_selected_color()
		timer_label.text = "What color was the tile?"
		buttons.show()

func _on_blue_button_pressed() -> void:
	var color: Color = Globals.colors[0] # Blue
	choose_color(color)

func _on_red_button_pressed() -> void:
	var color: Color = Globals.colors[1] # Red
	choose_color(color)

func _on_green_button_pressed() -> void:
	var color: Color = Globals.colors[2] # Green
	choose_color(color)

func _on_yellow_button_pressed() -> void:
	var color: Color = Globals.colors[3] # Yellow
	choose_color(color)

func choose_color(color: Color):
	if color == selected_tile.stored_color:
		Globals.score += 1
		get_tree().reload_current_scene()
	else:
		buttons.hide()
		game_over.emit(selected_tile.stored_color)
		queue_free()
