extends Window

@onready var viewport: SubViewport = $SubViewportContainer/SubViewport

# Add content to viewport (example: a sprite)
func _ready() -> void:
	close_requested.connect(func(): queue_free())
