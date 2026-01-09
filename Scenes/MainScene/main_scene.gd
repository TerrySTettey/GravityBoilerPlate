class_name MainScene
extends Node

func _ready() -> void:
	Globals.main_scene = self
	SignalBus.emit_signal("main_scene_loaded")
