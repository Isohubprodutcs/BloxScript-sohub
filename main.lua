-- [[ IsoHub Module Loader ]] --
local function LoadIsoModule(url)
    local success, result = pcall(function()
        return game:HttpGet(url)
    end)
    if success then
        local func, err = loadstring(result)
        if func then
            return func()
        else
            warn("[IsoHub] Kod Hatası: " .. url .. " | Hata: " .. tostring(err))
        end
    else
        warn("[IsoHub] Bağlantı Hatası: " .. url)
    end
end

-- Modülleri Sırasıyla Yüklüyoruz (Sıralama Önemli!)
LoadIsoModule("https://raw.githubusercontent.com/Isohubprodutcs/BloxScript-sohub/refs/heads/main/config.lua")
LoadIsoModule("https://raw.githubusercontent.com/Isohubprodutcs/BloxScript-sohub/refs/heads/main/core.lua")
LoadIsoModule("https://raw.githubusercontent.com/Isohubprodutcs/BloxScript-sohub/refs/heads/main/modules/tween.lua")
LoadIsoModule("https://raw.githubusercontent.com/Isohubprodutcs/BloxScript-sohub/refs/heads/main/modules/enemy.lua")
LoadIsoModule("https://raw.githubusercontent.com/Isohubprodutcs/BloxScript-sohub/refs/heads/main/modules/autoquest.lua")
LoadIsoModule("https://raw.githubusercontent.com/Isohubprodutcs/BloxScript-sohub/refs/heads/main/modules/autofarm.lua")
LoadIsoModule("https://raw.githubusercontent.com/Isohubprodutcs/BloxScript-sohub/refs/heads/main/modules/autostats.lua")

local Core = getgenv().IsoHubCore
local Config = getgenv().IsoHubConfig

-- 1. Arayüzü Başlat ve Temizle
local ScreenGui = Core.SetupGUI()

-- Sürükleme (Draggable) Fonksiyonu - PC ve Mobil Uyumlu
local function MakeDraggable(topbarobject, object)
    local UserInputService = game:GetService("UserInputService")
    local dragging = false
    local dragInput, mousePos, framePos

    topbarobject.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            mousePos = input.Position
            framePos = object.Position

            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    topbarobject.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - mousePos
            object.Position = UDim2.new(framePos.X.Scale, framePos.X.Offset + delta.X, framePos.Y.Scale, framePos.Y.Offset + delta.Y)
        end
    end)
end

-- 2. Mobil ve PC İçin Ekranda Duran "IsoHub Aç/Kapat" Butonu
local MobileToggleBtn = Instance.new("TextButton")
MobileToggleBtn.Name = "MobileToggle"
MobileToggleBtn.Parent = ScreenGui
MobileToggleBtn.Size = UDim2.new(0, 50, 0, 50)
MobileToggleBtn.Position = UDim2.new(0, 20, 0, 80) -- Sol üst köşede Bypass yazısının altına
MobileToggleBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MobileToggleBtn.BorderColor3 = Color3.fromRGB(0, 255, 100)
MobileToggleBtn.BorderSizePixel = 2
MobileToggleBtn.Text = "ISO"
MobileToggleBtn.TextColor3 = Color3.fromRGB(0, 255, 100)
MobileToggleBtn.Font = Enum.Font.Code
MobileToggleBtn.TextSize = 20
MobileToggleBtn.Visible = Config.System.MobileToggle -- Config'den mobil açık mı diye bakar

local ToggleCorner = Instance.new("UICorner")
ToggleCorner.CornerRadius = UDim.new(1, 0) -- Tam yuvarlak buton
ToggleCorner.Parent = MobileToggleBtn

MakeDraggable(MobileToggleBtn, MobileToggleBtn) -- Butonu ekranda sürüklenebilir yap

-- 3. Ana Menü Penceresi (Main Frame)
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.Size = UDim2.new(0, 500, 0, 350)
MainFrame.Position = UDim2.new(0.5, -250, 0.5, -175) -- Ekranın tam ortası
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
MainFrame.BorderSizePixel = 0
MainFrame.Visible = false -- Başlangıçta kapalı, butona basınca açılacak

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 8)
MainCorner.Parent = MainFrame

-- Ana Pencere Üst Barı (Sürüklemek için)
local TopBar = Instance.new("Frame")
TopBar.Name = "TopBar"
TopBar.Parent = MainFrame
TopBar.Size = UDim2.new(1, 0, 0, 30)
TopBar.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
TopBar.BorderSizePixel = 0

local TopCorner = Instance.new("UICorner")
TopCorner.CornerRadius = UDim.new(0, 8)
TopCorner.Parent = TopBar

-- Alt köşelerin de yuvarlak kalmasını sağlamak için ufak bir düzeltme çerçevesi
local TopBarFix = Instance.new("Frame")
TopBarFix.Size = UDim2.new(1, 0, 0, 10)
TopBarFix.Position = UDim2.new(0, 0, 1, -10)
TopBarFix.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
TopBarFix.BorderSizePixel = 0
TopBarFix.Parent = TopBar

local Title = Instance.new("TextLabel")
Title.Parent = TopBar
Title.Size = UDim2.new(1, -10, 1, 0)
Title.Position = UDim2.new(0, 10, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = Config.System.HubName .. " - Blox Fruits Premium"
Title.TextColor3 = Color3.fromRGB(0, 255, 100)
Title.Font = Enum.Font.Code
Title.TextSize = 16
Title.TextXAlignment = Enum.TextXAlignment.Left

MakeDraggable(TopBar, MainFrame) -- Üst bardan tutarak menüyü sürükleyebilme

-- Menüyü Açma/Kapama İşlemi (Mobil Butonu için)
MobileToggleBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

-- Menüyü Açma/Kapama İşlemi (PC Klavyesi için)
local UserInputService = game:GetService("UserInputService")
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed and input.KeyCode == Enum.KeyCode[Config.System.ToggleKey] then
        MainFrame.Visible = not MainFrame.Visible
    end
end)
-- [[ main.lua ]] -- BÖLÜM 2
-- IsoHub Menü İçi Butonlar ve Modül Bağlantıları

local Config = getgenv().IsoHubConfig

-- 4. İçerik Alanı (ScrollingFrame - Sayfa kaydırılabilir alan)
local ContentArea = Instance.new("ScrollingFrame")
ContentArea.Name = "ContentArea"
ContentArea.Parent = MainFrame
ContentArea.Size = UDim2.new(1, -20, 1, -50)
ContentArea.Position = UDim2.new(0, 10, 0, 40)
ContentArea.BackgroundTransparency = 1
ContentArea.BorderSizePixel = 0
ContentArea.ScrollBarThickness = 4
ContentArea.ScrollBarImageColor3 = Color3.fromRGB(0, 255, 100)

local ListLayout = Instance.new("UIListLayout")
ListLayout.Parent = ContentArea
ListLayout.SortOrder = Enum.SortOrder.LayoutOrder
ListLayout.Padding = UDim.new(0, 5)

-- UI Elemanı Oluşturma Fonksiyonu (Daha temiz kod için şablon)
local function CreateToggle(name, defaultState, callback)
    local ToggleBtn = Instance.new("TextButton")
    ToggleBtn.Parent = ContentArea
    ToggleBtn.Size = UDim2.new(1, 0, 0, 35)
    ToggleBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    ToggleBtn.BorderSizePixel = 0
    ToggleBtn.Text = "   " .. name .. " : " .. (defaultState and "AÇIK" or "KAPALI")
    ToggleBtn.TextColor3 = defaultState and Color3.fromRGB(0, 255, 100) or Color3.fromRGB(255, 50, 50)
    ToggleBtn.Font = Enum.Font.Code
    ToggleBtn.TextSize = 14
    ToggleBtn.TextXAlignment = Enum.TextXAlignment.Left

    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 5)
    UICorner.Parent = ToggleBtn

    local state = defaultState
    ToggleBtn.MouseButton1Click:Connect(function()
        state = not state
        ToggleBtn.Text = "   " .. name .. " : " .. (state and "AÇIK" or "KAPALI")
        ToggleBtn.TextColor3 = state and Color3.fromRGB(0, 255, 100) or Color3.fromRGB(255, 50, 50)
        callback(state)
    end)
    return ToggleBtn
end

local function CreateCycleButton(name, options, defaultIndex, callback)
    local Btn = Instance.new("TextButton")
    Btn.Parent = ContentArea
    Btn.Size = UDim2.new(1, 0, 0, 35)
    Btn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    Btn.BorderSizePixel = 0
    
    local currentIndex = defaultIndex
    Btn.Text = "   " .. name .. " : " .. options[currentIndex]
    Btn.TextColor3 = Color3.fromRGB(200, 200, 200)
    Btn.Font = Enum.Font.Code
    Btn.TextSize = 14
    Btn.TextXAlignment = Enum.TextXAlignment.Left

    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 5)
    UICorner.Parent = Btn

    Btn.MouseButton1Click:Connect(function()
        currentIndex = currentIndex + 1
        if currentIndex > #options then currentIndex = 1 end
        Btn.Text = "   " .. name .. " : " .. options[currentIndex]
        callback(options[currentIndex])
    end)
    return Btn
end

-- 5. Menüye Özellikleri ve Butonları Ekliyoruz

-- Silah Seçimi
local weapons = {"Melee", "Sword", "Demon Fruit"}
CreateCycleButton("Silah Seç", weapons, 1, function(selected)
    Config.Combat.SelectWeapon = selected
end)

-- Oto Görev (Auto Quest)
CreateToggle("Auto Quest (Oto Görev)", Config.AutoFarm.AutoQuest, function(state)
    Config.AutoFarm.AutoQuest = state
end)

-- Moblari Bir Yere Toplama (Bring Mobs)
CreateToggle("Bring Mobs (Yaratıkları Topla)", Config.AutoFarm.BringMobs, function(state)
    Config.AutoFarm.BringMobs = state
end)

-- Hızlı Vuruş (Fast Attack)
CreateToggle("Fast Attack (Hızlı Vuruş)", Config.AutoFarm.FastAttack, function(state)
    Config.AutoFarm.FastAttack = state
end)

-- ANA ŞALTER: Auto Farm
CreateToggle("AUTO FARM BAŞLAT", Config.AutoFarm.Enabled, function(state)
    Config.AutoFarm.Enabled = state
    Config.Combat.AutoClick = state -- Vuruşu da farm ile eşzamanlı başlat/kapat
end)

-- Oto Stat: Sadece Melee ve Defense Örneği
CreateToggle("Auto Stats (Melee)", Config.AutoStats.Focus.Melee, function(state)
    Config.AutoStats.Enabled = true
    Config.AutoStats.Focus.Melee = state
end)

CreateToggle("Auto Stats (Defense)", Config.AutoStats.Focus.Defense, function(state)
    Config.AutoStats.Enabled = true
    Config.AutoStats.Focus.Defense = state
end)

-- Liste içindeki eleman sayısına göre kaydırma alanını otomatik ayarla
ContentArea.CanvasSize = UDim2.new(0, 0, 0, ListLayout.AbsoluteContentSize.Y + 10)
ListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    ContentArea.CanvasSize = UDim2.new(0, 0, 0, ListLayout.AbsoluteContentSize.Y + 10)
end)

-- Modüllerin Yüklendiğini Belirten Sistem Mesajı (Sadece F9 basınca görünür)
print("[IsoHub] Tüm sistemler başarıyla yüklendi! Arayüz aktif.")
