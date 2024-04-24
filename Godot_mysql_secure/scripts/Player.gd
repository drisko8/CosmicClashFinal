extends KinematicBody2D
var velocity = Vector2()
var speed = 400
var health = 100
var cooldown = true
var doubleShot = false
var bigShot = false
var filler = 1
export(String) var left
export(String) var right
export(String) var up
export(String) var down
export(String) var shot
export(String) var color
export(int) var pNum

onready var level := get_tree().root.get_node("Level")

const bulletpath = preload("res://scenes/Bullet.tscn")
const bigbulletpath = preload("res://scenes/BigBullet.tscn")

func _physics_process(delta):
	get_input()
	velocity = move_and_slide(velocity, Vector2(0,-1))
	update_health(health)
	if Input.is_action_just_pressed(shot) and cooldown:
		shoot()
		if bigShot:
			$BigCooldownTimer.start()
			cooldown = false
		else:
			$CooldownTimer.start()
			cooldown = false
	
	if health <= 0:
		dead()

	
	shipColor(color)
	playerNumber(pNum)

func get_input():
	var input_direction = Input.get_vector(left, right, up, down)
	velocity = input_direction * speed

func hit(damage):
	$DamageSFX.play()
	health -= damage
	update_health(health)

func update_health(health):
	var healthbar = $healthBar
	healthbar.value = health

func dead():
	level.saveScore()
	get_tree().change_scene("res://scenes/GameOver.tscn")

func shoot():
	$PlayerBlasterSFX.play()
	if doubleShot:
		var bullet = bulletpath.instance() as Node2D
		var bullet2 = bulletpath.instance() as Node2D
		get_parent().add_child(bullet)
		get_parent().add_child(bullet2)
		bullet.position = $doubleshot1.global_position
		bullet2.position = $doubleshot2.global_position
	elif bigShot:
		var bullet = bigbulletpath.instance() as Node2D
		get_parent().add_child(bullet)
		bullet.position = $Position2D.global_position
	else:
		var bullet = bulletpath.instance() as Node2D
		get_parent().add_child(bullet)
		bullet.position = $Position2D.global_position

func ability(type):
	if type == "doubleShot":
		$PowerUpSFX.play()
		doubleShot = true
		bigShot = false
		$AbilityTimer.start()
	if type == "bigShot":
		$PowerUpSFX.play()
		doubleShot = false
		bigShot = true
		$AbilityTimer2.start()
	if type == "heal":
		$HealSFX.play()
		health += 25



func shipColor(color):
	if(color=="Orange"):
		$OrangeShip.visible = true
	else:
		$OrangeShip.visible = false
	if(color=="Purple"):
		$PurpleShip.visible = true
	else:
		$PurpleShip.visible = false
	if(color=="Green"):
		$GreenShip.visible = true
	else:
		$GreenShip.visible = false
	if(color=="Pink"):
		$PinkShip.visible = true
	else:
		$PinkShip.visible = false

func playerNumber(pNum):
	if(pNum==1):
		$P1.visible = true
	else:
		$P1.visible = false
	if(pNum==2):
		$P2.visible = true
	else:
		$P2.visible = false


func _on_Timer_timeout():
	if bigShot:
		filler+=1
	else:
		cooldown = true


func _on_AbilityTimer_timeout():
	doubleShot = false
	cooldown = true

func _on_AbilityTimer2_timeout():
	bigShot = false
	cooldown = true


func _on_BigCooldownTimer_timeout():
	if bigShot:
		cooldown = true


