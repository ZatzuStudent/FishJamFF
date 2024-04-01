extends Camera2D

@onready var player = $"../Player"

func _ready():
	Engine.physics_ticks_per_second = DisplayServer.screen_get_refresh_rate()

func _process(_delta):
	global_position.x = clamp(player.global_position.x, -581, 581)
	global_position.y = clamp(player.global_position.y, -162, 162)

