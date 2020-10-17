extends Control

var score_file = "user://highscore.txt"
var highscore = 0
var current_score = 0

onready var label = get_node("Main")

func display():
	label = get_node("Main")
	
	load_score()
	
	if highscore > current_score:
		label.text = "You missed your high score by " + String(highscore - current_score) + "!"
	else:
		label.text = "You beat your high score by " + String(current_score - highscore) + "!"
		highscore = current_score
		save_score()
	

# call this at the beginning of your game.
# Tests to see if the file exists and loads the contents if it does
func load_score():
	var f = File.new()
	if f.file_exists(score_file):
		f.open(score_file, File.READ)
		var content = f.get_as_text()
		highscore = int(content)
		f.close()

# call this at game end to store a new highscore
func save_score():
	var f = File.new()
	f.open(score_file, File.WRITE)
	f.store_string(str(highscore))
	f.close()


func _on_Button_pressed():
	get_tree().change_scene("res://world.tscn")
	queue_free()
