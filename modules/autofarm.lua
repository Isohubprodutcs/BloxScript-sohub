-- [[ autofarm.lua ]] -- BÖLÜM 1
-- IsoHub Gelişmiş Otomatik Kasılma ve Savaş Motoru (PC & Mobil Uyumlu Tam Sürüm)

getgenv().IsoHubAutoFarm = {}
local AutoFarm = getgenv().IsoHubAutoFarm

-- Gerekli Modülleri Çağırıyoruz
local Core = getgenv().IsoHubCore
local Config = getgenv().IsoHubConfig
local Tween = getgenv().IsoHubTween
local Enemy = getgenv().IsoHubEnemy
local Quest = getgenv().IsoHubQuest

-- 1. Gelişmiş ve Güvenli Silah Kuşanma Sistemi
AutoFarm.EquipWeapon = function()
    local char, hrp, hum = Core.GetCharacter()
    if not char or not hum then return end

    local weaponName = Config.Combat.SelectWeapon
    
    -- Karakterin elinde zaten bir eşya var mı? Varsa ve doğruysa işlemi durdur, sistemi yorma
    local currentTool = char:FindFirstChildOfClass("Tool")
    if currentTool and currentTool.ToolTip == weaponName then 
        return 
    end

    -- Yanlış bir şey tutuyorsa veya eli boşsa çantayı (Backpack) kontrol et
    local backpack = Core.LocalPlayer:FindFirstChild("Backpack")
    if backpack then
        for _, tool in ipairs(backpack:GetChildren()) do
            if tool:IsA("Tool") and tool.ToolTip == weaponName then
                -- Oyuncunun eline silahı zorla ver
                hum:EquipTool(tool)
                break
            end
        end
    end
end

-- 2. Çoklu Platform Saldırı Sistemi (PC Sanal Tık + Mobil Tool Activate)
AutoFarm.Attack = function()
    if Config.Combat.AutoClick then
        
        -- Hızlı Vuruş (Fast Attack) açıksa bekleme süresini (Cooldown) sıfırlama altyapısı
        if Config.AutoFarm.FastAttack then
            local char = Core.LocalPlayer.Character
            if char then
                local tool = char:FindFirstChildOfClass("Tool")
                if tool and tool:FindFirstChild("Cooldown") then
                    tool.Cooldown.Value = 0 -- Blox Fruits yerel vuruş bekleme süresini manipüle eder
                end
            end
        end

        -- A) PC Kullanıcıları İçin Sanal Tıklama (VirtualUser)
        -- Hata verip scripti durdurmaması için pcall (korumalı çağrı) içine alıyoruz
        pcall(function()
            Core.VirtualUser:CaptureController()
            Core.VirtualUser:ClickButton1(Vector2.new(0,0))
        end)
        
        -- B) Mobil Cihazlar İçin Garantili Vuruş (Eldeki Eşyayı Etkinleştirme)
        local char = Core.LocalPlayer.Character
        if char then
            local currentTool = char:FindFirstChildOfClass("Tool")
            if currentTool then
                currentTool:Activate()
            end
        end
        
        -- C) Yetenekleri (Skilleri) Otomatik Kullanma Entegrasyonu
        if Config.Combat.AutoSkills.Z then
            pcall(function() Core.VirtualUser:SetKeyDown("z") task.wait(0.1) Core.VirtualUser:SetKeyUp("z") end)
        end
        if Config.Combat.AutoSkills.X then
            pcall(function() Core.VirtualUser:SetKeyDown("x") task.wait(0.1) Core.VirtualUser:SetKeyUp("x") end)
        end
        if Config.Combat.AutoSkills.C then
            pcall(function() Core.VirtualUser:SetKeyDown("c") task.wait(0.1) Core.VirtualUser:SetKeyUp("c") end)
        end
        if Config.Combat.AutoSkills.V then
            pcall(function() Core.VirtualUser:SetKeyDown("v") task.wait(0.1) Core.VirtualUser:SetKeyUp("v") end)
        end
    end
end

-- 3. Kusursuz Pozisyon ve Anti-Cheat Mesafe Hesaplama
AutoFarm.GetFarmPosition = function(targetHrp)
    local distance = Config.AutoFarm.Distance
    local positionType = Config.AutoFarm.Position
    local targetCFrame = targetHrp.CFrame

    -- Yaratığın yönüne göre CFrame matematiği kullanıyoruz
    if positionType == "Above" then
        -- Üstünde dur (En güvenli yöntem, moblar yukarı vuramaz)
        return targetCFrame * CFrame.new(0, distance, 0) * CFrame.Angles(math.rad(-90), 0, 0)
    elseif positionType == "Behind" then
        -- Arkasında dur
        return targetCFrame * CFrame.new(0, 0, distance)
    elseif positionType == "Under" then
        -- Altında dur (Yerin içine girer, bazı adalarda işe yarar)
        return targetCFrame * CFrame.new(0, -distance, 0) * CFrame.Angles(math.rad(90), 0, 0)
    else
        -- Varsayılan: Üstünde
        return targetCFrame * CFrame.new(0, distance, 0) * CFrame.Angles(math.rad(-90), 0, 0)
    end
end
-- [[ autofarm.lua ]] -- BÖLÜM 2
-- (Bu kısmı BÖLÜM 1'in hemen altına yapıştır)

-- 4. Gelişmiş Bring Mobs (Yaratıkları Bir Yere Toplama ve Hitbox Büyütme) Sistemi
AutoFarm.BringMobs = function(mainTargetHrp)
    if not Config.AutoFarm.BringMobs then return end

    local enemiesFolder = Core.Workspace:FindFirstChild("Enemies")
    if not enemiesFolder then return end

    for _, mob in ipairs(enemiesFolder:GetChildren()) do
        -- Sadece bizim config'de belirlediğimiz (veya Quest'in belirlediği) hedefleri topla
        if mob.Name == Config.AutoFarm.TargetMob then
            local mobHrp = mob:FindFirstChild("HumanoidRootPart")
            local mobHum = mob:FindFirstChild("Humanoid")

            if mobHrp and mobHum and mobHum.Health > 0 then
                -- Yaratık ana hedefimize 300 stud'dan yakınsa onu ana hedefin içine çek
                local distance = (mobHrp.Position - mainTargetHrp.Position).Magnitude
                if distance < 300 and distance > 5 then
                    pcall(function()
                        -- Diğer yaratıkları ana hedefin pozisyonuna sabitle
                        mobHrp.CFrame = mainTargetHrp.CFrame
                        mobHrp.CanCollide = false
                        
                        -- Vurmayı kolaylaştırmak için Hitbox (Vücut boyutu) büyütme exploit taktiği
                        mobHrp.Size = Vector3.new(60, 60, 60)
                        mobHrp.Transparency = 0.8 -- Ekranı kaplamaması için biraz saydam yap
                    end)
                end
            end
        end
    end
end

-- 5. Ana AutoFarm Döngüsü (PC ve Mobil Uyumlu Stabil Orkestra Şefi)
task.spawn(function()
    while task.wait() do
        -- Sadece AutoFarm açıksa işlemleri yap
        if Config.AutoFarm.Enabled then
            
            -- [ AUTO QUEST SİSTEMİ KONTROLÜ ]
            if Config.AutoFarm.AutoQuest then
                -- Eğer görevimiz yoksa gidip görev almayı dene
                if not Quest.HasQuest() then
                    Quest.TakeQuest()
                    task.wait(1.5) -- Görevi alırken sunucu gecikmesine karşı bekleme payı
                    continue -- Döngüyü başa sar ki görevi aldığından emin olsun
                end
                
                -- Görev varsa hedefimizi göreve göre güncelle
                local currentQuestData = Quest.GetCurrentQuestData()
                if currentQuestData then
                    Config.AutoFarm.TargetMob = currentQuestData.MobName
                end
            end
            
            -- [ HEDEF BULMA VE SAVAŞ SİSTEMİ ]
            local targetMob = Enemy.GetTarget()

            if targetMob then
                local targetHrp = targetMob:FindFirstChild("HumanoidRootPart")
                local targetHum = targetMob:FindFirstChild("Humanoid")

                -- Hedefin hayatta ve fiziksel olarak var olduğundan emin ol
                if targetHrp and targetHum and targetHum.Health > 0 then
                    
                    -- Adım 1: Silahı Kuşan
                    AutoFarm.EquipWeapon()

                    -- Adım 2: Hedefin yanına uç (TweenService ile)
                    local farmCFrame = AutoFarm.GetFarmPosition(targetHrp)
                    Tween.FlyTo(farmCFrame)

                    -- Adım 3: Etraftaki diğer mobları ana hedefin üstüne çek (Eğer açıksa)
                    AutoFarm.BringMobs(targetHrp)

                    -- Adım 4: Hedefe vur (Mesafe kontrolü)
                    local playerChar, playerHrp, _ = Core.GetCharacter()
                    if playerHrp then
                        local currentDistance = (playerHrp.Position - farmCFrame.Position).Magnitude
                        
                        -- Mobil cihazlardaki ping/gecikme sorununu önlemek için tolerans 10 stud yapıldı
                        if currentDistance < 10 then
                            AutoFarm.Attack()
                        end
                    end
                else
                    -- Eğer hedef mob aniden öldüyse uçuşu durdur
                    Tween.Stop()
                end
            else
                -- Eğer haritada kesilecek mob kalmadıysa (spawn olmasını bekliyorsak) uçuşu durdur ve bekle
                Tween.Stop()
            end
        else
            -- AutoFarm menüden kapatıldığında karakterin havada sürüklenmesini engelle
            Tween.Stop()
        end
    end
end)

-- IsoHubAutoFarm Tablosunu Döndür (Modülü Tamamla)
return AutoFarm
