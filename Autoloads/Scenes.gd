extends Node

# Scenes Autoload Script
# Singleton responsible for loading and unloading scenes (with/without appropriate Managers)


@export var main_scene: MainScene

var current_world_scenes : Array[Dictionary]
var current_UI_scenes : Array[Dictionary]

func load_scene(sceneName: String, sceneType: Utils.SCENE_TYPE, isDuplicate: bool = false) -> void:
	# Loads scene
	match(sceneType):
		Utils.SCENE_TYPE.WORLD:
			if !isDuplicate:
				var check: bool = false
				for i in current_world_scenes:
					if i.keys()[0] == sceneName:
						check = true

				if !check:
					var sceneResource = load("res://Scenes/%s.tscn" % sceneName)
					
					if sceneResource:
						var sceneObject = sceneResource.instantiate()
						current_world_scenes.append({sceneName: sceneObject})
						main_scene.get_node('%World').add_child(sceneObject)
						managerBind(sceneName, sceneType)
					else:
						return
				else:
					return
			else:
				var sceneResource = load("res://Scenes/%s.tscn" % sceneName)
					
				if sceneResource:
					var sceneObject = sceneResource.instantiate()
					current_world_scenes.append({sceneName: sceneObject})
					main_scene.get_node('%World').add_child(sceneObject)
					managerBind(sceneName, sceneType)
			pass
		Utils.SCENE_TYPE.UI:
			if !isDuplicate:
				var check: bool = false
				for i in current_UI_scenes:
					if i.keys()[0] == sceneName:
						check = true

				if !check:
					var sceneResource = load("res://Scenes/UI/%s.tscn" % sceneName)
					
					if sceneResource:
						var sceneObject = sceneResource.instantiate()
						current_UI_scenes.append({sceneName: sceneObject})
						main_scene.get_node('%GUI').add_child(sceneObject)
						managerBind(sceneName, sceneType)
					else:
						return
				else:
					return
			else:
				var sceneResource = load("res://Scenes/UI/%s.tscn" % sceneName)
					
				if sceneResource:
					var sceneObject = sceneResource.instantiate()
					current_UI_scenes.append({sceneName: sceneObject})
					main_scene.get_node('%GUI').add_child(sceneObject)
					managerBind(sceneName, sceneType)
			pass
	pass

func unload_scene(sceneName: String, sceneType: Utils.SCENE_TYPE) -> void:
	# Unloads scene
	match(sceneType):
		Utils.SCENE_TYPE.WORLD:
			var check: bool = false
			var stopNum: int = 0

			for i in range(current_world_scenes.size()):
				if current_world_scenes[i].keys()[0] == sceneName:
					stopNum = i
					check = true
					break

			if check:
				var sceneObject = current_world_scenes.pop_at(stopNum)[sceneName]
				sceneObject.queue_free()
			pass

		Utils.SCENE_TYPE.UI:
			var check: bool = false
			var stopNum: int = 0

			for i in range(current_UI_scenes.size()):
				if current_UI_scenes[i].keys()[0] == sceneName:
					stopNum = i
					check = true
					break

			if check:
				var sceneObject = current_UI_scenes.pop_at(stopNum)[sceneName]
				sceneObject.queue_free()
			pass
	pass

func scene_to_front(sceneName: String, sceneType: Utils.SCENE_TYPE) -> void:
	# Bring Scene to the Front
	match(sceneType):
		Utils.SCENE_TYPE.WORLD:
			var check: bool = false
			var stopNum: int = 0

			for i in range(current_world_scenes.size()):
				if current_world_scenes[i].keys()[0] == sceneName:
					stopNum = i
					check = true
					break

			if check:
				var sceneDict = current_world_scenes.pop_at(stopNum)
				main_scene.get_node('%World').move_child(sceneDict[sceneName],0)
				current_world_scenes.push_front(sceneDict)
			pass
		Utils.SM_SCENE_TYPE.UI:
			var check: bool = false
			var stopNum: int = 0

			for i in range(current_UI_scenes.size()):
				if current_UI_scenes[i].keys()[0] == sceneName:
					stopNum = i
					check = true
					break
					
			if check:
				var sceneDict = current_UI_scenes.pop_at(stopNum)
				main_scene.get_node('%GUI').move_child(sceneDict[sceneName],0)
				current_UI_scenes.push_front(sceneDict)
			pass
	pass

func get_scene(sceneName: String, sceneType: Utils.SCENE_TYPE) -> Node:
	# Attempt to retrieve scene, returns null if scene is not currently loaded
	match(sceneType):
		Utils.SM_SCENE_TYPE.WORLD:
			for sceneDic in current_world_scenes:
				if sceneDic.keys()[0] == sceneName:
					return sceneDic[sceneName]
			pass
		Utils.SM_SCENE_TYPE.UI:
			for sceneDic in current_UI_scenes:
				if sceneDic.keys()[0] == sceneName:
					return sceneDic[sceneName]
			pass
	return null

func managerBind(sceneName: String, sceneType: Utils.SCENE_TYPE) -> void:
	# Edit the match statement cases as necessary to load up particular managers when the scene loads up
	match(sceneType):
		Utils.SCENE_TYPE.WORLD:
			match(sceneName):
				"MainScene/MainScene":
					#Load / Unload Managers here
					pass
				_:
					#Default case
					pass
			pass
		Utils.SCENE_TYPE.UI:
			pass
