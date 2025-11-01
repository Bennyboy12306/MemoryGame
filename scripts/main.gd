class_name Main
extends Control

const GAME: PackedScene = preload("uid://cqmjpvha7c8jm")
const GAME_OVER: PackedScene = preload("uid://tcfs6aua32gq")
const MENU = preload("uid://dlweacpjjaxo3")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	instantiate_menu_scene()
	
func instantiate_game_scene():
	var game_scene_instance = GAME.instantiate() as Game
	add_child(game_scene_instance)
	game_scene_instance.game_over.connect(instantiate_game_over_scene)

func instantiate_game_over_scene(correct_color: Color):
	var game_over_scene_instance = GAME_OVER.instantiate() as GameOver
	add_child(game_over_scene_instance)
	game_over_scene_instance.init(correct_color)
	game_over_scene_instance.restart.connect(instantiate_game_scene)
	game_over_scene_instance.goto_menu.connect(instantiate_menu_scene)
	
func instantiate_menu_scene():
	var menu_scene_instance = MENU.instantiate() as Menu
	add_child(menu_scene_instance)
	menu_scene_instance.play.connect(instantiate_game_scene)
	Globals.load_highscores()
