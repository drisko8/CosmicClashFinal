extends Area2D
export(int) var dir = 5
var damage = 20

func _ready():
	$Big.play("default")
	$CollisionShape2D.shape.radius =  20

func _physics_process(delta):
	movement(dir)

func movement(dir):
	position.y -= dir


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func _on_BigBullet_area_entered(area):
	if area.has_method("enemy"):
		area.hit(damage)
		dir = 3
		$CollisionShape2D.shape.radius =  100
		$Big.play("hit")
		$BigExplosionSFX.play()

func _on_BigExplosionSFX_finished():
	queue_free()

func _on_Big_animation_finished():
	queue_free()
