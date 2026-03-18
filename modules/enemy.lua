local Enemy = {}

function Enemy.GetNearest(Core, name)
    local closest = nil
    local distance = math.huge

    for _, v in pairs(workspace.Enemies:GetChildren()) do
        if v.Name == name and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
            local mag = (Core.Character.HumanoidRootPart.Position - v.HumanoidRootPart.Position).Magnitude

            if mag < distance then
                distance = mag
                closest = v
            end
        end
    end

    return closest
end

return Enemy