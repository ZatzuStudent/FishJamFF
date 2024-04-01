extends CharacterBody2D
class_name Player

var speed = 50
var ismoving = false
var direction = Vector2.ZERO

func _physics_process(delta):
	for_mouse_movement()

func for_mouse_movement():
	var new_velocity
	if direction.length() > 5:
		new_velocity = speed * direction
	else:
		new_velocity = velocity/1.03
	var max_vel_x = 500
	var max_vel_y = 300
	velocity = new_velocity.clamp( Vector2(-max_vel_x, -max_vel_y), Vector2(max_vel_x, max_vel_y))

	move_and_slide()


func _input(event):
	if event is InputEventMouseMotion:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		direction = event.relative
		print(event.relative)
