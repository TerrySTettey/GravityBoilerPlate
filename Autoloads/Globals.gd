extends Node

# Globals Autoload Script
# Absolute Top Level Singleton - Pretty much in charge of everything

@onready var main_scene : MainScene

func _ready() -> void:
	SignalBus.main_scene_loaded.connect(_on_load_main_scene)
	pass # Replace with function body.

func _on_load_main_scene() -> void :
	# Called when the Main Scene has succesfully finish loading.
	pass
