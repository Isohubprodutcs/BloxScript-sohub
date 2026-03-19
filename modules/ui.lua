-- [[ IsoHub Notification System - EXTRA ]] --
-- Bu sistem, script bir işlem yaptığında ekranda şık bildirimler gösterir.

local function Notify(title, text, duration)
    local NotifyFrame = Instance.new("Frame")
    local NotifyTitle = Instance.new("TextLabel")
    local NotifyText = Instance.new("TextLabel")
    local NotifyCorner = Instance.new("UICorner")

    NotifyFrame.Name = "NotifyFrame"
    NotifyFrame.Parent = IsoHub_Base
    NotifyFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    NotifyFrame.BorderSizePixel = 0
    NotifyFrame.Position = UDim2.new(1, 10, 1, -100) -- Ekranın sağ dışından başlar
    NotifyFrame.Size = UDim2.new(0, 220, 0, 60)
    NotifyFrame.ZIndex = 10

    NotifyCorner.CornerRadius = UDim.new(0, 6)
    NotifyCorner.Parent = NotifyFrame

    NotifyTitle.Parent = NotifyFrame
    NotifyTitle.BackgroundTransparency = 1
    NotifyTitle.Position = UDim2.new(0, 10, 0, 5)
    NotifyTitle.Size = UDim2.new(1, -20, 0, 20)
    NotifyTitle.Font = Enum.Font.GothamBold
    NotifyTitle.Text = title
    NotifyTitle.TextColor3 = Color3.fromRGB(0, 255, 150) -- Yeşilimsi başlık
    NotifyTitle.TextSize = 14
    NotifyTitle.TextXAlignment = Enum.TextXAlignment.Left

    NotifyText.Parent = NotifyFrame
    NotifyText.BackgroundTransparency = 1
    NotifyText.Position = UDim2.new(0, 10, 0, 25)
    NotifyText.Size = UDim2.new(1, -20, 0, 30)
    NotifyText.Font = Enum.Font.Gotham
    NotifyText.Text = text
    NotifyText.TextColor3 = Color3.fromRGB(255, 255, 255)
    NotifyText.TextSize = 12
    NotifyText.TextWrapped = true
    NotifyText.TextXAlignment = Enum.TextXAlignment.Left

    -- Animasyon: İçeri gir, bekle, dışarı çık
    NotifyFrame:TweenPosition(UDim2.new(1, -230, 1, -100), "Out", "Quad", 0.5, true)
    
    task.delay(duration or 3, function()
        NotifyFrame:TweenPosition(UDim2.new(1, 10, 1, -100), "In", "Quad", 0.5, true)
        task.wait(0.5)
        NotifyFrame:Destroy()
    end)
end

-- Global erişim veriyoruz ki diğer scriptler de kullanabilsin
getgenv().IsoNotify = Notify
-- [[ IsoHub Custom UI Engine ]] --
-- PART 1: Ana Pencere Yapısı ve Sürükleme Mantığı (FULL UNABRIDGED)

local Core = getgenv().IsoHubCore
local Config = getgenv().IsoHubConfig

-- 1. EKRAN GUI OLUŞTURMA (ScreenGui)
-- Menünün oyun ekranında render edilmesi için gereken ana kapsayıcıdır.
local IsoHub_Base = Instance.new("ScreenGui")
IsoHub_Base.Name = "IsoHub_Premium"
IsoHub_Base.Parent = (gethui and gethui()) or game:GetService("CoreGui") or game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
IsoHub_Base.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
IsoHub_Base.ResetOnSpawn = false

-- 2. ANA ÇERÇEVE (Main Frame)
-- Menünün tüm içeriğini, butonlarını ve sekmelerini barındıran ana kutu.
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = IsoHub_Base
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25) -- Koyu ve modern tema
MainFrame.BorderSizePixel = 0
MainFrame.Position = UDim2.new(0.3, 0, 0.3, 0)
MainFrame.Size = UDim2.new(0, 550, 0, 350)
MainFrame.ClipsDescendants = true

-- Köşe Yuvarlatma (UICorner)
local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 8)
MainCorner.Parent = MainFrame

-- 3. ÜST ÇUBUK (Top Bar)
-- Menü başlığının yazdığı ve menünün taşındığı etkileşimli alan.
local TopBar = Instance.new("Frame")
TopBar.Name = "TopBar"
TopBar.Parent = MainFrame
TopBar.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
TopBar.BorderSizePixel = 0
TopBar.Size = UDim2.new(1, 0, 0, 40)

local TopCorner = Instance.new("UICorner")
TopCorner.CornerRadius = UDim.new(0, 8)
TopCorner.Parent = TopBar

-- Başlık Yazısı (Title)
local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Parent = TopBar
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0, 15, 0, 0)
Title.Size = UDim2.new(0, 200, 1, 0)
Title.Font = Enum.Font.GothamBold
Title.Text = "IsoHub | v1.0"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 16
Title.TextXAlignment = Enum.TextXAlignment.Left

-- 4. SÜRÜKLEME SİSTEMİ (Drag Logic)
-- Bu fonksiyon, TopBar'dan tutarak menüyü ekranda serbestçe hareket ettirmeni sağlar.
local function MakeDraggable(gui)
    local dragging
    local dragInput
    local dragStart
    local startPos

    local function update(input)
        local delta = input.Position - dragStart
        gui.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end

    gui.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = gui.Position

            input.Changed:Connect(function()
                if input.UserInputStatus == Enum.UserInputStatus.End then
                    dragging = false
                end
            end)
        end
    end)

    gui.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)

    game:GetService("UserInputService").InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            update(input)
        end
    end)
end

-- Sürükleme özelliğini üst çubuk üzerinden tüm çerçeveye uygula
MakeDraggable(MainFrame)
-- [[ IsoHub Custom UI Engine ]] --
-- PART 2: Yan Menü (Sidebar) ve Sekme Butonları (FULL UNABRIDGED)

-- 1. YAN MENÜ ÇERÇEVESİ (Sidebar)
-- Butonların dizileceği sol taraftaki dikey panel.
local Sidebar = Instance.new("Frame")
Sidebar.Name = "Sidebar"
Sidebar.Parent = MainFrame -- Part 1'de oluşturduğumuz MainFrame
Sidebar.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Sidebar.BorderSizePixel = 0
Sidebar.Position = UDim2.new(0, 0, 0, 40) -- TopBar'ın hemen altından başlar
Sidebar.Size = UDim2.new(0, 150, 1, -40)

local SideCorner = Instance.new("UICorner")
SideCorner.CornerRadius = UDim.new(0, 8)
SideCorner.Parent = Sidebar

-- 2. BUTON LİSTESİ (TabList)
-- Butonların içinde kaydırılabileceği alan.
local TabList = Instance.new("ScrollingFrame")
TabList.Name = "TabList"
TabList.Parent = Sidebar
TabList.Active = true
TabList.BackgroundTransparency = 1
TabList.BorderSizePixel = 0
TabList.Position = UDim2.new(0, 5, 0, 10)
TabList.Size = UDim2.new(1, -10, 1, -20)
TabList.CanvasSize = UDim2.new(0, 0, 0, 0) -- İçerik arttıkça otomatik uzayacak
TabList.ScrollBarThickness = 0

local TabLayout = Instance.new("UIListLayout")
TabLayout.Parent = TabList
TabLayout.SortOrder = Enum.SortOrder.LayoutOrder
TabLayout.Padding = UDim.new(0, 5)

-- 3. İÇERİK ALANI (Container)
-- Butonlara bastığımızda değişen sağ taraftaki ana panel.
local Container = Instance.new("Frame")
Container.Name = "Container"
Container.Parent = MainFrame
Container.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Container.Position = UDim2.new(0, 160, 0, 50)
Container.Size = UDim2.new(1, -170, 1, -60)

local ContainerCorner = Instance.new("UICorner")
ContainerCorner.CornerRadius = UDim.new(0, 6)
ContainerCorner.Parent = Container

-- 4. SEKME OLUŞTURMA SİSTEMİ (CreateTab Function)
-- Bu fonksiyon hem butonu oluşturur hem de o butonun açacağı sayfayı hazırlar.
local Tabs = {}
local FirstTab = true

local function CreateTab(name)
    local TabButton = Instance.new("TextButton")
    local Page = Instance.new("ScrollingFrame")
    
    -- --- BUTON TASARIMI ---
    TabButton.Name = name .. "Tab"
    TabButton.Parent = TabList
    TabButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    TabButton.Size = UDim2.new(1, 0, 0, 35)
    TabButton.Font = Enum.Font.Gotham
    TabButton.Text = "  " .. name
    TabButton.TextColor3 = Color3.fromRGB(200, 200, 200)
    TabButton.TextSize = 14
    TabButton.TextXAlignment = Enum.TextXAlignment.Left
    TabButton.AutoButtonColor = false
    
    local BtnCorner = Instance.new("UICorner")
    BtnCorner.CornerRadius = UDim.new(0, 4)
    BtnCorner.Parent = TabButton
    
    -- --- SAYFA TASARIMI (İçerik Alanı) ---
    Page.Name = name .. "Page"
    Page.Parent = Container
    Page.BackgroundTransparency = 1
    Page.Size = UDim2.new(1, 0, 1, 0)
    Page.Visible = false -- Başlangıçta gizli
    Page.ScrollBarThickness = 2
    Page.BorderSizePixel = 0
    Page.CanvasSize = UDim2.new(0, 0, 0, 0)
    
    local PageLayout = Instance.new("UIListLayout")
    PageLayout.Parent = Page
    PageLayout.SortOrder = Enum.SortOrder.LayoutOrder
    PageLayout.Padding = UDim.new(0, 8)
    
    -- --- SAYFA GEÇİŞ MANTIĞI ---
    TabButton.MouseButton1Click:Connect(function()
        -- Tüm sayfaları gizle
        for _, v in pairs(Container:GetChildren()) do
            if v:IsA("ScrollingFrame") then v.Visible = false end
        end
        -- Tüm buton renklerini sıfırla
        for _, v in pairs(TabList:GetChildren()) do
            if v:IsA("TextButton") then 
                v.BackgroundColor3 = Color3.fromRGB(40, 40, 40) 
                v.TextColor3 = Color3.fromRGB(200, 200, 200)
            end
        end
        -- Sadece tıklananı göster ve rengini değiştir
        Page.Visible = true
        TabButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
        TabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    end)
    
    -- İlk sekmeyi otomatik aktif yap
    if FirstTab then
        Page.Visible = true
        TabButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
        TabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        FirstTab = false
    end
    
    return Page
end

-- 5. SAYFALARI TANIMLAMA
-- Hazırladığımız modüllere göre sekmelerimizi açıyoruz.
local FarmPage = CreateTab("Main Farm")
local StatsPage = CreateTab("Auto Stats")
local TeleportPage = CreateTab("Teleport")
local VisualsPage = CreateTab("Visuals")
local SettingsPage = CreateTab("Settings")
-- [[ IsoHub Custom UI Engine ]] --
-- PART 3: Element Oluşturma Fonksiyonları (Toggle, Button, Label)

-- 1. TOGGLE (Aç/Kapa Butonu) SİSTEMİ
-- Bu fonksiyon, ayarların (Auto Farm vb.) açılıp kapanmasını sağlar ve görsel geri bildirim verir.
function Tabs:CreateToggle(parentPage, text, configPath, callback)
    local ToggleFrame = Instance.new("Frame")
    local ToggleBtn = Instance.new("TextButton")
    local ToggleCircle = Instance.new("Frame")
    local ToggleTitle = Instance.new("TextLabel")
    
    ToggleFrame.Name = text .. "_Toggle"
    ToggleFrame.Parent = parentPage
    ToggleFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    ToggleFrame.Size = UDim2.new(1, -10, 0, 40)
    
    local TFCorner = Instance.new("UICorner")
    TFCorner.CornerRadius = UDim.new(0, 6)
    TFCorner.Parent = ToggleFrame
    
    ToggleTitle.Parent = ToggleFrame
    ToggleTitle.BackgroundTransparency = 1
    ToggleTitle.Position = UDim2.new(0, 10, 0, 0)
    ToggleTitle.Size = UDim2.new(0, 200, 1, 0)
    ToggleTitle.Font = Enum.Font.Gotham
    ToggleTitle.Text = text
    ToggleTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
    ToggleTitle.TextSize = 14
    ToggleTitle.TextXAlignment = Enum.TextXAlignment.Left
    
    ToggleBtn.Parent = ToggleFrame
    ToggleBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    ToggleBtn.Position = UDim2.new(1, -50, 0.5, -10)
    ToggleBtn.Size = UDim2.new(0, 40, 0, 20)
    ToggleBtn.Text = ""
    
    local TBCorner = Instance.new("UICorner")
    TBCorner.CornerRadius = UDim.new(1, 0)
    TBCorner.Parent = ToggleBtn
    
    ToggleCircle.Parent = ToggleBtn
    ToggleCircle.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
    ToggleCircle.Position = UDim2.new(0, 2, 0.5, -8)
    ToggleCircle.Size = UDim2.new(0, 16, 0, 16)
    
    local TCCorner = Instance.new("UICorner")
    TCCorner.CornerRadius = UDim.new(1, 0)
    TCCorner.Parent = ToggleCircle

    -- --- MANTIK VE ANİMASYON ---
    local enabled = configPath or false
    
    local function UpdateToggle()
        if enabled then
            -- Açık Durumu (Yeşil Animasyon)
            game:GetService("TweenService"):Create(ToggleBtn, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(0, 200, 100)}):Play()
            game:GetService("TweenService"):Create(ToggleCircle, TweenInfo.new(0.3), {Position = UDim2.new(1, -18, 0.5, -8)}):Play()
        else
            -- Kapalı Durumu (Gri Animasyon)
            game:GetService("TweenService"):Create(ToggleBtn, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(50, 50, 50)}):Play()
            game:GetService("TweenService"):Create(ToggleCircle, TweenInfo.new(0.3), {Position = UDim2.new(0, 2, 0.5, -8)}):Play()
        end
    end
    
    UpdateToggle() -- Mevcut Config değerine göre ilk durumu ayarla

    ToggleBtn.MouseButton1Click:Connect(function()
        enabled = not enabled
        UpdateToggle()
        if callback then callback(enabled) end
    end)
end

-- 2. BUTTON (Klasik Tıklanabilir Buton) SİSTEMİ
-- Işınlanma, menü kapatma gibi anlık işlemler için kullanılır.
function Tabs:CreateButton(parentPage, text, callback)
    local Button = Instance.new("TextButton")
    
    Button.Name = text .. "_Button"
    Button.Parent = parentPage
    Button.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    Button.Size = UDim2.new(1, -10, 0, 35)
    Button.Font = Enum.Font.GothamBold
    Button.Text = text
    Button.TextColor3 = Color3.fromRGB(255, 255, 255)
    Button.TextSize = 14
    Button.AutoButtonColor = true
    
    local BCorner = Instance.new("UICorner")
    BCorner.CornerRadius = UDim.new(0, 6)
    BCorner.Parent = Button
    
    Button.MouseButton1Click:Connect(function()
        -- Tıklama Efekti (Hafif küçülme simülasyonu)
        Button:TweenSize(UDim2.new(1, -15, 0, 32), "Out", "Quad", 0.1, true)
        task.wait(0.1)
        Button:TweenSize(UDim2.new(1, -10, 0, 35), "Out", "Quad", 0.1, true)
        
        if callback then callback() end
    end)
end

-- 3. LABEL (Bilgi ve Başlık Yazısı) SİSTEMİ
-- Menü içinde açıklamalar ve kategoriler oluşturmak için kullanılır.
function Tabs:CreateLabel(parentPage, text)
    local Label = Instance.new("TextLabel")
    Label.Parent = parentPage
    Label.BackgroundTransparency = 1
    Label.Size = UDim2.new(1, -10, 0, 25)
    Label.Font = Enum.Font.Gotham
    Label.Text = "  " .. text
    Label.TextColor3 = Color3.fromRGB(180, 180, 180)
    Label.TextSize = 13
    Label.TextXAlignment = Enum.TextXAlignment.Left
end
-- [[ IsoHub Custom UI Engine ]] --
-- PART 4: Sayfa İçeriklerini Doldurma ve Config Bağlantıları (FULL UNABRIDGED)

-- [[ 1. MAIN FARM SAYFASI ]] --
-- Otomatik kasılma ve görev alma ayarları burada toplanır.
Tabs:CreateLabel(FarmPage, "Main Farming Options")

Tabs:CreateToggle(FarmPage, "Auto Farm Level", Config.AutoFarm.Enabled, function(state)
    Config.AutoFarm.Enabled = state
    if not state then
        getgenv().IsoHubTween.Stop() -- Farm kapatıldığında uçuşu durdur
    end
end)

Tabs:CreateToggle(FarmPage, "Auto Quest", Config.AutoFarm.AutoQuest, function(state)
    Config.AutoFarm.AutoQuest = state
end)

Tabs:CreateToggle(FarmPage, "Bring Mobs (Fast Farm)", Config.AutoFarm.BringMobs, function(state)
    Config.AutoFarm.BringMobs = state
end)

Tabs:CreateLabel(FarmPage, "Combat Settings")

Tabs:CreateButton(FarmPage, "Set Weapon: Melee (Combat)", function()
    Config.Combat.SelectWeapon = "Melee"
    print("[IsoHub] Silah Seçildi: Melee")
end)

Tabs:CreateButton(FarmPage, "Set Weapon: Sword", function()
    Config.Combat.SelectWeapon = "Sword"
    print("[IsoHub] Silah Seçildi: Sword")
end)

Tabs:CreateToggle(FarmPage, "Auto Click / Attack", Config.Combat.AutoClick, function(state)
    Config.Combat.AutoClick = state
end)

-- [[ 2. AUTO STATS SAYFASI ]] --
-- Seviye atladığında puanların otomatik dağıtılacağı yer.
Tabs:CreateLabel(StatsPage, "Point Allocation Settings")

Tabs:CreateToggle(StatsPage, "Enable Auto Stats", Config.AutoStats.Enabled, function(state)
    Config.AutoStats.Enabled = state
end)

Tabs:CreateLabel(StatsPage, "Select Focus (Puan Nereye Verilsin?)")

Tabs:CreateToggle(StatsPage, "Melee", Config.AutoStats.Focus.Melee, function(state)
    Config.AutoStats.Focus.Melee = state
end)

Tabs:CreateToggle(StatsPage, "Defense", Config.AutoStats.Focus.Defense, function(state)
    Config.AutoStats.Focus.Defense = state
end)

Tabs:CreateToggle(StatsPage, "Blox Fruit", Config.AutoStats.Focus.BloxFruit, function(state)
    Config.AutoStats.Focus.BloxFruit = state
end)

-- [[ 3. TELEPORT SAYFASI ]] --
-- Dünyalar arası hızlı geçiş butonları.
Tabs:CreateLabel(TeleportPage, "World Teleports (Sea Travel)")

Tabs:CreateButton(TeleportPage, "Teleport to Sea 1", function()
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TravelMain")
end)

Tabs:CreateButton(TeleportPage, "Teleport to Sea 2", function()
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TravelDressrosa")
end)

Tabs:CreateButton(TeleportPage, "Teleport to Sea 3", function()
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TravelZou")
end)

-- [[ 4. SETTINGS SAYFASI ]] --
-- Menü ve sistem ayarları.
Tabs:CreateLabel(SettingsPage, "UI and System Management")

Tabs:CreateButton(SettingsPage, "Destroy IsoHub (Unload)", function()
    IsoHub_Base:Destroy() -- Menüyü ve GUI'yi tamamen siler
end)

Tabs:CreateLabel(SettingsPage, "Shortcut: Press 'RightControl' to Hide UI")

-- [[ 5. KLAVYE KISAYOLU (Show/Hide Menu) ]] --
-- Klavyeden 'RightControl' tuşuna basıldığında menü görünmez olur veya geri gelir.
game:GetService("UserInputService").InputBegan:Connect(function(input, isProcessed)
    if not isProcessed then
        if input.KeyCode == Enum.KeyCode.RightControl then
            MainFrame.Visible = not MainFrame.Visible
        end
    end
end)
-- [[ IsoHub Auto-Save System - EXTRA ]] --
local HttpService = game:GetService("HttpService")

local function SaveSettings()
    local json = HttpService:JSONEncode(Config)
    writefile("IsoHub_Config.json", json)
end

local function LoadSettings()
    if isfile("IsoHub_Config.json") then
        local json = readfile("IsoHub_Config.json")
        local data = HttpService:JSONDecode(json)
        -- Config'i yüklenen veriyle güncelle
        for i, v in pairs(data) do
            Config[i] = v
        end
        print("[IsoHub] Ayarlar başarıyla yüklendi!")
    end
end

-- Ayarları yükle ve her buton değişiminde kaydetmesi için bağla
LoadSettings()

-- ÖNEMLİ: Toggle fonksiyonunun içine 'SaveSettings()' eklemelisin!
-- (Önceki posttaki Toggle callback'lerinin sonuna SaveSettings() eklenecek)
-- --- SİSTEMİ DIŞARI AKTAR VE BİTİR ---
print("[IsoHub] UI Engine Loaded Successfully. Enjoy!")
return IsoHub_Base
