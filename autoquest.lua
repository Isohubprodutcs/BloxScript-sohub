-- [[ autoquest.lua ]] --
-- IsoHub Otomatik Görev Alma (Auto Quest) Sistemi - Tüm Denizler

getgenv().IsoHubQuest = {}
local Quest = getgenv().IsoHubQuest

local Core = getgenv().IsoHubCore
local Tween = getgenv().IsoHubTween

-- Blox Fruits Görev Veritabanı (Sea 1, Sea 2, Sea 3)
-- LevelReq: Görevi almak için gereken minimum seviye
-- MobName: Kesilecek yaratığın oyundaki tam adı
-- QuestName: Oyunun arkada kullandığı görev adı
-- QuestLevel: Görevin sırası
-- NPCName: Görevi veren NPC'nin adı
-- NPCPos: NPC'nin haritadaki konumu

Quest.Database = {
    -----------------------------------
    -- SEA 1 (Birinci Deniz) 1 - 700 --
    -----------------------------------
    {
        LevelReq = 1,
        MobName = "Bandit [Lv. 5]",
        QuestName = "BanditQuest1",
        QuestLevel = 1,
        NPCName = "Bandit Quest Giver",
        NPCPos = CFrame.new(1060, 16, 1547)
    },
    {
        LevelReq = 15,
        MobName = "Monkey [Lv. 14]",
        QuestName = "JungleQuest",
        QuestLevel = 1,
        NPCName = "Adventurer",
        NPCPos = CFrame.new(-1602, 36, 152)
    },
    {
        LevelReq = 20,
        MobName = "Gorilla [Lv. 20]",
        QuestName = "JungleQuest",
        QuestLevel = 2,
        NPCName = "Adventurer",
        NPCPos = CFrame.new(-1602, 36, 152)
    },
    {
        LevelReq = 30,
        MobName = "Pirate [Lv. 35]",
        QuestName = "BuggyQuest1",
        QuestLevel = 1,
        NPCName = "Pirate Quest Giver",
        NPCPos = CFrame.new(-1140, 5, 3828)
    },
    {
        LevelReq = 40,
        MobName = "Brute [Lv. 45]",
        QuestName = "BuggyQuest1",
        QuestLevel = 2,
        NPCName = "Pirate Quest Giver",
        NPCPos = CFrame.new(-1140, 5, 3828)
    },
    {
        LevelReq = 60,
        MobName = "Desert Bandit [Lv. 60]",
        QuestName = "DesertQuest",
        QuestLevel = 1,
        NPCName = "Desert Adventurer",
        NPCPos = CFrame.new(896, 7, 4388)
    },
    {
        LevelReq = 90,
        MobName = "Snow Bandit [Lv. 90]",
        QuestName = "SnowQuest",
        QuestLevel = 1,
        NPCName = "Snow Quest Giver",
        NPCPos = CFrame.new(1385, 87, -1297)
    },
    {
        LevelReq = 120,
        MobName = "Chief Petty Officer [Lv. 120]",
        QuestName = "MarineQuest2",
        QuestLevel = 1,
        NPCName = "Marine Quest Giver",
        NPCPos = CFrame.new(-5036, 29, 4324)
    },
    {
        LevelReq = 150,
        MobName = "Sky Bandit [Lv. 150]",
        QuestName = "SkyQuest",
        QuestLevel = 1,
        NPCName = "Sky Quest Giver",
        NPCPos = CFrame.new(-4842, 718, -2620)
    },
    {
        LevelReq = 190,
        MobName = "Dark Combatant [Lv. 190]",
        QuestName = "GladiatorQuest",
        QuestLevel = 1,
        NPCName = "Gladiator Quest Giver",
        NPCPos = CFrame.new(-3334, 258, -3223)
    },
    {
        LevelReq = 250,
        MobName = "Toga Warrior [Lv. 250]",
        QuestName = "ColosseumQuest",
        QuestLevel = 1,
        NPCName = "Colosseum Quest Giver",
        NPCPos = CFrame.new(-1840, 15, -2759)
    },
    {
        LevelReq = 300,
        MobName = "Magma Ninja [Lv. 300]",
        QuestName = "MagmaQuest",
        QuestLevel = 1,
        NPCName = "Magma Quest Giver",
        NPCPos = CFrame.new(-5316, 12, 8514)
    },
    {
        LevelReq = 375,
        MobName = "Fishman Warrior [Lv. 375]",
        QuestName = "FishmanQuest",
        QuestLevel = 1,
        NPCName = "Fishman Quest Giver",
        NPCPos = CFrame.new(61122, 18, 1569)
    },
    {
        LevelReq = 450,
        MobName = "God's Guard [Lv. 450]",
        QuestName = "SkyExp1Quest",
        QuestLevel = 1,
        NPCName = "Sky Quest Giver",
        NPCPos = CFrame.new(-4721, 845, -1954)
    },
    {
        LevelReq = 500,
        MobName = "Whiskey Peak [Lv. 500]",
        QuestName = "FountainQuest",
        QuestLevel = 1,
        NPCName = "Fountain Quest Giver",
        NPCPos = CFrame.new(5256, 38, 4050)
    },

    -----------------------------------
    -- SEA 2 (İkinci Deniz) 700 - 1500 --
    -----------------------------------
    {
        LevelReq = 700,
        MobName = "Raider [Lv. 700]",
        QuestName = "Area1Quest",
        QuestLevel = 1,
        NPCName = "Quest Giver",
        NPCPos = CFrame.new(-425, 73, 1837)
    },
    {
        LevelReq = 775,
        MobName = "Swan Pirate [Lv. 775]",
        QuestName = "Area2Quest",
        QuestLevel = 1,
        NPCName = "Quest Giver",
        NPCPos = CFrame.new(874, 114, 1222)
    },
    {
        LevelReq = 875,
        MobName = "Marine Lieutenant [Lv. 875]",
        QuestName = "MarineQuest3",
        QuestLevel = 1,
        NPCName = "Quest Giver",
        NPCPos = CFrame.new(-2806, 73, -3038)
    },
    {
        LevelReq = 950,
        MobName = "Zombie [Lv. 950]",
        QuestName = "ZombieQuest",
        QuestLevel = 1,
        NPCName = "Quest Giver",
        NPCPos = CFrame.new(-5494, 48, -795)
    },
    {
        LevelReq = 1000,
        MobName = "Snow Trooper [Lv. 1000]",
        QuestName = "SnowMountainQuest",
        QuestLevel = 1,
        NPCName = "Quest Giver",
        NPCPos = CFrame.new(605, 400, -5360)
    },
    {
        LevelReq = 1100,
        MobName = "Lab Subordinate [Lv. 1100]",
        QuestName = "IceQuest",
        QuestLevel = 1,
        NPCName = "Quest Giver",
        NPCPos = CFrame.new(-6060, 15, -4904)
    },
    {
        LevelReq = 1250,
        MobName = "Magma Ninja [Lv. 1250]",
        QuestName = "FireQuest",
        QuestLevel = 1,
        NPCName = "Quest Giver",
        NPCPos = CFrame.new(-5428, 15, 5296)
    },
    {
        LevelReq = 1350,
        MobName = "Cursed Skeleton [Lv. 1350]",
        QuestName = "ShipQuest",
        QuestLevel = 1,
        NPCName = "Quest Giver",
        NPCPos = CFrame.new(923, 125, 32883)
    },
    {
        LevelReq = 1425,
        MobName = "Water Fighter [Lv. 1425]",
        QuestName = "WaterQuest",
        QuestLevel = 1,
        NPCName = "Quest Giver",
        NPCPos = CFrame.new(-3385, 238, -10542)
    },

    -----------------------------------
    -- SEA 3 (Üçüncü Deniz) 1500+    --
    -----------------------------------
    {
        LevelReq = 1500,
        MobName = "Pirate Millionaire [Lv. 1500]",
        QuestName = "PiratePortQuest",
        QuestLevel = 1,
        NPCName = "Quest Giver",
        NPCPos = CFrame.new(-290, 44, 5581)
    },
    {
        LevelReq = 1575,
        MobName = "Dragon Crew Warrior [Lv. 1575]",
        QuestName = "AmazonQuest",
        QuestLevel = 1,
        NPCName = "Quest Giver",
        NPCPos = CFrame.new(5833, 51, -1101)
    },
    {
        LevelReq = 1700,
        MobName = "Marine Commodore [Lv. 1700]",
        QuestName = "MarineTreeQuest",
        QuestLevel = 1,
        NPCName = "Quest Giver",
        NPCPos = CFrame.new(2180, 28, -6741)
    },
    {
        LevelReq = 1800,
        MobName = "Fishman Raider [Lv. 1800]",
        QuestName = "DeepForestQuest",
        QuestLevel = 1,
        NPCName = "Quest Giver",
        NPCPos = CFrame.new(-10465, 331, -8761)
    },
    {
        LevelReq = 1900,
        MobName = "Jungle Pirate [Lv. 1900]",
        QuestName = "JunglePirateQuest",
        QuestLevel = 1,
        NPCName = "Quest Giver",
        NPCPos = CFrame.new(-710, 38, -10838)
    },
    {
        LevelReq = 2000,
        MobName = "Reborn Skeleton [Lv. 2000]",
        QuestName = "HauntedQuest",
        QuestLevel = 1,
        NPCName = "Quest Giver",
        NPCPos = CFrame.new(-9478, 141, 5536)
    },
    {
        LevelReq = 2100,
        MobName = "Peanut Scout [Lv. 2100]",
        QuestName = "NutsQuest",
        QuestLevel = 1,
        NPCName = "Quest Giver",
        NPCPos = CFrame.new(-2124, 38, -7825)
    },
    {
        LevelReq = 2200,
        MobName = "Cookie Crafter [Lv. 2200]",
        QuestName = "IceCreamQuest",
        QuestLevel = 1,
        NPCName = "Quest Giver",
        NPCPos = CFrame.new(-821, 65, -10964)
    },
    {
        LevelReq = 2300,
        MobName = "Cocoa Warrior [Lv. 2300]",
        QuestName = "ChocQuest",
        QuestLevel = 1,
        NPCName = "Quest Giver",
        NPCPos = CFrame.new(201, 24, -12196)
    },
    {
        LevelReq = 2400,
        MobName = "Candy Rebel [Lv. 2400]",
        QuestName = "CandyQuest",
        QuestLevel = 1,
        NPCName = "Quest Giver",
        NPCPos = CFrame.new(-1147, 13, -14330)
    },
    {
        LevelReq = 2450,
        MobName = "Isle Champion [Lv. 2450]",
        QuestName = "TikiQuest",
        QuestLevel = 1,
        NPCName = "Quest Giver",
        NPCPos = CFrame.new(-16233, 9, 401)
    }
}

-- Oyuncunun Mevcut Seviyesini Çeken Fonksiyon
Quest.GetPlayerLevel = function()
    local player = Core.LocalPlayer
    if player and player:FindFirstChild("Data") and player.Data:FindFirstChild("Level") then
        return player.Data.Level.Value
    end
    return 1 
end

-- Seviyeye En Uygun Görevi Bulan Fonksiyon
Quest.GetCurrentQuestData = function()
    local myLevel = Quest.GetPlayerLevel()
    local bestQuest = nil

    -- Veritabanını baştan sona tara
    for _, questData in ipairs(Quest.Database) do
        -- Eğer seviyemiz bu göreve yetiyorsa, bunu "en iyi görev" yap
        if myLevel >= questData.LevelReq then
            bestQuest = questData
        end
    end

    return bestQuest
end

-- Görevin Zaten Alınmış Olup Olmadığını Kontrol Eden Fonksiyon
Quest.HasQuest = function()
    local playerGui = Core.LocalPlayer:FindFirstChild("PlayerGui")
    if playerGui and playerGui:FindFirstChild("Main") and playerGui.Main:FindFirstChild("Quest") then
        if playerGui.Main.Quest.Visible == true then
            return true
        end
    end
    return false
end

-- Görevi NPC'den Alma Fonksiyonu
Quest.TakeQuest = function()
    if Quest.HasQuest() then return end 

    local questData = Quest.GetCurrentQuestData()
    if not questData then return end

    local char, hrp, hum = Core.GetCharacter()
    if not char or not hrp then return end

    -- NPC'ye uç
    local distanceToNPC = (hrp.Position - questData.NPCPos.Position).Magnitude
    if distanceToNPC > 10 then
        Tween.FlyTo(questData.NPCPos)
        return 
    end

    -- Yeterince yakınsak uçuşu durdur ve görevi al
    Tween.Stop()
    
    local args = {
        [1] = "StartQuest",
        [2] = questData.QuestName,
        [3] = questData.QuestLevel
    }
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
end

return Quest