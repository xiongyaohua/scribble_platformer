extends CharacterBody2D


const SPEED = 800.0
const JUMP_VELOCITY = -700.0

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var body_anchor: Marker2D = $BodyAnchor
@onready var body: Sprite2D = $BodyAnchor/Body

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_up") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		body_anchor.scale.x = direction
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
