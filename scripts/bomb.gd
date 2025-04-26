extends Area2D

class_name bomb

var explosion_size=1
const CENTRAL_EXPLOSION = preload("res://scenes/central_explosion.tscn")

func _on_timer_timeout() -> void:
	
	Utils.get_last_central()
	var explosion=CENTRAL_EXPLOSION.instantiate()
	explosion.name="CentralExplosion"+str(Utils.central_id)
	explosion.position=position
	explosion.size=explosion_size
	get_tree().root.add_child(explosion)
	
	queue_free()



	
