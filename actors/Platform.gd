extends StaticBody2D
class_name Platform

const Coin = preload("res://actors/Coin.tscn")

var mult = 16
var width = 5
var max_jump_height = 30
var floor_y = 584

var gened = false

var rng = RandomNumberGenerator.new()

func get_class():
	return "Platform"

func gen(origin: int):
	var height = floor_y + 100
	height *= mult
	scale.x = width
	
	rng.randomize()
	
	while (floor_y - height) >= floor_y or (floor_y - height) < 0:
		height = rng.randi_range(max_jump_height, -max_jump_height) + origin
		height *= mult
	
	position.y = floor_y - height
	
	var coin_chance = rng.randi_range(1, 10)
	if coin_chance == 9:
		var coin = Coin.instance()
		add_child(coin)
		coin.position.y -= 40
		coin.global_scale = Vector2(0.5,0.5)
	

func is_platform():
	return true
