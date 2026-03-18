-- [[ autostats.lua ]] --
-- IsoHub Otomatik Statü Dağıtma (Auto Stats) Sistemi

getgenv().IsoHubStats = {}
local Stats = getgenv().IsoHubStats

local Core = getgenv().IsoHubCore
local Config = getgenv().IsoHubConfig

-- Stat İsimlerinin Oyundaki Karşılıkları (RemoteEvent için)
Stats.StatNames = {
    Melee = "Melee",
    Defense = "Defense",
    Sword = "Sword",
    Gun = "Gun",
    BloxFruit = "Demon Fruit" -- Blox Fruits'te meyve statı böyle geçiyor
}

-- Puan Verme Fonksiyonu
Stats.AddPoint = function(statName, points)
    local args = {
        [1] = "AddPoint",
        [2] = statName,
        [3] = points
    }
    -- Blox Fruits sunucusuna puan verme isteği yolla
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
end

-- Oyuncunun Mevcut Stat Puanlarını Çekme
Stats.GetAvailablePoints = function()
    local player = Core.LocalPlayer
    if player and player:FindFirstChild("Data") and player.Data:FindFirstChild("Points") then
        return player.Data.Points.Value
    end
    return 0
end

-- Ana AutoStats Döngüsü
task.spawn(function()
    while task.wait(1) do -- Saniyede 1 kez kontrol etmesi yeterli (Sistemi yormaz)
        if Config.AutoStats.Enabled then
            local availablePoints = Stats.GetAvailablePoints()
            local pointsToSpend = Config.AutoStats.PointsPerTick

            -- Eğer dağıtılacak puan varsa işlem yap
            if availablePoints > 0 then
                -- Config'de hangi statlar seçilmişse onlara puan ver
                for statKey, isEnabled in pairs(Config.AutoStats.Focus) do
                    if isEnabled then
                        local realStatName = Stats.StatNames[statKey]
                        
                        -- Eğer elimizdeki puan, harcamak istediğimiz puandan azsa elimizdekini harca
                        if availablePoints < pointsToSpend then
                            pointsToSpend = availablePoints
                        end

                        -- Puanı ver ve elimizdeki puan değişkenini güncelle
                        if pointsToSpend > 0 then
                            Stats.AddPoint(realStatName, pointsToSpend)
                            availablePoints = availablePoints - pointsToSpend
                            task.wait(0.1) -- Sunucuyu spama düşürmemek için minik bir bekleme
                        end
                    end
                end
            end
        end
    end
end)

return Stats
