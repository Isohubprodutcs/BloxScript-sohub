-- [[ core.lua ]] --
-- IsoHub Çekirdek Servisleri ve Temel Fonksiyonlar

-- Global bir tablo oluşturuyoruz ki diğer dosyalar kolayca erişebilsin
getgenv().IsoHubCore = {}
local Core = getgenv().IsoHubCore

-- 1. Roblox Temel Servisleri
Core.Players = game:GetService("Players")
Core.RunService = game:GetService("RunService")
Core.Workspace = game:GetService("Workspace")
Core.TweenService = game:GetService("TweenService")
Core.VirtualUser = game:GetService("VirtualUser")
Core.HttpService = game:GetService("HttpService")

-- 2. Temel Değişkenler
Core.LocalPlayer = Core.Players.LocalPlayer
Core.Config = getgenv().IsoHubConfig -- config.lua'dan ayarları çekiyoruz

-- 3. AFK Kalmayı Önleme Sistemi (Oyundan atılmamak için)
-- AutoFarm açıkken karakterin saatlerce oyunda kalmasını sağlar
Core.LocalPlayer.Idled:Connect(function()
    Core.VirtualUser:CaptureController()
    Core.VirtualUser:ClickButton2(Vector2.new())
end)

-- 4. Temel Karakter Fonksiyonu
-- Diğer dosyalar karakterin nerede olduğunu bulmak için bunu kullanacak
Core.GetCharacter = function()
    local character = Core.LocalPlayer.Character or Core.LocalPlayer.CharacterAdded:Wait()
    if character then
        local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
        local humanoid = character:FindFirstChild("Humanoid")
        return character, humanoidRootPart, humanoid
    end
    return nil, nil, nil
end

-- 5. Arayüz (GUI) Kurulum Temeli - IsoHub
Core.SetupGUI = function()
    -- Eğer daha önce açılmış bir IsoHub varsa temizle (Üst üste binmemesi ve bozulmaması için)
    local CoreGuiService = game:GetService("CoreGui")
    if CoreGuiService:FindFirstChild(Core.Config.System.HubName) then
        CoreGuiService:FindFirstChild(Core.Config.System.HubName):Destroy()
    end

    -- Ana Ekran Arayüzünü Oluştur
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = Core.Config.System.HubName
    ScreenGui.ResetOnSpawn = false
    
    -- Exploitlerin çoğu CoreGui'yi destekler, desteklemeyenler için normal PlayerGui'ye atarız
    local success, err = pcall(function()
        ScreenGui.Parent = CoreGuiService
    end)
    if not success then
        ScreenGui.Parent = Core.LocalPlayer:WaitForChild("PlayerGui")
    end

    -- Görsel Bypass Göstergesi (Tasarım Amaçlı)
    if Core.Config.System.VisualBypass then
        local BypassLabel = Instance.new("TextLabel")
        BypassLabel.Name = "BypassStatus"
        BypassLabel.Parent = ScreenGui
        BypassLabel.Size = UDim2.new(0, 250, 0, 30)
        BypassLabel.Position = UDim2.new(0, 20, 0, 20)
        BypassLabel.BackgroundTransparency = 0.3
        BypassLabel.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
        BypassLabel.TextColor3 = Color3.fromRGB(0, 255, 100) -- Hacker Yeşili
        BypassLabel.TextScaled = true
        BypassLabel.Font = Enum.Font.Code
        BypassLabel.Text = "[IsoHub] Anti-Cheat: BYPASSED"
        
        -- Kenarlık ovalliği ekleyelim ki şık dursun
        local UICorner = Instance.new("UICorner")
        UICorner.CornerRadius = UDim.new(0, 5)
        UICorner.Parent = BypassLabel
    end

    return ScreenGui
end

return Core
