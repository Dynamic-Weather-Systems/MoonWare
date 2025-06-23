extends Microgame


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	randomize()
	super() # calls the _ready function of microgame main
	
	var labels = [$Sunny, $Cloudy, $"Partly Cloudy", $Showers, $Stormy]
	var sprites = [$sunny_sprite, $cloudy_sprite, $partly_cloudy_sprite, $showers_sprite, $stormy_sprite]
	labels.shuffle()
	sprites.shuffle()
	for i in range(len(labels)):
		labels[i].global_position.x = ((90 * (i+1)) - 50) + (i-2) * 15
		sprites[i].global_position.x = (90 * (i+1))
		var rand_temp = Vector2(randi_range(15,30), randi_range(15,30))
		labels[i].text = str(labels[i].name) + '\nHi    Lo\n' + str(max(rand_temp.x,rand_temp.y)) + '   ' + str(min(rand_temp.x,rand_temp.y))
	
	countdown.start() # starts the timer


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#pass
