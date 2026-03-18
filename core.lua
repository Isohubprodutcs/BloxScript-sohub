local Core = {}

--// Services
Core.Services = {
    Players = game:GetService("Players"),
    RunService = game:GetService("RunService"),
    TweenService = game:GetService("TweenService"),
    ReplicatedStorage = game:GetService("ReplicatedStorage")
}

--// Player
Core.Player = Core.Services.Players.LocalPlayer
Core.Character = Core.Player.Character or Core.Player.CharacterAdded:Wait()

--// Character Update
Core.Player.CharacterAdded:Connect(function(char)
    Core.Character = char
end)

--// Storage
Core.Modules = {}
Core.Config = {}
Core.Connections = {}

--// Safe Function
function Core.SafeCall(func)
    local success, err = pcall(func)
    if not success then
        warn("Error:", err)
    end
end

--// Loop System
function Core.CreateLoop(name, func)
    if Core.Connections[name] then
        Core.Connections[name]:Disconnect()
    end

    Core.Connections[name] = Core.Services.RunService.Heartbeat:Connect(function()
        Core.SafeCall(func)
    end)
end

--// Stop Loop
function Core.StopLoop(name)
    if Core.Connections[name] then
        Core.Connections[name]:Disconnect()
        Core.Connections[name] = nil
    end
end

return Core