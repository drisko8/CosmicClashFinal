extends Area2D
export(int) var dir = 10
var damage = 10

func _ready():
	$Blue.visible = true

func _physics_process(delta):
	movement(dir)


func movement(dir):
	position.y -= dir

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func _on_Bullet_area_entered(area):
	if area.has_method("enemy"):
		area.hit(damage)
		queue_free()

