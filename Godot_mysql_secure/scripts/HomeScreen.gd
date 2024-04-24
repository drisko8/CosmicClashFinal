extends CanvasLayer

func _ready():
	$Control._get_player()
	$UI/scorebox.visible = false

func _on_TextureButton_pressed():
	$ClickSFX1.play()


func _on_Shop_pressed():
	$ClickSFX2.play()



func _on_Quit_pressed():
	$ClickSFX3.play()


func _on_ClickSFX1_finished():
	get_tree().change_scene("res://scenes/ColorSelecterScreen.tscn")


func _on_ClickSFX2_finished():
	get_tree().change_scene("res://scenes/lootboxes.tscn")


func _on_ClickSFX3_finished():
	get_tree().quit()
