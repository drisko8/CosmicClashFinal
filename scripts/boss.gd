extends Area2D

var shooting = false

var health = 1000
var damage = 30
var speed = 0.2
var scorePlus = 300
onready var healthbar = $healthBar
onready var anim = $AnimatedSprite
onready var target = position.y + 80

onready var level := get_tree().root.get_node("Level")
const bulletpath = preload("res://scenes/EnemyBullet.tscn")
const laserpath = preload("res://scenes/EnemyLaser.tscn")

func _ready():
	healthbar.value = health
	healthbar.max_value = health
	$healthBar.visible = false
	$healthBarBorder.visible = false
	$Timer.start()
	$LaserTimer.start()
	$LaserAnim.start()


func _process(delta):
	if position.y < target:
		position.y += speed
	
	if health <= 0:
		dead()

func hit(damage):
	health -= damage
	$healthBar.visible = true
	$healthBarBorder.visible = true
	update_health(health)

func shoot():
	var bullet = bulletpath.instance() as Node2D
	bullet.damage = damage
	get_parent().add_child(bullet)
	bullet.position = $Position1.global_position
	
	var bullet2 = bulletpath.instance() as Node2D
	bullet2.damage = damage
	get_parent().add_child(bullet2)
	bullet2.position = $Position2.global_position

func shootLaser():
	var laser = laserpath.instance() as Node2D
	
	get_parent().add_child(laser)
	laser.position =$LaserSpawn1.global_position
	
	var laser2 = laserpath.instance() as Node2D
	
	get_parent().add_child(laser2)
	laser2.position =$LaserSpawn2.global_position

func update_health(health):
	healthbar.value = health

func dead():
	level.scoreUpdate(scorePlus)
	level.bossDead()
	queue_free()

func enemy():
	pass

func animation():
	if shooting:
		anim.play("Laser")
	else:
		anim.play("default")
	

func _on_Timer_timeout():
	shoot()
	$BlasterSFX.play()
	$Timer.start()


func _on_Boss_body_entered(body):
	if body.name == "Player1" or body.name == "Player2":
		body.hit(damage)


func _on_LaserTimer_timeout():
	shootLaser()
	$LaserTimer.start()
	$LaserAnim.start()


func _on_LaserAnim_timeout():
	shooting = true
	animation()
	$LaserSFX.play()

func _on_AnimatedSprite_animation_finished():
	shooting = false
	animation()
