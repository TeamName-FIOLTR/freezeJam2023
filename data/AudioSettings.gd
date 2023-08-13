extends Resource
class_name AudioSettings

@export var MasterVolume : float = 1.0
@export var TurretFireVolume : float = 1.0
@export var TurretWhirlVolume : float = 1.0
@export var FreezeEffectVolume : float = 1.0

func load_settings():
	var master_idx = AudioServer.get_bus_index("Master")
	var turret_fire_idx = AudioServer.get_bus_index("Guns")
	var turret_whirl_idx = AudioServer.get_bus_index("Whirl")
	var freeze_fx_idx = AudioServer.get_bus_index("FreezeFX")
	
	AudioServer.set_bus_volume_db(master_idx, linear_to_db(MasterVolume))
	AudioServer.set_bus_volume_db(turret_fire_idx, linear_to_db(TurretFireVolume))
	AudioServer.set_bus_volume_db(turret_whirl_idx, linear_to_db(TurretWhirlVolume))
	AudioServer.set_bus_volume_db(freeze_fx_idx, linear_to_db(FreezeEffectVolume))
	pass
