-- [[ enemy.lua ]] --
-- IsoHub Hedef Bulucu (Blox Fruits Yaratıkları İçin Optimize Edildi)

getgenv().IsoHubEnemy = {}
local Enemy = getgenv().IsoHubEnemy

local Core = getgenv().IsoHubCore
local Config = getgenv().IsoHubConfig

-- Haritadaki canlı, hedeflenen ve en yakın yaratığı bulma fonksiyonu
Enemy.GetTarget = function()
    local targetName = Config.AutoFarm.TargetMob
    
    -- Eğer config dosyasında bir hedef belirlenmemişse aramayı durdur
    if targetName == "" then return nil end

    local closestMob = nil
    local shortestDistance = math.huge
    local playerChar, playerHrp, playerHum = Core.GetCharacter()

    if not playerChar or not playerHrp then return nil end

    -- Blox Fruits'te düşmanlar Workspace altındaki Enemies klasöründe bulunur
    local enemiesFolder = Core.Workspace:FindFirstChild("Enemies")
    if not enemiesFolder then return nil end

    for _, mob in pairs(enemiesFolder:GetChildren()) do
        -- İsmi bizim config'de aradığımız isimle eşleşiyorsa
        if mob.Name == targetName then
            local mobHrp = mob:FindFirstChild("HumanoidRootPart")
            local mobHum = mob:FindFirstChild("Humanoid")

            -- Yaratığın fiziksel olarak var olduğunu ve canının 0'dan büyük (canlı) olduğunu doğrula
            if mobHrp and mobHum and mobHum.Health > 0 then
                local distance = (playerHrp.Position - mobHrp.Position).Magnitude
                
                -- Karakterimize en yakın olanı seçmek zaman kazandırır ve anti-cheat'i daha az yorar
                if distance < shortestDistance then
                    shortestDistance = distance
                    closestMob = mob
                end
            end
        end
    end

    return closestMob
end

-- Eğer haritada yaratık kalmamışsa spawn noktasına gitmek için altyapı (Tabanı korumak için boş eklendi)
Enemy.GetSpawnPoint = function()
    -- İleride haritadaki spawn noktalarını çekmek istersek bu fonksiyonu dolduracağız.
    return nil
end

return Enemy
