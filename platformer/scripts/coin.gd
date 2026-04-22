extends Area2D

@export var index: int = 0
@export var is_secret: bool = false

func _ready() -> void:
	# if this coin is collected, don't create it again
	if SaveData.collected_coins & (1 << index):
		queue_free()

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		$AudioStreamPlayer.play()
		visible = false
		
func _on_audio_stream_player_finished() -> void:
	SaveData.collected_coins |= 1 << index
	queue_free()
