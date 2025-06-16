extends Control


@onready var heartUIFull = %HeartContainerFull
@onready var heartUIEmpty = %HeartContainerEmpty

#region - Hearts/Max hearts setters
## Current heart count of player
var hearts = 3:
	set(value):
		# current hearts can only be between 0-maxhearts
		hearts = clamp(value,0,max_hearts)
		update_hearts_ui(hearts, max_hearts)

## Maximum current health of player
var max_hearts = 3:
	set(value):
		# max hearts cannot be less than 1
		max_hearts = max(value,1)
		hearts = min(hearts, max_hearts)
#endregion


func _ready() -> void:
	max_hearts = 3
	hearts = max_hearts


# update ui hearts to match vars
func update_hearts_ui(hearts: int, maxHearts: int):
	$HealthNumberLabel.text = str(hearts)
	heartUIEmpty.size.y = 16 * max_hearts
	heartUIEmpty.position.y = -16 * (max_hearts-1)
	heartUIFull.size.y = 16 * hearts
	heartUIFull.position.y = -16 * (hearts-1)
