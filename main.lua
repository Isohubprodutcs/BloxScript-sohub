-- [[ IsoHub | Blox Fruits Premium Loader ]] --
-- Bu dosya tüm modülleri sırasıyla ve güvenli şekilde bağlar.

local function LoadIsoModule(url)
    local success, result = pcall(function()
        return game:HttpGet(url)
    end)
    
    if success then
        local func, err = loadstring(result)
        if func then
            -- Modülü çalıştır ve hata varsa bildir
            local runSuccess, runError = pcall(func)
            if not runSuccess then
                warn("[IsoHub] Çalıştırma Hatası: " .. url .. " | Hata: " .. tostring(runError))
            end
            return result
        else
            warn("[IsoHub] Sözdizimi Hatası: " .. url .. " | Hata: " .. tostring(err))
        end
    else
        warn("[IsoHub] Sunucuya Bağlanılamadı: " .. url)
    end
end

-- [[ MODÜLLERİ SIRASIYLA YÜKLÜYORUZ ]] --
-- Sıralama Değiştirilmemelidir: Ayarlar -> Çekirdek -> Motorlar -> UI

print("[IsoHub] Sistem başlatılıyor, lütfen bekleyin...")

-- 1. Temel Yapılandırma ve Ayarlar
LoadIsoModule("https://raw.githubusercontent.com/Isohubprodutcs/BloxScript-sohub/refs/heads/main/config.lua")

-- 2. Sistem Çekirdeği (Anti-AFK, Takım Seçici)
LoadIsoModule("https://raw.githubusercontent.com/Isohubprodutcs/BloxScript-sohub/refs/heads/main/core.lua")

-- 3. Hareket ve Hedefleme Motorları
LoadIsoModule("https://raw.githubusercontent.com/Isohubprodutcs/BloxScript-sohub/refs/heads/main/modules/tween.lua")
LoadIsoModule("https://raw.githubusercontent.com/Isohubprodutcs/BloxScript-sohub/refs/heads/main/modules/enemy.lua")

-- 4. Veritabanı ve Savaş Mantığı
LoadIsoModule("https://raw.githubusercontent.com/Isohubprodutcs/BloxScript-sohub/refs/heads/main/modules/autoquest.lua")
LoadIsoModule("https://raw.githubusercontent.com/Isohubprodutcs/BloxScript-sohub/refs/heads/main/modules/autofarm.lua")

-- 5. Karakter Gelişimi
LoadIsoModule("https://raw.githubusercontent.com/Isohubprodutcs/BloxScript-sohub/refs/heads/main/modules/autostats.lua")

-- 6. VE FİNAL: Profesyonel Arayüz (UI)
-- Tüm modüller hazır olduktan sonra menüyü ekrana basıyoruz.
LoadIsoModule("https://raw.githubusercontent.com/Isohubprodutcs/BloxScript-sohub/refs/heads/main/modules/ui.lua")

-- [[ SİSTEM HAZIR ]] --
local Config = getgenv().IsoHubConfig
print("-----------------------------------------")
print("[IsoHub] v1.0 Başarıyla Yüklendi!")
print("[IsoHub] Yapımcı: Isohub Products")
print("[IsoHub] Menü Tuşu: " .. tostring(Config.System.ToggleKey or "RightControl"))
print("-----------------------------------------")
