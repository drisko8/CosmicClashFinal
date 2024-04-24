extends Area2D
var damage = 20
var scorePlus = 10
onready var healthbar = $healthBar
onready var shootTime = $Timer
var health = 40

var speed = 150

var moveDistY = position.y + 100
var moveDist = 720

var startX : float = 0
var startY : float

var target : float
var targetX : float = position.x + moveDist

var rng = RandomNumberGenerator.new()
var randomNum = rng.randf_range(0.0,1.0)
var ranomChance = 0.3

onready var level := get_tree().root.get_node("Level")

const bulletpath = preload("res://scenes/EnemyBullet.tscn")
const abilitypath = preload("res://scenes/AbilityDrop.tscn")

func _ready():
	$Timer.start()
	healthbar.max_value = health
	$healthBar.visible = false
	$healthBarBorder.visible = false
	update_health(health)
	rng.randomize()

func _process(delta):
	if health <= 0:
		dead()
	
	target = startX + moveDist
	
	position.y += 0.2
	
	position.x = move_to(position.x, targetX, speed *delta)
	if position.x == targetX:
		if targetX == startX:
			targetX = position.x + moveDist
		else:
			targetX = startX

func move_to(current, to, step):
	var new = current
	
	if new < to:
		new += step
		
		if new > to:
			new = to
	else:
		new -=step
		if new<to:
			new = to
	return new

func hit(damage):
	health -= damage
	$healthBar.visible = true
	$healthBarBorder.visible = true
	update_health(health)

func update_health(health):
	healthbar.value = health

func shoot():
	var bullet = bulletpath.instance() as Node2D
	
	$EnemyBlasterSFX.play()
	
	get_parent().add_child(bullet)
	bullet.position = $Position2D.global_position

func shootTime(input):
	shootTime.wait_time = input
	
func dead():
	level.scoreUpdate(scorePlus)
	level.enemyDead()
	randomNum = rng.randf_range(0.0,1.0)
	
	if randomNum < ranomChance :
		var ability = abilitypath.instance() as Node2D
	
		get_parent().add_child(ability)
		ability.position = position
	queue_free()
  
func _on_VisibilityNotifier2D_screen_exited():
	level.enemyDead()
	queue_free()

func _on_Enemy_body_entered(body):
	if body.name == "Player1" or body.name == "Player2":
		body.hit(damage)


func _on_Timer_timeout():
	shoot()
	$Timer.start()

func enemy():
	pass
