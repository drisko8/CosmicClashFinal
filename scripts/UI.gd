extends Control

func scoreVisible(i):
	if i:
		$Score.visible = true
		
	else:
		$Score.visible = false

func setScore(score):
	$Score.text = "Score:  " + str(score)


func _process(delta):
	$Highscore.text = "Highscore:  " + str(colorState.highscore)
	$Currency.text = "Space-Bucks:  " + str(colorState.spaceBucks)
