class_name player
extends CharacterBody2D
@export var movement_speed :float = 250;

var hp : int =100 :
	set (value):
		hp=value;
		print(value)
		if (hp<=0):
			queue_free();
const JUMP_VELOCITY = -400.0
var isRunning :bool = false :
	set (value) : 
		isRunning =value;
		if isRunning == true :
			movement_speed *=2;
		else: 
			movement_speed /=2;


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * movement_speed
	else:
		velocity.x = move_toward(velocity.x, 0, movement_speed)
	if direction<0:
		$AnimatedSprite2D.flip_h=true
	elif direction>0:
		$AnimatedSprite2D.flip_h=false
	if Input.is_action_just_pressed("sprint"):
		isRunning =true;
	elif Input.is_action_just_released("sprint"):
		isRunning =false;
		
	if velocity != Vector2.ZERO :
		$AnimatedSprite2D.play()
	else :
		$AnimatedSprite2D.stop()
	
	if isRunning && velocity !=Vector2.ZERO :
		$AnimatedSprite2D.animation = &"running"
	else :
		$AnimatedSprite2D.animation = &"walking"
		
	if !is_on_floor():
		$AnimatedSprite2D.animation = &"jumping"
	
	
	move_and_slide()
func _damage_taken (value :int):
	hp-=value;
