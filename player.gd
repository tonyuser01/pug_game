class_name player
extends CharacterBody2D
const JUMP_VELOCITY = -400.0
@export var normal_speed : int = 250
@export var  crouching_speed : int = 150
@export var sprint_speed : int =350
var _speed : int =0;
#the pug can crouch now
var isCrouching : bool = false 
var isRunning : bool = false
			
var hp : int =100 :
	set (value):
		hp=value;
		print("HP:", hp)
		if (hp<=0):
			var camera : Camera2D = $Camera2D;
			var camera_position =Vector2.ZERO;
			camera_position = camera.global_position;
			remove_child(camera);
			get_tree().root.add_child(camera);
			camera.global_position =camera_position
			queue_free();
				
func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor() :
		velocity.y = JUMP_VELOCITY
	if Input.is_action_pressed("sprint") && is_on_floor()==true :
			isRunning = true;
	elif Input.is_action_just_released("sprint"):
		isRunning = false;
	if Input.is_action_pressed("crouch") && is_on_floor()==true && isRunning==false:
		isCrouching = true;
	elif Input.is_action_just_released("crouch") || is_on_floor()==false || isRunning ==true:
		isCrouching = false;
	
	
	#we set speeds 
	
	if isRunning ==true:
		_speed =sprint_speed
	elif isCrouching ==true :
		_speed =crouching_speed 
	else : _speed =normal_speed
		
	#we set animations
	
	if is_on_floor() ==false :
		$AnimatedSprite2D.animation = &"jumping" 
	elif isRunning ==true :
		$AnimatedSprite2D.animation = &"running" 
	elif isCrouching == true:
		$AnimatedSprite2D.animation = &"crouching" 
	elif velocity == Vector2.ZERO : 
		$AnimatedSprite2D.animation = &"idle" 
	else : $AnimatedSprite2D.animation = &"walking" 
	
	
	#we set hitbox for crouch
	
	if isCrouching ==true :
	# shrink collision shape
		$CollisionShape2D.scale.y = 0.6
		$CollisionShape2D.position.y=9.0 ;
	else:
	# Reset shape and animation
		$CollisionShape2D.scale.y = 1.0
		$CollisionShape2D.position.y=-6.0 ;

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * _speed
	else:
		velocity.x = move_toward(velocity.x, 0, _speed)
	if direction<0:
		$AnimatedSprite2D.flip_h=true
	elif direction>0:
		$AnimatedSprite2D.flip_h=false
	
	# Crouch input
	move_and_slide()
func _damage_taken (value :int):
	hp-=value;
	$AnimatedSprite2D.modulate = Color(1.0 ,0.53 ,0.53)
	await get_tree().create_timer(0.15).timeout 
	$AnimatedSprite2D.modulate = Color.WHITE ;
