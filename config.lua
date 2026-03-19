-- [[ IsoHub | Config - FULL & SAFE VERSION ]] --
getgenv().IsoHubConfig = {
    System = {
        HubName = "IsoHub",
        ToggleKey = "RightControl",
        MobileToggle = true,
        VisualBypass = true
    },
    AutoFarm = {
        Enabled = false,
        AutoQuest = false,
        BringMobs = false,
        FastAttack = false,
        HasQuest = false -- BU EKSİKTİ, HATAYI BU VERİYORDU
    },
    Combat = {
        SelectWeapon = "Melee",
        AutoClick = false
    },
    AutoStats = {
        Enabled = false,
        Focus = {
            Melee = false,
            Defense = false,
            BloxFruit = false
        }
    }
}
return getgenv().IsoHubConfig
