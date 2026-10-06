extends BaseCharacter

const SPEED = 5.0
const JUMP_VELOCITY = 4.5

var jump_count: int = 2

func _ready() -> void:
	fsm = FSM.new(self, $States, $States/Idle, true)
	super._ready()

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
	
func _update_movement(delta: float) -> void:
	super._update_movement(delta)
	
	if is_on_wall() and not is_on_floor():
		velocity.y = 0
	
	if is_on_floor():
		jump_count = 2
