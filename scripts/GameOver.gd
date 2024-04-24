extends CanvasLayer



func _ready():
	$Control._add_score()
	$UI/scorebox.visible = false

func _on_Retry_pressed():
	$ClickSFX1.play()

func _on_Home_pressed():
	$ClickSFX2.play()

func _on_ClickSFX1_finished():
	get_tree().change_scene("res://scenes/ColorSelecterScreen.tscn")

func _on_ClickSFX2_finished():
	get_tree().change_scene("res://scenes/HomeScreen.tscn")
