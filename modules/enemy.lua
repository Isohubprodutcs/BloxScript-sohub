-- [[ enemy.lua ]] --
-- IsoHub Hedef Tespit ve Kilitleme Sistemi (FULL UNABRIDGED)

getgenv().IsoHubEnemy = {}
local Enemy = getgenv().IsoHubEnemy

local Core = getgenv().IsoHubCore
local Config = getgenv().IsoHubConfig

-- 1. Hedef Mobu Bulma Fonksiyonu
Enemy.GetTarget = function()
    local targetName = Config.AutoFarm.TargetMob
    
    -- Eğer hedef ismi boşsa (Quest daha alınmadıysa) dur
    if targetName == "" or targetName == nil then 
        return nil 
    end

    -- İsim Temizleme (Örn: "Bandit [Lv. 5]" -> "Bandit")
    -- Bu kısım mobun isminin içindeki sayıları ve parantezleri siler
    local cleanName = targetName:gsub(" %s*[%d+]", ""):gsub(" %s*%(%d+%)", ""):gsub(" %s*%[.*%]", "")
    
    local closestMob = nil
    local shortestDistance = math.huge
    
    local character, hrp, humanoid = Core.GetCharacter()
    if not hrp then return nil end

    -- Arama Alanları: Enemies klasörü veya direkt Workspace
    local searchFolders = {
        Core.Workspace:FindFirstChild("Enemies"),
        Core.Workspace:FindFirstChild("NPCs"),
        Core.Workspace
    }

    for _, folder in pairs(searchFolders) do
        if folder then
            local children = folder:GetChildren()
            for i = 1, #children do
                local mob = children[i]
                
                -- Mobun ismi aradığımız temiz isme benziyor mu?
                if mob:IsA("Model") and (string.find(mob.Name, cleanName) or mob.Name == targetName) then
                    local mobHrp = mob:FindFirstChild("HumanoidRootPart")
                    local mobHum = mob:FindFirstChild("Humanoid")

                    -- Mob yaşıyor mu ve fiziksel olarak orada mı?
                    if mobHrp and mobHum and mobHum.Health > 0 then
                        local distance = (hrp.Position - mobHrp.Position).Magnitude
                        
                        -- En yakındaki mobu seç
                        if distance < shortestDistance then
                            shortestDistance = distance
                            closestMob = mob
                        end
                    end
                end
            end
        end
        -- Eğer en yakın mob bulunduysa aramayı bitir
        if closestMob then break end
    end

    return closestMob
end

return Enemy
