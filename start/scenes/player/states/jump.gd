extends PlayerState

func _enter() -> void:
	obj.change_animation("jump")
	pass

func _update(_delta: float):
	control_moving()
	control_jump()
	
	if obj.velocity.y < 0:
		change_state(fsm.states.fall)
