class_name player
extends CharacterBody2D
@export var movement_speed :float = 250;
var _can_run : bool=true
var _can_jump : bool = true
#the pug can crouch now
var isCrouching : bool = false :
	set (value):
		isCrouching=value
		if isCrouching:
	# shrink collision shape
			$CollisionShape2D.scale.y = 0.6
			$CollisionShape2D.position.y=9.0 ;
			movement_speed*=0.75
			_can_jump =false;
			_can_run =false;
		else:
	# Reset shape and animation
			$CollisionShape2D.scale.y = 1.0
			$CollisionShape2D.position.y=-6.0 ;
			movement_speed/=0.75
			_can_jump =true;
			_can_run =true;
			
var hp : int =100 :
	set (value):
		hp=value;
		print(value)
		if (hp<=0):
			var camera = $Camera2D;
			remove_child(camera);
			get_tree().root.add_child(camera);
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
	if Input.is_action_just_pressed("jump") and is_on_floor() and _can_jump==true:
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
	if Input.is_action_just_pressed("sprint") and _can_run ==true:
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
		$AnimatedSprite2D.animation = &"jumping" ;
	
	# Crouch input
	if Input.is_action_just_pressed("crouch") and is_on_floor():
		isCrouching = true
	elif Input.is_action_just_released("crouch"):
		isCrouching = false
	
		
	
	move_and_slide()
func _damage_taken (value :int):
	hp-=value;
