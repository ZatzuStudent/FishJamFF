extends CharacterBody2D

var direction 
@onready var fish_sprite = $AnimatedSprite2D
@export var properties : Fishies
var player = Player.new()

func _ready():
	direction = Vector2(randf_range(-properties.max_dir_x,properties.max_dir_y),randf_range(-properties.max_dir_x,properties.max_dir_y))

func _process(delta):
	move_and_slide()
	flipit()
	
	inhale(delta)
	if gettingHaled:
		rev_flipit()
	else:
		flipit()
		toMove()

@onready var view_comp = $View_comp/CollisionShape2D
func flipit():
	if velocity.x > 0:
		fish_sprite.flip_h = false
		view_comp.position.x = 44
	else:
		fish_sprite.flip_h = true
		view_comp.position.x = -44
		
func rev_flipit():
	if velocity.x < 0:
		fish_sprite.flip_h = false
		view_comp.position.x = 44
	else:
		fish_sprite.flip_h = true
		view_comp.position.x = -44

func toMove():
	var new_dir = direction
	velocity = properties.speed * direction
	if !nearPlayer:
		direction = new_dir.clamp( Vector2(-properties.max_dir_x, -properties.max_dir_y), Vector2(properties.max_dir_x, properties.max_dir_y))
	
func _on_timer_timeout():
	direction = Vector2(randf_range(-20,20),randf_range(-3,3))
var nearPlayer = false

func _on_eaten_comp_body_entered(body):
	if body is Player:
		body.ate()
		queue_free()

		
func _on_view_comp_body_entered(body):
	if body is Player:
		nearPlayer = true
		direction = (-((body.global_position - global_position).normalized()))*20

var gettingHaled = false
var inHaleArea = false

func inhale(_delta):
	if Input.is_action_pressed("inhale"):
		if inHaleArea:
			gettingHaled = true
			var dir = $"../../Player".global_position - global_position
			velocity = 500 * dir.normalized()
			await get_tree().create_timer(1.0).timeout
			inHaleArea = false
			gettingHaled = false

func _on_eaten_comp_area_entered(area):
	if area.is_in_group("Inhale"):
		inHaleArea = true

func _on_eaten_comp_area_exited(area):
	if area.is_in_group("Inhale"):
		inHaleArea = false
