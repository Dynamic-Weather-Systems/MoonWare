extends Control


@onready var heartUIFull = %HeartContainerFull
@onready var heartUIEmpty = %HeartContainerEmpty

#region - Hearts/Max hearts setters
## Current heart count of player
var hearts = 3:
	set(value):
		# current hearts can only be between 0-maxhearts
		hearts = clamp(value,0,max_hearts)

## Maximum current health of player
var max_hearts = 3:
	set(value):
		# max hearts cannot be less than 1
		max_hearts = max(value,1)
#endregion


func _ready() -> void:
	$HealthNumberLabel.text = str(hearts)
	heartUIFull.size.y = 16 * hearts
	heartUIFull.position.y = -16 * (hearts-1)
	heartUIEmpty.size.y = 16 * max_hearts
	heartUIEmpty.position.y = -16 * (max_hearts-1)



#region - Change Hearts functions
# Increase health
func gainHearts(value: int):
	hearts = hearts + value
	$HealthNumberLabel.text = str(hearts)
	heartUIFull.size.y = 16 * hearts
	heartUIFull.position.y = -16 * (hearts-1)

# Lose health
func loseHearts(value: int):
	hearts = hearts - value
	$HealthNumberLabel.text = str(hearts)
	heartUIFull.size.y = 16 * hearts
	heartUIFull.position.y = -16 * (hearts-1)



# gain max health
func gainMaxHearts(value: int):
	max_hearts = max_hearts + value
	heartUIEmpty.size.y = 16 * max_hearts
	heartUIEmpty.position.y = -16 * (max_hearts-1)

# lose max health
func loseMaxHearts(value: int):
	max_hearts = max_hearts - value
	heartUIEmpty.size.y = 16 * max_hearts
	heartUIEmpty.position.y = -16 * (max_hearts-1)


#endregion
