class_name Player
extends CharacterBody2D

# Movement constants
const JUMP_VELOCITY = -500.0
const GRAVITY = 981.0

# Movement speeds
@export var normal_speed: int = 250
@export var crouching_speed: int = 150
@export var sprint_speed: int = 350
@export var boost_speed: int = 400
@export var boost_duration: float = 2.0

# Player state variables
var _speed: int = normal_speed
var isCrouching: bool = false
var isRunning: bool = false

# Health and game stats
var hp: int = 100

func _ready() -> void:
	# Initialize animations
	$AnimatedSprite2D.play("idle")

func _physics_process(delta: float) -> void:
	# Apply gravity
	if not is_on_floor():
		velocity.y += GRAVITY * delta
	
	# Handle jump
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	# Handle sprint
	if Input.is_action_pressed("sprint") and is_on_floor():
		isRunning = true
	elif Input.is_action_just_released("sprint"):
		isRunning = false
	
	# Handle crouch
	if Input.is_action_pressed("crouch") and is_on_floor() and not isRunning:
		isCrouching = true
	elif Input.is_action_just_released("crouch") or not is_on_floor() or isRunning:
		isCrouching = false
	
	# Update speed based on state
	_update_speed()
	
	# Update animations
	_update_animations()
	
	# Update hitbox for crouch
	_update_hitbox()

	# Movement direction
	var direction := Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * _speed
	else:
		velocity.x = move_toward(velocity.x, 0, _speed)
	
	# Flip sprite based on direction
	if direction < 0:
		$AnimatedSprite2D.flip_h = true
	elif direction > 0:
		$AnimatedSprite2D.flip_h = false
	
	move_and_slide()

func _update_speed() -> void:
	if isRunning:
		_speed = sprint_speed
	elif isCrouching:
		_speed = crouching_speed
	else:
		_speed = normal_speed

func _update_animations() -> void:
	if not is_on_floor():
		$AnimatedSprite2D.animation = &"jumping"
	elif isRunning:
		$AnimatedSprite2D.animation = &"running"
	elif isCrouching:
		$AnimatedSprite2D.animation = &"crouching"
	elif velocity.x == 0:
		$AnimatedSprite2D.animation = &"idle"
	else:
		$AnimatedSprite2D.animation = &"walking"


func _update_hitbox() -> void:
	if isCrouching:
		# Shrink collision shape
		$CollisionShape2D.scale.y = 0.6
		$CollisionShape2D.position.y = 9.0
	else:
		# Reset shape
		$CollisionShape2D.scale.y = 1.0
		$CollisionShape2D.position.y = -6.0

func _damage_taken(value: int) -> void:
	hp -= value 
	if value >0 :
	# Visual feedback
		$AnimatedSprite2D.modulate = Color(1.0, 0.53, 0.53)
	elif value <0 :
		$AnimatedSprite2D.modulate = Color.LIGHT_GREEN
		
	await get_tree().create_timer(0.15).timeout
	$AnimatedSprite2D.modulate = Color.WHITE
	
	if hp <= 0:
		_die()

func _die() -> void:
	# Handle player death
	var camera: Camera2D = $Camera2D
	var camera_position = camera.global_position
	
	# Detach camera so it doesn't get deleted with the player
	remove_child(camera)
	get_tree().root.add_child(camera)
	camera.global_position = camera_position
	queue_free()
