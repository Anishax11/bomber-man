extends Area2D


const BUTTON = preload("res://scenes/button.tscn")

func _on_area_entered(area: Area2D) -> void:
	if area is Player:
		print("Game cleared!")
		var Label=get_node("/root/game/Label2")
		
		Label.text="You Win!!"
		var button=BUTTON.instantiate()
		button.position=Vector2(-120,0)
		button.text="[ Replay ]"
		get_parent().add_child(button)
