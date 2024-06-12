class_name CardStateMachine
extends Node

@export var initial_state: CardState

var current_state: CardState
var states := {}

func init(card: CardUI) -> void:
	# Assumes that state nodes are children of this state machine node.
	for child in get_children():
		if child is CardState:
			states[child.state] = child
			child.transition_requested.connect(_on_transition_requested)
			child.card_ui = card
		
		if initial_state:
			initial_state.enter()
			current_state = initial_state

func _on_transition_requested(from: CardState, to: CardState.State):
	if from != current_state:
		print_debug("Warning: Attempted to transition from a state when we are not in that state.")
		return
	
	var new_state = states[to]
	if not new_state:
		print_debug("Warning: Attempted to transition to a state that does not exist.")
		return
	
	current_state.exit()
	new_state.enter()
	current_state = new_state

func on_input(event: InputEvent) -> void:
	if current_state:
		current_state.on_input(event)

func on_gui_input(event: InputEvent) -> void:
	if current_state:
		current_state.on_gui_input(event)

func on_mouse_entered() -> void:
	if current_state:
		current_state.on_mouse_entered()

func on_mouse_exited() -> void:
	if current_state:
		current_state.on_mouse_exited()