extends Node2D

var LEVEL_PATH := "res://platformer/levels/level%d.tscn"

var TOP_VOID := -10
var BOTTOM_VOID := 85

var LEVEL_START_X := 1
var LEVEL_END_X := 150

func load_level(level_index: int, spawn_at_flag := false) -> void:
	MemoryValues.reset()
	var new_level: Node2D = load(LEVEL_PATH % level_index).instantiate()
	
	var current_level = $Level.get_children()[0]
	current_level.queue_free()
	
	$Level.add_child(new_level)
	
	if not spawn_at_flag:
		return
		
	var flag: Node2D = new_level.find_child("Flag")
	var player: Node2D = new_level.find_child("Player")
	
	if not flag or not player:
		return

	player.position = flag.position

func _ready() -> void:
	load_level(SaveData.current_level)

func _process(_delta: float) -> void:
	var player: CharacterBody2D = get_tree().get_first_node_in_group("Player")
	
	var amount_of_coins = SaveData.count_bitfield(SaveData.collected_coins)
	$CoinsLabel.text = str(amount_of_coins) + "/10" 
	
	if player.position.y < TOP_VOID or player.position.y > BOTTOM_VOID:
		load_level(SaveData.current_level)
		$HurtSoundEffect.play()
	
	if player.position.x < LEVEL_START_X:
		if SaveData.current_level <= 1:
			player.position.x = LEVEL_START_X
		else:
			SaveData.current_level -= 1
			load_level(SaveData.current_level, true)
			
	elif player.position.x > LEVEL_END_X:
		if SaveData.current_level >= 5:
			player.position.x = LEVEL_END_X
		else:
			SaveData.current_level += 1
			load_level(SaveData.current_level)
		
		
	
