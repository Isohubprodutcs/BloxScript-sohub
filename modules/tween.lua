-- [[ tween.lua ]] --
-- IsoHub Hareket ve Uçuş Motoru (Blox Fruits İçin Optimize Edildi)

getgenv().IsoHubTween = {}
local Tween = getgenv().IsoHubTween
local Core = getgenv().IsoHubCore

Tween.ActiveTween = nil
Tween.NoclipConnection = nil

-- 1. Noclip (Duvarlardan Geçme) Sistemi
-- Uçarken binalara veya adalara takılmamayı sağlar
Tween.StartNoclip = function()
    if Tween.NoclipConnection then return end
    
    Tween.NoclipConnection = Core.RunService.Stepped:Connect(function()
        local char = Core.LocalPlayer.Character
        if char then
            for _, part in pairs(char:GetChildren()) do
                if part:IsA("BasePart") and part.CanCollide == true then
                    part.CanCollide = false
                end
            end
        end
    end)
end

Tween.StopNoclip = function()
    if Tween.NoclipConnection then
        Tween.NoclipConnection:Disconnect()
        Tween.NoclipConnection = nil
    end
end

-- 2. Ana Uçuş (Tween) Fonksiyonu
Tween.FlyTo = function(targetCFrame)
    local char, hrp, hum = Core.GetCharacter()
    if not char or not hrp or not hum then return end

    -- Uçarken yerçekiminin karakteri aşağı çekmesini engellemek için sabitleyici ekliyoruz
    if not hrp:FindFirstChild("TweenFloat") then
        local float = Instance.new("BodyVelocity")
        float.Name = "TweenFloat"
        float.Velocity = Vector3.new(0, 0, 0)
        float.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
        float.Parent = hrp
    end

    -- Mesafeyi ve zamanı hesaplıyoruz ki anti-cheat yakalamasın
    local distance = (hrp.Position - targetCFrame.Position).Magnitude
    local speed = 300 -- Blox Fruits için güvenli uçuş hızı
    local timeToTravel = distance / speed

    local tweenInfo = TweenInfo.new(
        timeToTravel,
        Enum.EasingStyle.Linear, -- Dümdüz, sabit hızla uçuş
        Enum.EasingDirection.Out,
        0,
        false,
        0
    )

    -- Eğer zaten uçuyorsak eski rotayı iptal et
    if Tween.ActiveTween then
        Tween.ActiveTween:Cancel()
    end

    -- Duvarlardan geçmeyi aç ve uçuşu başlat
    Tween.StartNoclip()
    Tween.ActiveTween = Core.TweenService:Create(hrp, tweenInfo, {CFrame = targetCFrame})
    Tween.ActiveTween:Play()

    -- Uçuş bittiğinde veya iptal edildiğinde normale dön
    Tween.ActiveTween.Completed:Connect(function()
        Tween.StopNoclip()
        if hrp:FindFirstChild("TweenFloat") then
            hrp:FindFirstChild("TweenFloat"):Destroy()
        end
    end)
end

-- 3. Uçuşu Acil Durdurma Fonksiyonu
Tween.Stop = function()
    if Tween.ActiveTween then
        Tween.ActiveTween:Cancel()
    end
    Tween.StopNoclip()
    
    local char, hrp, hum = Core.GetCharacter()
    if hrp and hrp:FindFirstChild("TweenFloat") then
        hrp:FindFirstChild("TweenFloat"):Destroy()
    end
end

return Tween
