extends CharacterBody3D
class_name  Character

const normalSpeed: float = 5.0
const sprintSpeed: float = 9.0

var _currentSpeed
var current_entity
var isFreezed: bool = false
var canInteract : bool  = true

var lastFood: String

@export_category("Objects")
@export var body: Body = null
@export var springArmOffset: CharacterSpringArm = null
@export var itemFeedback: MeshInstance3D = null
@export var inventory: Inventory = null

var lastPreparedIngredientAmount: int = 0
var lastPreparedIngredient

func _ready() -> void:
	globals.character = self
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _physics_process(_delta: float) -> void:
	if isFreezed:
		return
	
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

func freeze(state: bool) -> void:
	body.animation.play("Idle")
	
	if state: 
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	else:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
	springArmOffset.canRotate = not state
	isFreezed = state

func Cook(recipe: String):
	lastFood = recipe
	canInteract = false
	
	itemFeedback.get_node("Front").texture = load(
		recipes.recipes_dict[recipe]["item_texture"]
	)
	
	itemFeedback.get_node("Back").texture = load(
		recipes.recipes_dict[recipe]["item_texture"]
	)
	
	body.isCooking = true
	body.animate(velocity)
	set_physics_process(false)
	springArmOffset.canRotate = true

func Chop(ingredient, amount):
	canInteract = false
	lastPreparedIngredient = ingredient
	lastPreparedIngredientAmount = amount
	
	itemFeedback.get_node("Front").texture = load(
		ingredients.ingredients_dict[ingredient]["item_texture"]
	)
	
	itemFeedback.get_node("Back").texture = load(
		ingredients.ingredients_dict[ingredient]["item_texture"]
	)
	
	body.isChopping = true
	set_physics_process(false)
	springArmOffset.canRotate = true
		
func ChangePosition(desiredPos: Vector3, desiredRotation: float) -> void:
	global_position = desiredPos
	body.rotation.y = desiredRotation

func OnChopFinished():
	freeze(false)
	body.isChopping= false
	set_physics_process(true)
	itemFeedback.get_node("Animation").play("Show_Igredients")

func OnCookFinished():
	freeze(false)
	body.isCooking = false
	set_physics_process(true)
	itemFeedback.get_node("Animation").play("Show")


func _on_item_animation_animation_finished(anim_name):
	match anim_name:
		"Show":
			var item: Dictionary = {}
			item[lastFood] = {
				"item_amount": 1,
				"item_name": lastFood,
				"item_texture": recipes.recipes_dict[lastFood]["item_texture"],
				"price": recipes.recipes_dict[lastFood]["price"]
				
			}
			
			inventory.AddItem(item[lastFood])
		"Show_Igredients":
			for i  in lastPreparedIngredientAmount:
				var item: Dictionary = {}
				item[lastPreparedIngredient] = {
				"item_amount": 1,
				"item_name": lastPreparedIngredient,
				"item_texture": ingredients.ingredients_dict[lastPreparedIngredient]["item_texture"],
				}
				inventory.AddItem(item[lastPreparedIngredient])
			
	
	canInteract = true
	if current_entity != null:
		current_entity.CanInteract(true)
