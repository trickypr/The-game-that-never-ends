extends Node2D

const final_screen = preload("res://Win Screen.tscn")

var time = 60

onready var label = get_node("Label")
onready var player = get_node("/root/Node2D/Player")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(_delta):
	global_position.y = 5

func _tick():
	time -= 1
	label.text = String(time)
	
	# Todo: win screen
	if time == 0:
		print(player.score)
		
		var root = get_node("/root")
		var level = root.get_node("Node2D")
		root.remove_child(level)
		level.call_deferred("free")
		
		var screen = final_screen.instance()
		screen.current_score = player.score
		screen.display()
		root.add_child(screen)
