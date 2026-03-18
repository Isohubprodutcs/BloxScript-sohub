local Tween = {}

function Tween.MoveTo(Core, position)
    local char = Core.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end

    local hrp = char.HumanoidRootPart

    local distance = (hrp.Position - position).Magnitude
    local speed = Core.Config.TweenSpeed or 300
    local time = distance / speed

    local tween = Core.Services.TweenService:Create(
        hrp,
        TweenInfo.new(time, Enum.EasingStyle.Linear),
        {CFrame = CFrame.new(position)}
    )

    tween:Play()
end

return Tween