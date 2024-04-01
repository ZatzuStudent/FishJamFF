extends CharacterBody2D
class_name Player
@export var properties : Fishies

var direction = Vector2.ZERO
@onready var inhale_area = $Inhale_Area2D/CollisionShape2D
@onready var fish_sprite = $Sprite2D
@onready var feed_bar = $UI_Fish/feedBar
@onready var inhale_bar = $UI_Fish/InhaleBar
var ismoving = false
var inGame = false
var inDash = false
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	await get_tree().create_timer(.5).timeout
	inGame = true

func _physics_process(_delta):
	if !inGame:
		return
	dash()
	for_mouse_movement()
	flipit()
	inhaled()

func flipit():
	if velocity.x > 0:
		fish_sprite.flip_h = false
		inhale_area.position.x = 186
	else:
		fish_sprite.flip_h = true
		inhale_area.position.x = -186


func dash():
	var new_vel
	var max_vel = 1000
	if Input.is_action_just_pressed("dash") && !inDash:
		inDash = true
		new_vel = velocity * 7000
		velocity = new_vel.clamp( Vector2(-max_vel, -max_vel/1.5), Vector2(max_vel, max_vel/1.5))
		await get_tree().create_timer(.2).timeout
		velocity = velocity/2
		inDash = false

func for_mouse_movement():
	var new_dir = Vector2.ZERO
	if !inDash:
		if direction.length() > 5:
			velocity = properties.speed * direction
		else:
			velocity = velocity/1.01
	direction = new_dir.clamp( Vector2(-properties.max_dir_x, -properties.max_dir_y), Vector2(properties.max_dir_x, properties.max_dir_y))
	move_and_slide()

func _input(event):
	if event is InputEventMouseMotion:
		direction = event.relative
		
func tester():
	print('test')

func ate():
	feed_bar.value += 8

func _on_feed_bar_value_changed(value):
	if value > 60:
		scale = Vector2(3, 3)
		return
	elif value > 30:
		scale = Vector2(1.5, 1.5)

func inhaled():
	if Input.is_action_pressed("inhale"):
		inhale_bar.value -= 1
