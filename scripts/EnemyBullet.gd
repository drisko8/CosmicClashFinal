extends Area2D
export(int) var dir = -5
export(String) var color
var damage = 10

func _physics_process(delta):
	movement(dir)

func movement(dir):
	position.y -= dir

func bulletColor(color):
	if color == "red":
		$Red.visible = true

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


func _on_EnemyBullet_body_entered(body):
	if body.name == "Player1" or body.name == "Player2":
		body.hit(damage)
		queue_free()
