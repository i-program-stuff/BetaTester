extends HBoxContainer

@export var address := "ABCD"

var action_type = MemoryValues.NONE;

var scroll_accumulated = 0.0
var scroll_time = 0.0
var scroll_direction = 0
var acceleration_factor = 1.0

func _input(event: InputEvent) -> void:
	# Handle mouse wheel events
	if event is InputEventMouseButton:
		if event.button_index in [MOUSE_BUTTON_WHEEL_UP, MOUSE_BUTTON_WHEEL_DOWN]:
			# Only process if the SpinBox is focused or mouse is over it
			var spin_box = $Value
			if spin_box.has_focus() or spin_box.get_global_rect().has_point(get_global_mouse_position()):
				# Determine scroll direction
				var direction = 1 if event.button_index == MOUSE_BUTTON_WHEEL_UP else -1
				var current_time = Time.get_ticks_msec()
				
				# Calculate time since last scroll event
				var time_diff = current_time - scroll_time
				
				# If scrolling in the same direction within a short time, increase acceleration
				if time_diff < 250 and direction == scroll_direction:
					scroll_accumulated += 1.0
					# Increase acceleration factor exponentially (with a cap)
					acceleration_factor = min(acceleration_factor * 1.2, 20.0)
				else:
					# Reset if direction changed or too much time passed
					scroll_accumulated = 1.0
					acceleration_factor = 1.0
				
				# Calculate value change based on scroll speed and acceleration
				var base_change = spin_box.step * direction
				var accelerated_change = base_change * acceleration_factor
				
				# Apply the change
				spin_box.value += accelerated_change
				
				# Update scroll tracking variables
				scroll_time = current_time
				scroll_direction = direction
				
				get_viewport().set_input_as_handled()

func _ready() -> void:
	$Label.text = " 0x" + address + ":"
	
	match action_type:
		MemoryValues.OF_PLAYER_SPEED:
			$Value.value = MemoryValues.player_speed + randi_range(-9, 9)
		
		MemoryValues.OF_PLAYER_SCALE:
			$Value.value = MemoryValues.player_scale
			$Value.step = 0.1
		
		MemoryValues.OF_JUMP_VELOCITY:
			$Value.value = MemoryValues.jump_velocity + randi_range(-9, 9)
		
		MemoryValues.OF_GRAVITY:
			$Value.value = MemoryValues.gravity + randi_range(-9, 9)
		
		MemoryValues.OF_PLATFORM_SPEED:
			$Value.value = MemoryValues.platform_speed
		
		MemoryValues.NONE:
			$Value.value = randi_range(-500, 500)

func _on_value_value_changed(value: float) -> void:
	match action_type:
		MemoryValues.OF_PLAYER_SPEED:
			MemoryValues.player_speed = $Value.value
		
		MemoryValues.OF_PLAYER_SCALE:
			MemoryValues.player_scale = $Value.value
		
		MemoryValues.OF_JUMP_VELOCITY:
			MemoryValues.jump_velocity = $Value.value
		
		MemoryValues.OF_GRAVITY:
			MemoryValues.gravity = $Value.value
		
		MemoryValues.OF_PLATFORM_SPEED:
			MemoryValues.platform_speed = abs($Value.value)
			
			if sign($Value.value) == 1:
				MemoryValues.platform_direction = Vector2.RIGHT
			elif sign($Value.value) == -1:
				MemoryValues.platform_direction = Vector2.DOWN
				
		MemoryValues.OF_CIRCLE_POSITIONS_X:
			MemoryValues.circles_position_x_delta = $Value.value
		
		MemoryValues.OF_CIRCLE_POSITIONS_Y:
			MemoryValues.circles_position_y_delta = $Value.value
