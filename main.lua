local Core = loadstring(game:HttpGet("CORE_LINK"))()
local Config = loadstring(game:HttpGet("CONFIG_LINK"))()

Core.Config = Config

Core.Modules.AutoFarm = loadstring(game:HttpGet("AUTOFARM_LINK"))()
Core.Modules.Tween = loadstring(game:HttpGet("TWEEN_LINK"))()
Core.Modules.Enemy = loadstring(game:HttpGet("ENEMY_LINK"))()

print("SYSTEM LOADED")

-- Başlat
Core.Modules.AutoFarm.Start(Core)