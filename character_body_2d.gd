extends CharacterBody2D
@export var movement_speed :float = 100;
@warning_ignore( "unused_parameter")
var isRunning :bool = false :
	set (value) : 
		isRunning =value;
		if isRunning == true :
			movement_speed *=1.5;
		else: 
			movement_speed /=1.5;
func _process(delta: float) -> void:
	var directie= Input.get_vector("move_left","move_right","move_up","move_down")
	if directie==Vector2.LEFT:
		$AnimatedSprite2D.flip_h=true
	elif directie==Vector2.RIGHT:
		$AnimatedSprite2D.flip_h=false
	velocity=directie*movement_speed;
	move_and_slide ()
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
 
