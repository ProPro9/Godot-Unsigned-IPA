extends VBoxContainer

@onready var option_sampling_buffer: OptionButton = %OptionSamplingBuffer
@onready var option_countdown_type: OptionButton = %OptionCountdownType
func _set_from_profile() -> void :
	option_sampling_buffer.select(Profile.debug_sample_timing)
	option_countdown_type.select(Profile.debug_countdown_type)
func _connect_signals() -> void :
	option_sampling_buffer.item_selected.connect(Profile._set_debug_sample_timing)
	option_countdown_type.item_selected.connect(Profile._set_debug_countdown_type)

func _ready() -> void :
	_set_from_profile()
	_connect_signals()
