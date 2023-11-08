extends CharacterBody3D
class_name  BaseClient

@export_category("Setup")
@export var normalSpeed: float = 3

@export_category("Objects")
@export var armature: Node3D = null
@export var clientFeedback: MeshInstance3D = null
@export var navigationAgent: NavigationAgent3D = null
@export var eatTimer: Timer = null
@export var waitTimer: Timer = null

var food: Dictionary = {}
var characterRef =null

var roation: float = PI
var seekingFor: String = ""

var tableIndex: int = -1
var tableList: Array = []

var sofaIndex: int = -1
var sofaList: Array = []

var objectPosition: Vector3 = Vector3.ZERO
var targetPosition: Vector3 = Vector3.ZERO

var timeLeft: float
var satisfied: bool = false

var onSofa: bool = false
var onTable: bool = false
