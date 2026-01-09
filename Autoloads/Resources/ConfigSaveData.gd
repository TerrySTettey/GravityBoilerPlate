class_name ConfigSaveData
extends SaveData

#Current settings features
# - last_loaded_save - Tracks which save game file to load when the continue button is pressed.
# - first_launch -  Tracks whether this is the first launch of the game (in case I want to make a first launch cutscene or something)
# - (more to be added)

@export var game_save_exists : bool = false
@export var first_launch: bool = true
