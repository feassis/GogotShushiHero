extends Area3D

@export
var _Stool: PackedScene = null

var chairPosition: Array = [
	Vector3(0, 0, 2),
	Vector3(2, 0, 0),
	Vector3(0, 0, -2),
	Vector3(-2, 0, 0)
	]

var chairOfsetPosition : Array = [
	Vector3(0, 0, 0.4),
	Vector3(0.4, 0, 0),
	Vector3(0, 0, -0.4),
	Vector3(-0.4, 0, 0)
	]

var angleRotation : Array = [
	0,
	PI/2,
	PI,
	-PI + PI/2 
]

var offset: Vector3 = Vector3.ZERO

@export_category("Variables")
@export var chairAmount: int = 1
@export var isAvailable: bool = true

@export_category("Objects")
@export var stools: Node3D = null

func _ready() -> void:
	for chair in chairAmount:
		var newChair = _Stool.instantiate()
		newChair.transform.origin = chairPosition[chair]
		stools.add_child(newChair)
		
func isTableAvailable(entity) -> void:
	if not isAvailable: 
		entity.updateState("seek_table")
		return
	
	var index: int = randi() % stools.get_child_count()
	var rotation: float = angleRotation[index]
	
	changeAvailableState(false)
	offset = chairPosition[index] - chairOfsetPosition[index]
	entity.updateState("walking", offset, global_position, rotation)

func changeAvailableState(state: bool) -> void:
	isAvailable = state
