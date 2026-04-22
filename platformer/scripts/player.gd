extends CharacterBody2D

@onready var sprite = $AnimatedSprite2D

var coyote_time := 0.15 # Time you can still jump after leaving ground
var coyote_timer := 0.0

var jump_buffer_time := 0.15 # Time jump input is remembered
var jump_buffer_timer := 0.0

func _physics_process(delta):
	scale = MemoryValues.player_scale * Vector2.ONE
	up_direction.y = -sign(MemoryValues.gravity)

	if is_on_floor():
		coyote_timer = coyote_time
	else:
		coyote_timer -= delta

	if Input.is_action_just_pressed("jump"):
		jump_buffer_timer = jump_buffer_time
	else:
		jump_buffer_timer -= delta

	if jump_buffer_timer > 0.0 and coyote_timer > 0.0:
		$JumpSound.play()
		velocity.y = MemoryValues.jump_velocity
		coyote_timer = 0.0
		jump_buffer_timer = 0.0

	var direction = Input.get_axis("move_left", "move_right")
	if direction != 0:
		velocity.x = direction * MemoryValues.player_speed
		sprite.flip_h = direction < 0
		sprite.play("run")
	else:
		velocity.x = move_toward(velocity.x, 0, MemoryValues.player_speed)
		sprite.play("idle")

	if not is_on_floor():
		velocity.y += MemoryValues.gravity * delta
		if velocity.y > 0: # falling
			sprite.play("jump")

	move_and_slide()
