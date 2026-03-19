-- [[ IsoHub Config ]] --
getgenv().IsoHubConfig = {
    System = {
        HubName = "IsoHub",
        VisualBypass = true, -- Arayüzde görünecek tasarım amaçlı buton
        AutoSave = true,
        ToggleKey = "RightControl",
        MobileToggle = true
    },
    
    AutoFarm = {
        Enabled = false,        
        AutoQuest = false,
        HasQuest = false, -- Eklediğin satırı buraya, doğru yere koydum
        TargetMob = "",         
        BringMobs = false,      
        Distance = 12,          
        Position = "Above",     
        FastAttack = false      
    },

    Combat = {
        AutoClicker = false,
        KillAura = false
    } -- Tabloyu burada kapatıyoruz
} -- Ana tabloyu burada kapattık. Bu çok önemli!
    Combat = {
        SelectWeapon = "Melee", 
        AutoClick = false,      
        AutoSkills = {          
            Z = false,
            X = false,
            C = false,
            V = false
        }
    },

    -- Otomatik Statü (Auto Stats) Ayarları
    AutoStats = {
        Enabled = false,
        PointsPerTick = 1,      
        Focus = {
            Melee = false,
            Defense = false,
            Sword = false,
            Gun = false,
            BloxFruit = false
        }
    },

    -- Oyuncu Güvenliği (Player Safety)
    Player = {
        AutoSafeZone = false,   
        FleeHealth = 30         
    },

    -- Ekstra Algılama (ESP & Visuals)
    Visuals = {
        ESP_Enabled = false,
        ESP_Players = false,
        ESP_Chests = false,
        ESP_Fruits = false
    }
},

return getgenv().IsoHubConfig
