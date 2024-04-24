extends Area2D
var damage = 50

func _ready():
	$Timer.start()

func _on_EnemyLaser_body_entered(body):
	if body.name == "Player1" or body.name == "Player2":
		body.hit(damage)


func _on_Timer_timeout():
	queue_free()
