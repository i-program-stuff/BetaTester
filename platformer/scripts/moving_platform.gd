extends AnimatableBody2D

@export var direction: Vector2 = Vector2(1, 0)

func _ready() -> void:
	MemoryValues.platform_direction = direction

func _physics_process(_delta: float) -> void:
	if MemoryValues.platform_direction == Vector2.UP:
		constant_linear_velocity = Vector2(0, -100.0)
	else:
		constant_linear_velocity = Vector2.ZERO
	
	move_and_collide(
		MemoryValues.platform_speed * MemoryValues.platform_direction
	)

func turn_around(body: Node2D) -> void:
	if body.is_in_group("MovingPlatform"):
		MemoryValues.platform_direction *= -1
