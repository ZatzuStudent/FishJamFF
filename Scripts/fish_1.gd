extends CharacterBody2D

var speed = 30
var mouse_pos
var ismoving = false
var direction = Vector2.ZERO

func _ready():
	direction = Vector2(randf_range(-1,1), randf_range(-.3,.3))

func _physics_process(delta):
	for_mouse_movement()

func for_mouse_movement():
	velocity = speed * direction
	move_and_slide()

func _on_timer_timeout():
	while true:
		direction.x = randi_range(-1,1)
		if direction.x != 0:
			break
