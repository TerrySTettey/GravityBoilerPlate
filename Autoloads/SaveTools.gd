extends Node


# SaveTools Autoload Script
# Game Data Saving solution
# Saves two types of  data:
#	Config Save Data -> Game Wide data like setting presets, chosen resolution, etc.
#	Game Save Data - > Data related to actual gameplay elements specific to a particular game file ( File 1 / File 2 / File 3 style)

# use "user://" for deployment directory and "res://" for development directory
const PATH = "res://data/" 

# use ".tres" for readable data and ".res" for encrypted data

var fileExt = ".tres"

var game_data: GameSaveData
var config_data: ConfigSaveData

func _ready() -> void:
	# Config Save Data loads on game startup
	load_config()

func save_game(fileNum: int):
	#Saves the specified game's files.
	print(ResourceSaver.save(game_data, PATH + "saveFile_" + str(fileNum) + fileExt))
	

func load_game(fileNum: int):
	#Loads the specified game's files.
	if ResourceLoader.exists(PATH + "saveFile_" + str(fileNum) + fileExt):
		game_data = ResourceLoader.load(PATH + "saveFile_" + str(fileNum) + fileExt)
	else:
		game_data = null

func delete_game(fileNum: int):
	#Deletes the specified game's save file.
	if ResourceLoader.exists(PATH + "saveFile_" + str(fileNum) + fileExt):
		DirAccess.remove_absolute(PATH + "saveFile_" + str(fileNum) + fileExt)
		game_data = GameSaveData.new()

func save_config():
	#Saves the game's config.
	ResourceSaver.save(config_data, PATH + "configFile" + fileExt)

func load_config():
	#Loads the game's config
	if ResourceLoader.exists(PATH + "configFile" + fileExt):
		config_data = ResourceLoader.load(PATH + "configFile" + fileExt)
	else:
		config_data = ConfigSaveData.new()
	
func checkGameFilesExist():
	#Checks if saveFiles exist and provides the Load Game Button if it does
	for i in range(1,4):
		if ResourceLoader.exists(PATH + "saveFile_" + str(i) + fileExt):
			config_data.game_save_exists = true
			break
		else:
			config_data.game_save_exists = false
	save_config()
	
