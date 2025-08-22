extends Label
@onready var player: Player = %player

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.text

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if player:
		text = str(player.hp) + "/" + str(player.max_hp);
