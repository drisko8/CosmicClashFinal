extends Area2D
var type
var dir = 1

var rng = RandomNumberGenerator.new()
var randomNum = rng.randf_range(0.0,1.0)


func _ready():
	rng.randomize()
	
	randomNum = rng.randf_range(0.0,1.0)
	if randomNum <= 0.33:
		type = "doubleShot"
		abilityType(type)
	if randomNum > 0.33 and randomNum <= 0.66:
		type = "bigShot"
		abilityType(type)
	if randomNum > 0.66:
		type = "heal"
		abilityType(type)

func _process(delta):
	movement(dir)

func movement(dir):
	position.y += dir

func abilityType(type):
	if type == "doubleShot":
		$Doubleshot.visible = true
	else:
		$Doubleshot.visible = false
	
	if type == "bigShot":
		$Bigshot.visible = true
	else:
		$Bigshot.visible = false
	
	if type=="heal":
		$Heal.visible = true
	else:
		$Heal.visible = false

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


func _on_AbilityDrop_body_entered(body):
	if body.name == "Player1" or "Player2":
		body.ability(type)
		queue_free()

