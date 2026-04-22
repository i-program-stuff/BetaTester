extends Node

enum {
	NONE,
	OF_PLAYER_SPEED,
	OF_PLAYER_SCALE, 
	OF_JUMP_VELOCITY, 
	OF_GRAVITY, 
	OF_PLATFORM_SPEED,
	OF_CIRCLE_POSITIONS_X,
	OF_CIRCLE_POSITIONS_Y,
}

var redraw_values = false;

var player_speed: float
var player_scale: float
var jump_velocity: float

var gravity: float

var platform_direction: Vector2
var platform_speed: float

var circles_position_x_delta: int
var circles_position_y_delta: int

func _ready() -> void:
	reset()

func reset():
	redraw_values = true
	
	player_speed = 280.0
	player_scale = 1.0
	jump_velocity = -365.0
	
	gravity = 1000.0
	
	platform_direction = Vector2.RIGHT
	platform_speed = 1.0
	
	circles_position_x_delta = 0
	circles_position_y_delta = 0
	
	
