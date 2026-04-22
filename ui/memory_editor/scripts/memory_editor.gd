extends Window

var ADDRESS_CELL_SCENE := "res://ui/memory_editor/address_cell.tscn"

func is_game_not_running():
	return !get_tree().get_first_node_in_group("GameWindow")

func add_new_address_cell(cell_name, action):
	var address_cell = load(ADDRESS_CELL_SCENE).instantiate()
	address_cell.address = cell_name
	address_cell.action_type = action
	address_cell._ready()
	%Addresses.add_child(address_cell)

func clear_address_cells():
	for child in %Addresses.get_children():
		child.queue_free()

func draw_level1_values() -> void:
	add_new_address_cell("4F2A9C", MemoryValues.OF_PLAYER_SCALE)
	add_new_address_cell("C5D042", MemoryValues.OF_JUMP_VELOCITY)
	add_new_address_cell("8E01F3", MemoryValues.OF_PLAYER_SPEED)
	add_new_address_cell("29BC55", MemoryValues.NONE)

func draw_level2_values() -> void:
	add_new_address_cell("FF23AB", MemoryValues.OF_PLATFORM_SPEED)
	add_new_address_cell("7B91E0", MemoryValues.OF_PLAYER_SPEED)
	add_new_address_cell("6CE8F9", MemoryValues.OF_GRAVITY)
	add_new_address_cell("D24C7A", MemoryValues.OF_JUMP_VELOCITY)
	add_new_address_cell("5720B4", MemoryValues.NONE)

func draw_level3_values() -> void:
	add_new_address_cell("9A31F0", MemoryValues.OF_PLAYER_SPEED)
	add_new_address_cell("1448CC", MemoryValues.OF_GRAVITY)
	add_new_address_cell("EE5276", MemoryValues.OF_JUMP_VELOCITY)
	add_new_address_cell("B83E9D", MemoryValues.OF_PLAYER_SCALE)

func draw_level4_values() -> void:
	add_new_address_cell("2C1E88", MemoryValues.OF_PLAYER_SCALE)
	add_new_address_cell("6A93E2", MemoryValues.OF_GRAVITY)
	add_new_address_cell("0E42B8", MemoryValues.OF_CIRCLE_POSITIONS_Y)
	add_new_address_cell("0E42B9", MemoryValues.OF_CIRCLE_POSITIONS_X)
	add_new_address_cell("D8C5AF", MemoryValues.OF_PLAYER_SPEED)
	add_new_address_cell("0E42B9", MemoryValues.OF_JUMP_VELOCITY)

func draw_level5_values() -> void:
	add_new_address_cell("A7F12C", MemoryValues.OF_JUMP_VELOCITY)
	add_new_address_cell("58B4E0", MemoryValues.OF_PLAYER_SPEED)
	add_new_address_cell("33C9AD", MemoryValues.OF_GRAVITY)
	add_new_address_cell("E4D072", MemoryValues.OF_PLATFORM_SPEED)
	add_new_address_cell("19FA63", MemoryValues.OF_PLAYER_SCALE)

func draw_level_values() -> void:
	MemoryValues.redraw_values = false
	clear_address_cells()
	
	match SaveData.current_level:
		1: draw_level1_values()
		2: draw_level2_values()
		3: draw_level3_values()
		4: draw_level4_values()
		5: draw_level5_values()
	

func _input(event: InputEvent) -> void:
	$SubViewportContainer/SubViewport.push_input(event)

func _ready() -> void:
	close_requested.connect(func(): queue_free())
	
func _process(_delta: float) -> void:
	if is_game_not_running():
		%Title.text = "The Game is not running..."
		clear_address_cells()
		return
	
	%Title.text = "Found Memory Adresses:"
	
	if MemoryValues.redraw_values:
		draw_level_values()
	
