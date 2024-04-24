extends CanvasLayer

var rng = RandomNumberGenerator.new()
var randomNum = rng.randf_range(0.0,2.0)

var bought = false

func _ready():
	$UI/scorebox.visible = false

func buyLoot():
	colorState.spaceBucks -= 100
	if colorState.pinkUnlocked and colorState.greenUnlocked:
		colorState.spaceBucks += 100
		$AllBought.visible = true
	elif colorState.pinkUnlocked:
		reward("Green")
	elif colorState.greenUnlocked:
		reward("Pink")
	else:
		rng.randomize()
		if randomNum >1:
			reward("Green")
		elif randomNum <=1:
			reward("Pink")

func reward(color):
	$RewardSFX.play()
	$Timer.start()
	bought = true
	$LootboxSprite.visible = false
	$Lootbox.visible = false
	colorState.skinUnlocked(color)
	if color == "Green":
		$Green.visible = true
		$GreenBought.visible = true
	else:
		$Green.visible = false
		$GreenBought.visible = false
	if color == "Pink":
		$Pink.visible = true
		$PinkBought.visible = true
	else:
		$Pink.visible = false
		$PinkBought.visible = false

func _on_TextureButton_pressed():
	$ClickSFX1.play()
	if bought == false:
		if colorState.spaceBucks >= 100:
			buyLoot()
		else:
			$NotEnough.visible = true


func _on_Back_pressed():
	$ClickSFX2.play()



func _on_Timer_timeout():
	bought = false
	$Pink.visible = false
	$PinkBought.visible = false
	$Green.visible = false
	$GreenBought.visible = false
	$LootboxSprite.visible = true
	$Lootbox.visible = true


func _on_ClickSFX2_finished():
	get_tree().change_scene("res://scenes/HomeScreen.tscn")
