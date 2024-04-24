extends Node

var color1 
var color2
var greenUnlocked = false
var pinkUnlocked = false

var spaceBucks = 100

var highscore = 0

var playerName = ""

func skinUnlocked(color):
	if color == "Green":
		greenUnlocked = true
	if color == "Pink":
		pinkUnlocked = true

func highscoreUpdate(score):
	if score > highscore:
		highscore = score

func spaceBucksUpdate(currentScore):
	spaceBucks += currentScore/10

func playerNameUpdate(Name):
	playerName=Name

func color1Change(color):
	color1 = color

func color2Change(color):
	color2 = color
