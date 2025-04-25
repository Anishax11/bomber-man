extends Area2D

class_name bomb
var id=0
var explosion_size=1
const CENTRAL_EXPLOSION = preload("res://scenes/central_explosion.tscn")

func _on_timer_timeout() -> void:
	id+=1
	
	var explosion=CENTRAL_EXPLOSION.instantiate()
	explosion.name="CentralExplosion"+str(id)
	explosion.position=position
	explosion.size=explosion_size
	get_tree().root.add_child(explosion)
	
	queue_free()



	
