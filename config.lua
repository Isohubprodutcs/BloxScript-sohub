-- [[ config.lua ]] --
-- IsoHub Ana Ayar Dosyası
-- Bu dosya sadece değişkenleri ve ayarları tutar. Fonksiyon içermez.

getgenv().IsoHubConfig = {
    -- Temel Sistem ve Arayüz Ayarları
    System = {
        HubName = "IsoHub",
        VisualBypass = true, -- Arayüzde görünecek rol yapma/tasarım amaçlı bypass butonu
        AutoSave = true,     -- Ayarları kaydetme özelliği
        ToggleKey = "RightControl", -- PC için menüyü açıp kapatma tuşu
        MobileToggle = true  -- MOBİL İÇİN EKRANDA GÖRÜNEN AÇMA/KAPAMA BUTONU
    },
    
    -- Otomatik Kasılma (Auto Farm) Ayarları
    AutoFarm = {
        Enabled = false,        
        AutoQuest = false,      
        TargetMob = "",         
        BringMobs = false,      
        Distance = 12,          
        Position = "Above",     
        FastAttack = false      
    },

    -- Savaş ve Silah (Combat) Ayarları
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
}

return getgenv().IsoHubConfig
