extends Node

# Managers Autoload Script
# Singleton responsible for managing "managers"
# Managers are essentially sub-singleton scripts which are responsible for handling various gameplay logic.
# Any gameplay element that requires use of a singleton-like behaviour is essentially implemented as a manager.

func load_manager(managerName:String, another:bool = false) -> Node:
	if another == false:
		if get_node(managerName) != null:
			return null
		else:
			var manager = load("res://Managers/%s.gd" % managerName).new() 
			manager.name = managerName
			add_child(manager)
			return manager
	else:
			var manager = load("res://Managers/%s.gd" % managerName).new() 
			manager.name = managerName
			add_child(manager)
			return manager

func get_manager(managerName: String) -> Node:
	for child in get_children():
		if child.name == managerName:
			return child
	
	return null

func unload_manager(managerName: String) -> void:
	get_node(managerName).queue_free()
	pass

func reset_manager(managerName:String) -> void:
	unload_manager(managerName)
	load_manager(managerName)
	pass
