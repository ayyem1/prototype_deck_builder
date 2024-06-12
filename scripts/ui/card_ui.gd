class_name CardUI
extends Control

signal reparent_requested(which_card_ui: CardUI)

@onready var color: ColorRect = $Color
@onready var state: Label = $State

func _ready():
	pass # Replace with function body.
