extends KinematicBody2D

const FLOOR_NORMAL: = Vector2.UP

export var speed: = Vector2(150.0, 400.0)
export var gravity: = 600.0
export var rebound: = Vector2(50.0, 50.0)
export var friction: = 0.95

export var max_speed_x = 300

var velocity: = Vector2.ZERO
var last_direction: = Vector2.ZERO
var super_jump: = false
var water_mode: = false

var score = 0

onready var score_label = get_node("score")

func get_direction() -> Vector2:
	var direction = Vector2(
		Input.get_action_strength("right") * 2 - Input.get_action_strength("left") * 2,
		1.0
	)
	
	if Input.get_action_strength("jump") > 0.2:
		if !water_mode:
			if is_on_floor():
				direction.y = -1.0
			elif is_on_wall():
				direction.y = rebound.y
				direction.x = -rebound.x if last_direction.x > 0 else rebound.x
		else:
			direction.y = -1.0
	
	if super_jump:
		super_jump = false
		direction.y = -1.9
	
	return direction

func calculate_move_velocity(linear_vector: Vector2, direction: Vector2) -> Vector2:
	var delta = get_physics_process_delta_time()
	
	var out = linear_vector
	
	if direction.x == 0:
		out.x *= friction
	else:
		out.x += speed.x * direction.x * delta
	
	out.y += gravity * delta
	
	if direction.y <= -0.5:
		out.y = speed.y * direction.y
	
	# Clamp max speeds
	out.x = clamp(out.x, -max_speed_x, max_speed_x)
	
	return out


func reset_velocity():
	velocity = Vector2.ZERO

func boost_jump():
	super_jump = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta: float) -> void:
	var direction = get_direction()
	
	if direction.x != 0:
		last_direction.x = direction.x
	if direction.y != 0:
		last_direction.y = direction.y
	
	velocity = calculate_move_velocity(velocity, direction)
	velocity = move_and_slide(velocity, FLOOR_NORMAL)

func increse_score():
	score += 1
	score_label.text = String(score)
