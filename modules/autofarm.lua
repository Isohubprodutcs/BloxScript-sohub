-- [[ autofarm.lua ]] --
-- IsoHub Gelişmiş Otomatik Kasılma ve Savaş Motoru (TAM SÜRÜM - KISALTILMAMIŞ)

getgenv().IsoHubAutoFarm = {}
local AutoFarm = getgenv().IsoHubAutoFarm

-- Modül Bağlantıları (En Geniş Haliyle)
local Core = getgenv().IsoHubCore
local Config = getgenv().IsoHubConfig
local Tween = getgenv().IsoHubTween
local Enemy = getgenv().IsoHubEnemy
local Quest = getgenv().IsoHubQuest

-- 1. Silah Kuşanma Fonksiyonu (Eksiksiz)
AutoFarm.EquipWeapon = function()
    local char, hrp, hum = Core.GetCharacter()
    if not char then return end
    if not hum then return end

    local weaponName = Config.Combat.SelectWeapon
    local currentTool = char:FindFirstChildOfClass("Tool")
    
    if currentTool then
        if currentTool.ToolTip == weaponName then 
            return 
        end
    end

    local backpack = Core.LocalPlayer:FindFirstChild("Backpack")
    if backpack then
        local tools = backpack:GetChildren()
        for i = 1, #tools do
            local tool = tools[i]
            if tool:IsA("Tool") then
                if tool.ToolTip == weaponName then
                    hum:EquipTool(tool)
                    break
                end
            end
        end
    end
end

-- 2. Saldırı Fonksiyonu (PC + Mobil + Skill - Tüm Detaylarıyla)
AutoFarm.Attack = function()
    if Config.Combat.AutoClick == true then
        -- PC Sanal Tıklama Bloğu
        pcall(function()
            local virtualUser = game:GetService("VirtualUser")
            virtualUser:CaptureController()
            virtualUser:ClickButton1(Vector2.new(0,0))
        end)
        
        -- Mobil Aktivasyon Bloğu
        local character = game.Players.LocalPlayer.Character
        if character then
            local tool = character:FindFirstChildOfClass("Tool")
            if tool then
                tool:Activate()
            end
        end

        -- Otomatik Skill Kullanımı (Her Biri Ayrı Kontrol Edilir)
        if Config.Combat.AutoSkills.Z == true then
            game:GetService("VirtualUser"):SetKeyDown("z")
            task.wait(0.05)
            game:GetService("VirtualUser"):SetKeyUp("z")
        end
        if Config.Combat.AutoSkills.X == true then
            game:GetService("VirtualUser"):SetKeyDown("x")
            task.wait(0.05)
            game:GetService("VirtualUser"):SetKeyUp("x")
        end
        if Config.Combat.AutoSkills.C == true then
            game:GetService("VirtualUser"):SetKeyDown("c")
            task.wait(0.05)
            game:GetService("VirtualUser"):SetKeyUp("c")
        end
        if Config.Combat.AutoSkills.V == true then
            game:GetService("VirtualUser"):SetKeyDown("v")
            task.wait(0.05)
            game:GetService("VirtualUser"):SetKeyUp("v")
        end
    end
end

-- 3. Pozisyon Hesaplama (Tüm Olasılıklar)
AutoFarm.GetFarmPosition = function(targetHrp)
    local dist = Config.AutoFarm.Distance
    local posType = Config.AutoFarm.Position
    local targetCF = targetHrp.CFrame

    if posType == "Above" then
        return targetCF * CFrame.new(0, dist, 0) * CFrame.Angles(math.rad(-90), 0, 0)
    elseif posType == "Behind" then
        return targetCF * CFrame.new(0, 0, dist)
    elseif posType == "Under" then
        return targetCF * CFrame.new(0, -dist, 0) * CFrame.Angles(math.rad(90), 0, 0)
    else
        return targetCF * CFrame.new(0, dist, 0) * CFrame.Angles(math.rad(-90), 0, 0)
    end
end

-- 4. Yaratık Toplama (Bring Mobs - Gelişmiş Filtreli)
AutoFarm.BringMobs = function(mainTargetHrp)
    if Config.AutoFarm.BringMobs == true then
        local enemies = workspace:FindFirstChild("Enemies")
        if enemies then
            for _, mob in pairs(enemies:GetChildren()) do
                if mob.Name == Config.AutoFarm.TargetMob then
                    local mHrp = mob:FindFirstChild("HumanoidRootPart")
                    local mHum = mob:FindFirstChild("Humanoid")
                    if mHrp and mHum and mHum.Health > 0 then
                        if (mHrp.Position - mainTargetHrp.Position).Magnitude < 300 then
                            mHrp.CFrame = mainTargetHrp.CFrame
                            mHrp.CanCollide = false
                        end
                    end
                end
            end
        end
    end
end

-- 5. ANA DÖNGÜ (DURDURULAMAZ VE KISALTILAMAZ VERSİYON)
task.spawn(function()
    while true do
        task.wait()
        
        -- ŞART 1: AUTO FARM AÇIK MI?
        if Config.AutoFarm.Enabled == true then
            
            -- ŞART 2: OTOMATİK GÖREV SİSTEMİ
            if Config.AutoFarm.AutoQuest == true then
                local hasQuest = Quest.HasQuest()
                
                if hasQuest == false then
                    -- GÖREV YOKSA GİT AL
                    Quest.TakeQuest()
                    task.wait(1)
                else
                    -- GÖREV VARSA MOB İSMİNİ GÜNCELLE
                    local qData = Quest.GetCurrentQuestData()
                    if qData ~= nil then
                        Config.AutoFarm.TargetMob = qData.MobName
                    end
                end
            end

            -- ŞART 3: HEDEF BULMA VE SALDIRI
            -- Not: Görev olsa da olmasa da (eğer elle mob seçildiyse) burası çalışır
            local target = Enemy.GetTarget()

            if target ~= nil then
                local tHrp = target:FindFirstChild("HumanoidRootPart")
                local tHum = target:FindFirstChild("Humanoid")

                if tHrp ~= nil and tHum ~= nil then
                    if tHum.Health > 0 then
                        -- ADIM 1: SİLAHI HAZIRLA
                        AutoFarm.EquipWeapon()

                        -- ADIM 2: HEDEFE UÇ (TWEEN)
                        local farmPos = AutoFarm.GetFarmPosition(tHrp)
                        Tween.FlyTo(farmPos)

                        -- ADIM 3: DİĞERLERİNİ TOPLA
                        AutoFarm.BringMobs(tHrp)

                        -- ADIM 4: MESAFE KONTROLÜ VE VURUŞ
                        local char, hrp, hum = Core.GetCharacter()
                        if hrp ~= nil then
                            local mag = (hrp.Position - farmPos.Position).Magnitude
                            if mag < 15 then
                                AutoFarm.Attack()
                            end
                        end
                    else
                        -- MOB ÖLDÜYSE DUR
                        Tween.Stop()
                    end
                else
                    -- PARÇALAR EKSİKSE DUR
                    Tween.Stop()
                end
            else
                -- HEDEF YOKSA DUR VE BEKLE
                Tween.Stop()
            end

        else
            -- EĞER SİSTEM KAPALIYSA HER ŞEYİ DURDUR
            Tween.Stop()
        end
    end
end)

return AutoFarm
