extends Area2D

func _on_Coin_body_entered(body):
	if body.name == "Player":
		body.increse_score()
		queue_free()
