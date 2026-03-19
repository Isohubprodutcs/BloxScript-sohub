-- [[ autoquest.lua ]] --
-- IsoHub Npc & Quest Database (SEA 1, 2, 3 - FULL UNABRIDGED VERSION)

getgenv().IsoHubQuest = {}
local Quest = getgenv().IsoHubQuest

local Core = getgenv().IsoHubCore
local Config = getgenv().IsoHubConfig
local Tween = getgenv().IsoHubTween

-- FULL DATABASE START
Quest.Data = {
    -- [[ SEA 1 (1. DENİZ) - SADECE NORMAL MOBLAR ]] --
    [0] = {QuestName = "BanditQuest1", MobName = "Bandit", NpcName = "Bandit Recruiter", NpcPos = CFrame.new(1059.3, 15.4, 1550.1), World = 1},
    [10] = {QuestName = "MonkeyQuest1", MobName = "Monkey", NpcName = "Adventurer", NpcPos = CFrame.new(-1598.4, 35.5, 153.3), World = 1},
    [15] = {QuestName = "GorillaQuest1", MobName = "Gorilla", NpcName = "Adventurer", NpcPos = CFrame.new(-1598.4, 35.5, 153.3), World = 1},
    [30] = {QuestName = "PirateQuest1", MobName = "Pirate", NpcName = "Quest Giver", NpcPos = CFrame.new(-1141.1, 4.7, 3824.3), World = 1},
    [40] = {QuestName = "BruteQuest1", MobName = "Brute", NpcName = "Quest Giver", NpcPos = CFrame.new(-1141.1, 4.7, 3824.3), World = 1},
    [60] = {QuestName = "DesertQuest1", MobName = "Desert Bandit", NpcName = "Quest Giver", NpcPos = CFrame.new(894.4, 6.4, 4392.5), World = 1},
    [75] = {QuestName = "DesertQuest2", MobName = "Desert Officer", NpcName = "Quest Giver", NpcPos = CFrame.new(894.4, 6.4, 4392.5), World = 1},
    [90] = {QuestName = "SnowQuest1", MobName = "Snow Bandit", NpcName = "Quest Giver", NpcPos = CFrame.new(1389.7, 15.0, -1302.3) World = 1},
    [100] = {QuestName = "SnowQuest2", MobName = "Snowman", NpcName = "Quest Giver", NpcPos = CFrame.new(1389.7, 15.0, -1302.3), World = 1},
    [120] = {QuestName = "MarineQuest1", MobName = "Chief Petty Officer", NpcName = "Quest Giver", NpcPos = CFrame.new(-4855.2, 22.6, 4261.2), World = 1},
    [130] = {QuestName = "MarineQuest2", MobName = "First Lieutenant", NpcName = "Quest Giver", NpcPos = CFrame.new(-4855.2, 22.6, 4261.2), World = 1},
    [150] = {QuestName = "SkyQuest1", MobName = "Sky Bandit", NpcName = "Quest Giver", NpcPos = CFrame.new(-1241.3, 374.9, -1462.1), World = 1},
    [175] = {QuestName = "SkyQuest2", MobName = "Dark Skilled Cook", NpcName = "Quest Giver", NpcPos = CFrame.new(-1241.3, 374.9, -1462.1), World = 1},
    [190] = {QuestName = "PrisonQuest1", MobName = "Prisoner", NpcName = "Quest Giver", NpcPos = CFrame.new(5308.9, 1.8, 475.1), World = 1},
    [210] = {QuestName = "PrisonQuest2", MobName = "Dangerous Prisoner", NpcName = "Quest Giver", NpcPos = CFrame.new(5308.9, 1.8, 475.1), World = 1},
    [250] = {QuestName = "MagmaQuest1", MobName = "Military Soldier", NpcName = "Quest Giver", NpcPos = CFrame.new(-5313.3, 12.2, 8515.1), World = 1},
    [275] = {QuestName = "MagmaQuest2", MobName = "Military Spy", NpcName = "Quest Giver", NpcPos = CFrame.new(-5313.3, 12.2, 8515.1), World = 1},
    [375] = {QuestName = "FishmanQuest1", MobName = "Fishman Warrior", NpcName = "Quest Giver", NpcPos = CFrame.new(61122.5, 18.4, 1568.1), World = 1},
    [400] = {QuestName = "FishmanQuest2", MobName = "Fishman Commando", NpcName = "Quest Giver", NpcPos = CFrame.new(61122.5, 18.4, 1568.1), World = 1},
    [450] = {QuestName = "SkyExpQuest1", MobName = "God's Guard", NpcName = "Quest Giver", NpcPos = CFrame.new(-7906.1, 5551.2, -325.3), World = 1},
    [475] = {QuestName = "SkyExpQuest2", MobName = "Shanda", NpcName = "Quest Giver", NpcPos = CFrame.new(-7906.1, 5551.2, -325.3), World = 1},
    [525] = {QuestName = "SkyExpQuest3", MobName = "Royal Squad", NpcName = "Quest Giver", NpcPos = CFrame.new(-451.1, 5676.4, -4453.3), World = 1},
    [550] = {QuestName = "SkyExpQuest4", MobName = "Royal Soldier", NpcName = "Quest Giver", NpcPos = CFrame.new(-451.1, 5676.4, -4453.3), World = 1},
    [625] = {QuestName = "FountainQuest1", MobName = "Galley Pirate", NpcName = "Quest Giver", NpcPos = CFrame.new(5259.1, 38.5, 4050.1), World = 1},
    [650] = {QuestName = "FountainQuest2", MobName = "Galley Captain", NpcName = "Quest Giver", NpcPos = CFrame.new(5259.1, 38.5, 4050.1), World = 1},
    -- [[ SEA 2 (2. DENİZ) - SADECE NORMAL MOBLAR ]] --
    [700] = {QuestName = "RaiderQuest1", MobName = "Desert Raider", NpcName = "Quest Giver", NpcPos = CFrame.new(-424.1, 72.5, 1836.1), World = 2},
    [725] = {QuestName = "RaiderQuest2", MobName = "Desert Giant", NpcName = "Quest Giver", NpcPos = CFrame.new(-424.1, 72.5, 1836.1), World = 2},
    [775] = {QuestName = "MercenaryQuest1", MobName = "Military Mercenary", NpcName = "Quest Giver", NpcPos = CFrame.new(-1580.2, 7.3, 2982.1), World = 2},
    [800] = {QuestName = "MercenaryQuest2", MobName = "Military Spy", NpcName = "Quest Giver", NpcPos = CFrame.new(-1580.2, 7.3, 2982.1), World = 2},
    [875] = {QuestName = "SwanPirateQuest1", MobName = "Swan Pirate", NpcName = "Quest Giver", NpcPos = CFrame.new(-1037.4, 72.5, 3314.3), World = 2},
    [900] = {QuestName = "SwanPirateQuest2", MobName = "Factory Staff", NpcName = "Quest Giver", NpcPos = CFrame.new(-1037.4, 72.5, 3314.3), World = 2},
    [950] = {QuestName = "ZombieQuest1", MobName = "Zombie", NpcName = "Quest Giver", NpcPos = CFrame.new(-5424.1, 12.5, -722.1), World = 2},
    [975] = {QuestName = "ZombieQuest2", MobName = "Vampire", NpcName = "Quest Giver", NpcPos = CFrame.new(-5424.1, 12.5, -722.1), World = 2},
    [1000] = {QuestName = "SnowMountainQuest1", MobName = "Snow Trooper", NpcName = "Quest Giver", NpcPos = CFrame.new(609.1, 400.1, -5372.3), World = 2},
    [1050] = {QuestName = "SnowMountainQuest2", MobName = "Winter Warrior", NpcName = "Quest Giver", NpcPos = CFrame.new(609.1, 400.1, -5372.3), World = 2},
    [1100] = {QuestName = "IceSideQuest1", MobName = "Lab Subordinate", NpcName = "Quest Giver", NpcPos = CFrame.new(-6061.3, 15.5, -4905.1), World = 2},
    [1125] = {QuestName = "IceSideQuest2", MobName = "Horned Warrior", NpcName = "Quest Giver", NpcPos = CFrame.new(-6061.3, 15.5, -4905.1), World = 2},
    [1150] = {QuestName = "FireSideQuest1", MobName = "Magma Ninja", NpcName = "Quest Giver", NpcPos = CFrame.new(-5428.1, 15.5, -5299.1), World = 2},
    [1175] = {QuestName = "FireSideQuest2", MobName = "Lava Pirate", NpcName = "Quest Giver", NpcPos = CFrame.new(-5428.1, 15.5, -5299.1), World = 2},
    [1250] = {QuestName = "ShipQuest1", MobName = "Ship Pirate", NpcName = "Quest Giver", NpcPos = CFrame.new(1038.1, 125.1, 32911.1), World = 2},
    [1275] = {QuestName = "ShipQuest2", MobName = "Ship Steward", NpcName = "Quest Giver", NpcPos = CFrame.new(1038.1, 125.1, 32911.1), World = 2},
    [1350] = {QuestName = "IceCastleQuest1", MobName = "Arctic Warrior", NpcName = "Quest Giver", NpcPos = CFrame.new(5669.1, 28.1, -6482.1), World = 2},
    [1375] = {QuestName = "IceCastleQuest2", MobName = "Snow Lurker", NpcName = "Quest Giver", NpcPos = CFrame.new(5669.1, 28.1, -6482.1), World = 2},
    [1425] = {QuestName = "ForgottenQuest1", MobName = "Sea Soldier", NpcName = "Quest Giver", NpcPos = CFrame.new(-3054.1, 235.1, -10142.1), World = 2},
    [1450] = {QuestName = "ForgottenQuest2", MobName = "Water Yaksha", NpcName = "Quest Giver", NpcPos = CFrame.new(-3054.1, 235.1, -10142.1), World = 2},
    -- [[ SEA 3 (3. DENİZ) - SADECE NORMAL MOBLAR ]] --
    [1500] = {QuestName = "PiratePortQuest1", MobName = "Pirate Millionaire", NpcName = "Quest Giver", NpcPos = CFrame.new(-290.1, 15.5, 5308.1), World = 3},
    [1525] = {QuestName = "PiratePortQuest2", MobName = "Pistol Billionaire", NpcName = "Quest Giver", NpcPos = CFrame.new(-290.1, 15.5, 5308.1), World = 3},
    [1575] = {QuestName = "HydraIslandQuest1", MobName = "Dragon Crew Warrior", NpcName = "Quest Giver", NpcPos = CFrame.new(5745.1, 602.1, -219.1), World = 3},
    [1600] = {QuestName = "HydraIslandQuest2", MobName = "Dragon Crew Archer", NpcName = "Quest Giver", NpcPos = CFrame.new(5745.1, 602.1, -219.1), World = 3},
    [1625] = {QuestName = "HydraIslandQuest3", MobName = "Female Island Warrior", NpcName = "Quest Giver", NpcPos = CFrame.new(5745.1, 602.1, -219.1), World = 3},
    [1650] = {QuestName = "HydraIslandQuest4", MobName = "Giant Island Warrior", NpcName = "Quest Giver", NpcPos = CFrame.new(5745.1, 602.1, -219.1), World = 3},
    [1700] = {QuestName = "GreatTreeQuest1", MobName = "Marine Captain", NpcName = "Quest Giver", NpcPos = CFrame.new(2201.1, 15.5, -7122.1), World = 3},
    [1725] = {QuestName = "GreatTreeQuest2", MobName = "Marine Commodore", NpcName = "Quest Giver", NpcPos = CFrame.new(2201.1, 15.5, -7122.1), World = 3},
    [1775] = {QuestName = "TurtleQuest1", MobName = "Fishman Raider", NpcName = "Quest Giver", NpcPos = CFrame.new(-1319.1, 15.5, -10452.1), World = 3},
    [1800] = {QuestName = "TurtleQuest2", MobName = "Fishman Captain", NpcName = "Quest Giver", NpcPos = CFrame.new(-1319.1, 15.5, -10452.1), World = 3},
    [1825] = {QuestName = "TurtleQuest3", MobName = "Forest Pirate", NpcName = "Quest Giver", NpcPos = CFrame.new(-1319.1, 15.5, -10452.1), World = 3},
    [1850] = {QuestName = "TurtleQuest4", MobName = "Mythical Pirate", NpcName = "Quest Giver", NpcPos = CFrame.new(-1319.1, 15.5, -10452.1), World = 3},
    [1900] = {QuestName = "TurtleQuest5", MobName = "Jungle Pirate", NpcName = "Quest Giver", NpcPos = CFrame.new(-1319.1, 15.5, -10452.1), World = 3},
    [1925] = {QuestName = "TurtleQuest6", MobName = "Musketeer Pirate", NpcName = "Quest Giver", NpcPos = CFrame.new(-1319.1, 15.5, -10452.1), World = 3},
    [1975] = {QuestName = "HauntedCastleQuest1", MobName = "Reborn Skeleton", NpcName = "Quest Giver", NpcPos = CFrame.new(-9482.1, 142.1, 5562.1), World = 3},
    [2000] = {QuestName = "HauntedCastleQuest2", MobName = "Living Zombie", NpcName = "Quest Giver", NpcPos = CFrame.new(-9482.1, 142.1, 5562.1), World = 3},
    [2025] = {QuestName = "HauntedCastleQuest3", MobName = "Demonic Soul", NpcName = "Quest Giver", NpcPos = CFrame.new(-9482.1, 142.1, 5562.1), World = 3},
    [2050] = {QuestName = "HauntedCastleQuest4", MobName = "Posessed Mummy", NpcName = "Quest Giver", NpcPos = CFrame.new(-9482.1, 142.1, 5562.1), World = 3},
    [2100] = {QuestName = "IceCreamQuest1", MobName = "Peanut Scout", NpcName = "Quest Giver", NpcPos = CFrame.new(-1924.1, 15.5, -12544.1), World = 3},
    [2125] = {QuestName = "IceCreamQuest2", MobName = "Peanut President", NpcName = "Quest Giver", NpcPos = CFrame.new(-1924.1, 15.5, -12544.1), World = 3},
    [2150] = {QuestName = "IceCreamQuest3", MobName = "Ice Cream Guppy", NpcName = "Quest Giver", NpcPos = CFrame.new(-1924.1, 15.5, -12544.1), World = 3},
    [2175] = {QuestName = "IceCreamQuest4", MobName = "Ice Cream Chef", NpcName = "Quest Giver", NpcPos = CFrame.new(-1924.1, 15.5, -12544.1), World = 3},
    [2200] = {QuestName = "CandyQuest1", MobName = "Cocoa Warrior", NpcName = "Quest Giver", NpcPos = CFrame.new(-1924.1, 15.5, -12544.1), World = 3},
    [2225] = {QuestName = "CandyQuest2", MobName = "Chocolate Bar Battler", NpcName = "Quest Giver", NpcPos = CFrame.new(-1924.1, 15.5, -12544.1), World = 3},
    [2250] = {QuestName = "CandyQuest3", MobName = "Sweet Thief", NpcName = "Quest Giver", NpcPos = CFrame.new(-1924.1, 15.5, -12544.1), World = 3},
    [2275] = {QuestName = "CandyQuest4", MobName = "Candy Rebel", NpcName = "Quest Giver", NpcPos = CFrame.new(-1924.1, 15.5, -12544.1), World = 3},
    } -- Quest.Data Tablosunu Burada Kapatıyoruz
-- [[ EKSİK PARÇA 1: DÜNYA TESPİT SİSTEMİ ]] --
Quest.GetCurrentWorld = function()
    local placeId = game.PlaceId
    if placeId == 2753915133 then
        return 1 -- Sea 1
    elseif placeId == 4442272160 then
        return 2 -- Sea 2
    elseif placeId == 7449925010 then
        return 3 -- Sea 3
    end
    return 1 -- Varsayılan Sea 1
end
-- [[ GÜNCELLENMİŞ GetBestQuest ]] --
Quest.GetBestQuest = function()
    local playerLevel = Core.LocalPlayer.Data.Level.Value
    local currentWorld = Quest.GetCurrentWorld()
    
    local bestLevelMatch = 0
    local selectedData = nil

    for questLevel, questInfo in pairs(Quest.Data) do
        -- KRİTİK FİLTRE: Sadece oyuncunun olduğu dünyadaki görevleri göster!
        if playerLevel >= questLevel and questInfo.World == currentWorld then
            if questLevel >= bestLevelMatch then
                bestLevelMatch = questLevel
                selectedData = questInfo
            end
        end
    end
    return selectedData
end
-- [[ EKSİK PARÇA 2: GÜNCEL OLMAYAN GÖREVİ BIRAKMA (ABANDON) ]] --
-- Eğer levelin arttıysa ama hala eski görevi yapıyorsan, onu iptal edip yenisini almanı sağlar.
Quest.CheckAndAbandonOldQuest = function()
    local hasQuest = Quest.HasQuest()
    if hasQuest then
        local playerLevel = Core.LocalPlayer.Data.Level.Value
        local bestQuest = Quest.GetBestQuest()
        
        -- Eğer elimizdeki görev, levelimize uygun olan "en iyi" görev değilse iptal et
        if bestQuest and not string.find(game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, bestQuest.MobName) then
            print("[IsoHub] Eski görev tespit edildi, iptal ediliyor...")
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AbandonQuest")
        end
    end
end
-- 1. Seviyeye Göre En Mantıklı Görevi Seçen Algoritma
Quest.GetBestQuest = function()
    local playerLevel = 0
    
    -- Oyuncu seviyesini güvenli bir şekilde çekme
    pcall(function()
        playerLevel = Core.LocalPlayer.Data.Level.Value
    end)
    
    local bestLevelMatch = 0
    local selectedData = nil

    -- Tüm veritabanını tarayarak oyuncunun seviyesine en yakın ve en yüksek görevi bulur
    for questLevel, questInfo in pairs(Quest.Data) do
        if playerLevel >= questLevel then
            if questLevel >= bestLevelMatch then
                bestLevelMatch = questLevel
                selectedData = questInfo
            end
        end
    end
    
    return selectedData
end

-- 2. Aktif Bir Görevimiz Olup Olmadığını Kontrol Eden GUI Tarayıcı
Quest.HasQuest = function()
    local hasQuestActive = false
    
    local playerGui = Core.LocalPlayer:FindFirstChild("PlayerGui")
    if playerGui then
        local mainGui = playerGui:FindFirstChild("Main")
        if mainGui then
            local questFrame = mainGui:FindFirstChild("Quest")
            if questFrame then
                -- Eğer ekrandaki Quest penceresi görünürse görevimiz var demektir
                if questFrame.Visible == true then
                    hasQuestActive = true
                end
            end
        end
    end
    
    return hasQuestActive
end

-- 3. Mevcut Görevin Verilerini Dışarıya Aktarma
Quest.GetCurrentQuestData = function()
    local currentData = Quest.GetBestQuest()
    if currentData ~= nil then
        return currentData
    else
        return nil
    end
end

-- 4. NPC'ye Uçma ve Görevi Otomatik Olarak Başlatma Motoru
Quest.TakeQuest = function()
    local bestQuest = Quest.GetBestQuest()
    
    if bestQuest ~= nil then
        -- ADIM 1: NPC'nin koordinatlarına pürüzsüz uçuş başlat
        local npcTargetCFrame = bestQuest.NpcPos
        Tween.FlyTo(npcTargetCFrame)
        
        -- ADIM 2: Mesafe Kontrolü
        local character, hrp, humanoid = Core.GetCharacter()
        if hrp ~= nil then
            local distanceToNpc = (hrp.Position - npcTargetCFrame.Position).Magnitude
            
            -- NPC'ye 15 stud'dan daha yakınsak etkileşime gir
            if distanceToNpc < 15 then
                task.wait(0.3) -- Küçük bir senkronizasyon beklemesi
                
                -- ADIM 3: Blox Fruits Sunucu Protokolü (Remote Invoke)
                -- Bu kısım oyunun ana sunucusuna "Ben bu görevi aldım" bilgisini gönderir.
                local remotePath = game:GetService("ReplicatedStorage").Remotes.CommF_
                
                local success, err = pcall(function()
                    remotePath:InvokeServer(
                        "StartQuest", 
                        bestQuest.QuestName, 
                        1
                    )
                end)
                
                if success then
                    print("[IsoHub] Görev Başarıyla Alındı: " .. bestQuest.QuestName)
                else
                    warn("[IsoHub Error] Görev Alma Hatası: " .. tostring(err))
                end
                
                task.wait(0.5) -- Görevin UI üzerinde güncellenmesi için bekleme
            end
        end
    end
end

-- MODÜLÜN SONU VE DIŞARI AKTARIMI
return Quest
