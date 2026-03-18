local Core = loadstring(game:HttpGet("https://raw.githubusercontent.com/Isohubprodutcs/BloxScript-sohub/main/core.lua"))()
local Config = loadstring(game:HttpGet("https://raw.githubusercontent.com/Isohubprodutcs/BloxScript-sohub/main/config.lua"))()

Core.Config = Config

Core.Modules.AutoFarm = loadstring(game:HttpGet("https://raw.githubusercontent.com/Isohubprodutcs/BloxScript-sohub/main/modules/autofarm.lua"))()
Core.Modules.Tween = loadstring(game:HttpGet("https://raw.githubusercontent.com/Isohubprodutcs/BloxScript-sohub/main/modules/tween.lua"))()
Core.Modules.Enemy = loadstring(game:HttpGet("https://raw.githubusercontent.com/Isohubprodutcs/BloxScript-sohub/main/modules/enemy.lua"))()

print("SYSTEM LOADED")

Core.Modules.AutoFarm.Start(Core)
