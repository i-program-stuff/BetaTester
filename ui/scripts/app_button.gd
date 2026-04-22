extends Button

@export var app_title := "Game"
@export var WINDOW = preload("res://ui/game_window.tscn")

func _pressed():
	var desktop := get_tree().get_first_node_in_group("Desktop")
	
	# Check if a window with the same title already exists
	for child in desktop.get_children():
		if child.has_method("get_title") and child.get_title() == app_title:
			child.grab_focus()
			return
	
	var win := WINDOW.instantiate()
	win.title = app_title
	win.position = Vector2i(200, 100)
	desktop.add_child(win)
