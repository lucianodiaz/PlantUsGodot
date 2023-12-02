extends Node

@export var initial_state : State
@export var plant:Plant

var current_state : State
var states: Dictionary = {}

# Called when the node enters the scene tree for the first time.
func _ready():
	for child in get_children():
		for state in child.get_children():
			if state is State:
				print("StateMachine/"+plant.getCurrentGrowth()+"/"+state.name)
				states["StateMachine/"+plant.getCurrentGrowth()+"/"+state.name.to_lower()] = state
				state.Transitioned.connect(on_state_transition)
	if initial_state:
		initial_state._enter()
		current_state = initial_state


func _process(delta):
	if current_state:
		current_state._update(delta)

func on_state_transition(state, new_state_name):
	if state != current_state:
		return
	
	var new_state = states.get(new_state_name)
	if !new_state:
		return
	
	if current_state:
		current_state._exit()
	
	new_state._enter()
	
	current_state = new_state
