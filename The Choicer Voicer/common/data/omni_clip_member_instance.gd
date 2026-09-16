class_name OmniClipMemberInstance extends Resource


@export var shared_omniclip: OmniClip


@export var member_audio: AudioStream
@export var member_waveform_texture: Texture2D
@export var data_vclip_average: PackedByteArray
@export var data_vclip_maximum: PackedByteArray
@export var data_vclip_pitches: PackedByteArray
@export var data_plmic_average: PackedByteArray
@export var data_plmic_maximum: PackedByteArray
@export var data_plmic_pitches: PackedByteArray
@export var score: float




func write_vclip_data_from_aggregate(input: SpectrumAggregate) -> void :
	data_vclip_average = input.samples_magnitude_average.duplicate()
	data_vclip_maximum = input.samples_magnitude_maximum.duplicate()
	data_vclip_pitches = input.samples_pitch.duplicate()
func write_plmic_data_from_aggregate(input: SpectrumAggregate) -> void :
	data_plmic_average = input.samples_magnitude_average.duplicate()
	data_plmic_maximum = input.samples_magnitude_maximum.duplicate()
	data_plmic_pitches = input.samples_pitch.duplicate()


func generate_score() -> void :
	data_plmic_average.resize(data_vclip_average.size())
	data_plmic_maximum.resize(data_vclip_maximum.size())
	data_plmic_pitches.resize(data_vclip_pitches.size())
	score = MathService.gen_3_scorer(
		data_vclip_average, 
		data_vclip_maximum, 
		data_vclip_pitches, 
		data_plmic_average, 
		data_plmic_maximum, 
		data_plmic_pitches
	)


func save_recording(as_file_name: String) -> void :
	if !member_audio is AudioStreamWAV: return
	if !member_audio: printerr("OmniClipMemberInstance | No recording to save.");return
	if !as_file_name.ends_with(".wav"): as_file_name += ".wav"
	member_audio.save_to_wav(FileManager.RECORDINGS + as_file_name)
	print("OmniClipMemberInstance | Recording saved.")
