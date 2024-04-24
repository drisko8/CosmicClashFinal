extends Node2D
onready var selectedPlayer1 = $ShipSelect
onready var selectedPlayer2 = $ShipSelect2

var player1Choose = false
var player2Choose = false

func _ready():
	if colorState.greenUnlocked:
		$Lock.visible = false
		$Lock3.visible = false
	else:
		$Lock.visible = true
		$Lock3.visible = true
	if colorState.pinkUnlocked:
		$Lock2.visible = false
		$Lock4.visible = false
	else:
		$Lock2.visible = true
		$Lock4.visible = true

func _on_TextureButton_pressed():
	$ClickSFX1.play()

func _on_ClickSFX1_finished():
	if player1Choose and player2Choose:
		get_tree().change_scene("res://scenes/Level.tscn")
	else: $PleaseChoose.visible = true

func _on_Player1Orange_pressed():
	colorState.color1Change("Orange")
	selectedPlayer1.position.x = 119
	selectedPlayer1.position.y = 520
	player1Choose = true

func _on_Player2Purple_pressed():
	colorState.color2Change("Purple") 
	selectedPlayer2.position.x = 601
	selectedPlayer2.position.y = 520
	player2Choose = true

func _on_Player2Orange_pressed():
	colorState.color2Change("Orange")
	selectedPlayer2.position.x = 519
	selectedPlayer2.position.y = 520
	player2Choose = true

func _on_Player1Purple_pressed():
	colorState.color1Change("Purple") 
	selectedPlayer1.position.x = 201
	selectedPlayer1.position.y = 520
	player1Choose = true

func _on_Player1Green_pressed():
	if colorState.greenUnlocked:
		colorState.color1Change("Green") 
		selectedPlayer1.position.x = 119
		selectedPlayer1.position.y = 602
		player1Choose = true

func _on_Player2Green_pressed():
	if colorState.greenUnlocked:
		colorState.color2Change("Green") 
		selectedPlayer2.position.x = 519
		selectedPlayer2.position.y = 602
		player2Choose = true

func _on_Player2Pink_pressed():
	if colorState.pinkUnlocked:
		colorState.color2Change("Pink") 
		selectedPlayer2.position.x = 601
		selectedPlayer2.position.y = 602
		player2Choose = true

func _on_Player1Pink_pressed():
	if colorState.pinkUnlocked:
		colorState.color1Change("Pink") 
		selectedPlayer1.position.x = 201
		selectedPlayer1.position.y = 602
		player1Choose = true

func _on_Back_pressed():
	$ClickSFX2.play()

func _on_ClickSFX2_finished():
	get_tree().change_scene("res://scenes/HomeScreen.tscn")
