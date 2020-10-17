extends Area2D

onready var col_shape = get_node("CollisionShape2D")
onready var root = get_node("/root/Node2D")

const Platform = preload("res://actors/Platform.tscn")

var first_platform = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	global_position.y = col_shape.shape.extents.y
	scale.x 

func _body_entered(body):
	var type = body.get_class() == "Platform"
	
	if type and not body.gened:
		if first_platform:
			body.gen(0)
		
		var x = body.position.x + (body.width * body.mult)
		
		var platfom = Platform.instance()
		platfom.position.x = x
		platfom.gen(0)
		
		root.add_child(platfom)
		
		body.gened = true 
	


func _remove(body):
	var type = body.get_class() == "Platform"
	if type:
		body.queue_free()
