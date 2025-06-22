extends Microgame


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super() # calls the _ready function of microgame main
	countdown.start() # starts the timer


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
