extends BaseState

export (NodePath) var idle_node

onready var idle_state = get_node(idle_node)

var combo_is_active = false

var input_threshold = 0.5

 # keep at .4-6 for single frame. 

var base_time = 0
# base time is the starting time for combo while threshold hold the amount of time between attacks 
var current_attack = 0
var previous_attack = 0

func _ready():
	base_time = input_threshold
	
func physics_process(delta: float) -> BaseState:
	if(Input.is_action_just_pressed("attack")):
		if(current_attack == 0):
			.enter()
		combo_is_active = true
		current_attack += 1
		reset_attack_time()
		
	if(combo_is_active):
		base_time -= delta
		
	if(base_time < 0):
		base_time = input_threshold
		combo_is_active = false
		current_attack = 0
		return idle_state
	return null
func reset_attack_time():
	if(current_attack < 4):
		base_time = input_threshold
