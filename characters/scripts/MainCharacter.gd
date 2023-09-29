extends CharacterBody3D
class_name  Character

const normalSpeed: float = 5.0
const sprintSpeed: float = 9.0

var _currentSpeed

@export_category("Objects")
@export var body: Node3D = null
@export var springArmOffset: Node3D = null

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _physics_process(_delta: float) -> void:
	_move()
	move_and_slide()
	body.animate(velocity)
	
func _move() -> void:
	var _input_direction: Vector2 = Input.get_vector(
		"move_left", "move_right",
		 "move_forward","move_backward",
	)
	
	var _direction: Vector3 = transform.basis * Vector3(
		_input_direction.x, 0, _input_direction.y
		).normalized()
	
	is_running()
	
	_direction = _direction.rotated(Vector3.UP, springArmOffset.rotation.y)
	
	if _direction:
		velocity.x = _direction.x * _currentSpeed
		velocity.z = _direction.z * _currentSpeed
		
		body.apply_rotation(velocity.normalized())
		return
	
	velocity.x = move_toward(-velocity.x, 0, _currentSpeed)
	velocity.z = move_toward(velocity.z, 0, _currentSpeed)
	
	
func is_running() -> bool:
	if Input.is_action_pressed("shift"):
		_currentSpeed = sprintSpeed
		return true
	_currentSpeed = normalSpeed
	return false
