-- [[ autofarm.lua ]] --
-- IsoHub NPC İmha ve Otomatik Kasılma Motoru (FULL UNABRIDGED - PART 1)

getgenv().IsoHubAutoFarm = {}
local AutoFarm = getgenv().IsoHubAutoFarm

-- Modül Bağlantıları (Hiçbiri eksiltilmedi)
local Core = getgenv().IsoHubCore
local Config = getgenv().IsoHubConfig
local Tween = getgenv().IsoHubTween
local Enemy = getgenv().IsoHubEnemy
local Quest = getgenv().IsoHubQuest

-- 1. SİLAHI ELE ALMA SİSTEMİ (EN DETAYLI HALİ)
AutoFarm.EquipWeapon = function()
    local char, hrp, hum = Core.GetCharacter()
    if not char or not hum then return end

    local selectedWeaponType = Config.Combat.SelectWeapon -- Melee, Sword, Blox Fruit
    local backpack = Core.LocalPlayer:FindFirstChild("Backpack")
    
    -- Önce karakterin elinde zaten o silah var mı diye bak
    local currentTool = char:FindFirstChildOfClass("Tool")
    if currentTool and (currentTool.ToolTip == selectedWeaponType or string.find(currentTool.Name, selectedWeaponType)) then
        return -- Zaten elinde, bir şey yapma
    end

    -- Eğer elde değilse Backpack (çanta) içinde ara
    if backpack then
        local tools = backpack:GetChildren()
        for i = 1, #tools do
            local tool = tools[i]
            if tool:IsA("Tool") then
                -- Silahın hem tipine (ToolTip) hem de ismine bakarak doğrula
                if tool.ToolTip == selectedWeaponType or string.find(tool.Name, selectedWeaponType) then
                    hum:EquipTool(tool)
                    break
                end
            end
        end
    end
end
-- [[ 2. SALDIRI VE TIKLAMA SİSTEMİ (PC & Mobil Hibrit - FULL UNABRIDGED) ]] --
-- Bu fonksiyon, Config'deki ayarlara göre hem PC hem mobil vuruşlarını tetikler.

AutoFarm.Attack = function()
    -- Sadece AutoClick ayarı açıksa işlem yap
    if Config.Combat.AutoClick == true then
        
        -- A) PC Kullanıcıları İçin: VirtualUser kullanarak mouse tıklaması simüle eder.
        pcall(function()
            local virtualUser = game:GetService("VirtualUser")
            virtualUser:CaptureController()
            virtualUser:ClickButton1(Vector2.new(0,0))
        end)
        
        -- B) Mobil ve Genel Kullanıcılar İçin: Eldeki eşyayı (Tool) doğrudan aktive eder.
        local playerChar = game:GetService("Players").LocalPlayer.Character
        if playerChar then
            local currentTool = playerChar:FindFirstChildOfClass("Tool")
            if currentTool then
                currentTool:Activate()
            end
        end

        -- C) OTOMATİK SKİLL (YETENEK) KULLANIM SİSTEMİ
        -- Her yetenek tuşu (Z, X, C, V) ayrı ayrı kontrol edilir ve tetiklenir.
        
        -- Z Yeteneği
        if Config.Combat.AutoSkills.Z == true then
            pcall(function()
                game:GetService("VirtualUser"):SetKeyDown("z")
                task.wait(0.05)
                game:GetService("VirtualUser"):SetKeyUp("z")
            end)
        end
        
        -- X Yeteneği
        if Config.Combat.AutoSkills.X == true then
            pcall(function()
                game:GetService("VirtualUser"):SetKeyDown("x")
                task.wait(0.05)
                game:GetService("VirtualUser"):SetKeyUp("x")
            end)
        end
        
        -- C Yeteneği
        if Config.Combat.AutoSkills.C == true then
            pcall(function()
                game:GetService("VirtualUser"):SetKeyDown("c")
                task.wait(0.05)
                game:GetService("VirtualUser"):SetKeyUp("c")
            end)
        end
        
        -- V Yeteneği
        if Config.Combat.AutoSkills.V == true then
            pcall(function()
                game:GetService("VirtualUser"):SetKeyDown("v")
                task.wait(0.05)
                game:GetService("VirtualUser"):SetKeyUp("v")
            end)
        end
    end
end

-- [[ 3. FARM POZİSYONU HESAPLAMA MOTORU ]] --
-- Karakterin moba göre hangi açıda duracağını belirleyen CFrame motoru.

AutoFarm.GetFarmPosition = function(targetHrp)
    -- Config'den mesafe ve pozisyon tipini çekiyoruz
    local distance = Config.AutoFarm.Distance -- Genellikle 8-10 stud idealdir
    local mode = Config.AutoFarm.Position     -- "Above", "Behind", "Under"
    local targetCFrame = targetHrp.CFrame

    -- Seçilen moda göre matematiksel koordinat döndürülür
    if mode == "Above" then
        -- Mobun üstünde durur ve aşağıya doğru rotasyon verir (math.rad(-90))
        return targetCFrame * CFrame.new(0, distance, 0) * CFrame.Angles(math.rad(-90), 0, 0)
    
    elseif mode == "Behind" then
        -- Mobun tam arkasında durur
        return targetCFrame * CFrame.new(0, 0, distance)
    
    elseif mode == "Under" then
        -- Mobun tam altında durur ve yukarıya doğru rotasyon verir (math.rad(90))
        return targetCFrame * CFrame.new(0, -distance, 0) * CFrame.Angles(math.rad(90), 0, 0)
    
    else
        -- Eğer hiçbir mod seçilmediyse veya hata varsa varsayılan "Above" modunu kullan
        return targetCFrame * CFrame.new(0, distance, 0) * CFrame.Angles(math.rad(-90), 0, 0)
    end
end
-- [[ 4. BRING MOBS (Yaratıkları Tek Noktaya Toplama Sistemi) ]] --
-- Bu özellik, ana hedefinin etrafındaki tüm aynı tür mobları tek bir noktaya ışınlar.
-- Böylece tek bir kılıç darbesiyle 5-10 yaratığa birden hasar verirsin.

AutoFarm.BringMobs = function(mainTargetHrp)
    -- Sadece BringMobs ayarı açıksa işlem yap
    if Config.AutoFarm.BringMobs == true then
        local targetMobName = Config.AutoFarm.TargetMob
        
        -- Hedef ismini temizleyerek arama yap (Seviye yazılarını dikkate alma)
        local cleanTargetName = targetMobName:gsub(" %s*[%d+]", ""):gsub(" %s*%(%d+%)", ""):gsub(" %s*%[.*%]", "")
        
        -- Arama yapılacak klasörler
        local folders = {game:GetService("Workspace"):FindFirstChild("Enemies"), game:GetService("Workspace")}
        
        for _, folder in pairs(folders) do
            if folder then
                local allMobs = folder:GetChildren()
                for i = 1, #allMobs do
                    local mob = allMobs[i]
                    
                    -- Eğer mob bir Model ise ve ismi bizim hedefimize benziyorsa
                    if mob:IsA("Model") and (mob.Name == targetMobName or string.find(mob.Name, cleanTargetName)) then
                        local mobHrp = mob:FindFirstChild("HumanoidRootPart")
                        local mobHum = mob:FindFirstChild("Humanoid")
                        
                        -- Mob yaşıyorsa ve ana hedefe yeterince yakınsa (300 stud idealdir)
                        if mobHrp and mobHum and mobHum.Health > 0 then
                            local distToMain = (mobHrp.Position - mainTargetHrp.Position).Magnitude
                            
                            if distToMain < 300 then
                                -- Mobu ana hedefin tam üstüne ışınla
                                mobHrp.CFrame = mainTargetHrp.CFrame
                                mobHrp.CanCollide = false -- Çarpışmayı kapat ki karakterin sekmesin
                                
                                -- Mobun aşağı düşmesini veya uçup gitmesini engellemek için Velocity ekle
                                if mobHrp:FindFirstChild("IsoBodyVelocity") == nil then
                                    local bv = Instance.new("BodyVelocity")
                                    bv.Name = "IsoBodyVelocity"
                                    bv.Velocity = Vector3.new(0, 0, 0)
                                    bv.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
                                    bv.Parent = mobHrp
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end

-- [[ 5. ANA AUTO FARM DÖNGÜSÜ (ORKESTRA ŞEFİ) ]] --
-- Bu döngü sürekli çalışır ve ayarlar açıksa yukarıdaki tüm fonksiyonları sırasıyla tetikler.

task.spawn(function()
    while true do
        task.wait() -- Döngüyü çok hızlı çalıştırıp oyunu dondurmamak için bekleme
        
        -- ŞART 1: Eğer Auto Farm butonu menüden açıksa
        if Config.AutoFarm.Enabled == true then
            
            -- ŞART 2: Otomatik Görev Sistemi (Auto Quest) aktifse
            if Config.AutoFarm.AutoQuest == true then
                
                -- Eğer şu an bir görevimiz yoksa gidip görev almayı dene
                if Quest.HasQuest() == false then
                    Quest.TakeQuest()
                    task.wait(1)
                    -- Görevi alana kadar aşağıdaki saldırı kodlarına geçme
                else
                    -- Görevimiz varsa, görev verisindeki yaratık ismini hedef olarak ayarla
                    local currentQuest = Quest.GetCurrentQuestData()
                    if currentQuest ~= nil then
                        Config.AutoFarm.TargetMob = currentQuest.MobName
                    end
                end
            end
            
            -- ŞART 3: Haritada hedefimizi arıyoruz
            local targetMob = Enemy.GetTarget()

            if targetMob ~= nil then
                local tHrp = targetMob:FindFirstChild("HumanoidRootPart")
                local tHum = targetMob:FindFirstChild("Humanoid")

                -- Hedef fiziksel olarak oradaysa ve yaşıyorsa savaşı başlat
                if tHrp ~= nil and tHum ~= nil and tHum.Health > 0 then
                    
                    -- ADIM 1: Silahı kuşan (Melee, Sword vb.)
                    AutoFarm.EquipWeapon()

                    -- ADIM 2: Hedefin yanına (Üstüne/Altına/Arkasına) uç
                    local targetPosition = AutoFarm.GetFarmPosition(tHrp)
                    Tween.FlyTo(targetPosition)

                    -- ADIM 3: Etraftaki diğer mobları ana hedefin üstüne çek
                    AutoFarm.BringMobs(tHrp)

                    -- ADIM 4: Mesafe kontrolü yap ve saldır (Çok uzaktayken vurma)
                    local char, pHrp, pHum = Core.GetCharacter()
                    if pHrp ~= nil then
                        local distanceToTarget = (pHrp.Position - targetPosition.Position).Magnitude
                        
                        -- 15 stud'dan daha yakınsak vurmaya başla
                        if distanceToTarget < 15 then
                            AutoFarm.Attack()
                        end
                    end
                else
                    -- Eğer hedef öldüyse veya yoksa uçuşu durdur
                    Tween.Stop()
                end
            else
                -- Eğer haritada kesilecek yaratık kalmadıysa uçuşu durdur ve spawn bekle
                Tween.Stop()
            end
        else
            -- Auto Farm kapatıldıysa her şeyi durdur ve pürüzsüzce bekle
            Tween.Stop()
        end
    end
end)

-- DOSYAYI DIŞARI AKTAR
return AutoFarm
