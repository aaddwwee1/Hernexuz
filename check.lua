-- [[ HERNEXUZ AUTO-LOCK SYSTEM ]] --
local HttpService = game:GetService("HttpService")
local My_HWID = game:GetService("RbxAnalyticsService"):GetClientId()
local Player = game:GetService("Players").LocalPlayer

-- 1. ลิงก์ Web App จาก Google Sheets ของคุณ
local DATABASE_URL = "https://script.google.com/macros/s/AKfycbzA6DrnUXcmLySb_MsMAOhw3nUYZHCUNnGD_CYQBfbXQSsKmvYowNm-_XL4lKKpkdX2KA/exec"
-- 2. ลิงก์สคริปต์หลักที่คุณต้องการให้รันเมื่อผ่าน (GitHub Link)
local MAIN_SCRIPT_URL = "https://raw.githubusercontent.com/aaddwwee1/Hernexuz/main/Nhk" 
-- 3. Discord Webhook ของคุณ
local DISCORD_WEBHOOK = "https://discord.com/api/webhooks/1495383746164162580/XKQwGWkbBwcsks7p8QN6Ljclb5coIoLeldkivCWtC-KI9ykfKE17juHs2N2U-OLmLJDx"

local function SendLog(msg, color)
    local data = {
        ["embeds"] = {{
            ["title"] = "Hernexuz | System Log",
            ["description"] = "สถานะ: **" .. msg .. "**",
            ["color"] = color,
            ["fields"] = {
                {["name"] = "Player Name", ["value"] = "```" .. Player.Name .. "```", ["inline"] = true},
                {["name"] = "HWID", ["value"] = "```" .. My_HWID .. "```", ["inline"] = false}
            },
            ["timestamp"] = os.date("!%Y-%m-%dT%H:%M:%SZ")
        }}
    }
    pcall(function()
        HttpService:PostAsync(DISCORD_WEBHOOK, HttpService:JSONEncode(data))
    end)
end

-- ตรวจสอบ HWID กับ Google Sheets
local success, result = pcall(function()
    return game:HttpGet(DATABASE_URL .. "?hwid=" .. My_HWID .. "&name=" .. Player.Name)
end)

if success then
    if result == "TRUE" or result == "REGISTERED" then
        -- ถ้าเป็นเจ้าของเดิม หรือ ลงทะเบียนใหม่สำเร็จ -> ให้รันสคริปต์หลัก
        local statusText = (result == "TRUE") and "เข้าใช้งานสำเร็จ" or "ลงทะเบียนเครื่องใหม่สำเร็จ"
        SendLog(statusText, (result == "TRUE") and 0x00FF00 or 0xFFFF00)
        
        -- รันสคริปต์หลักจาก GitHub ของคุณ
        loadstring(game:HttpGet(MAIN_SCRIPT_URL))()
    
    elseif result == "LOCKED" then
        -- กรณีเครื่องไม่ตรง
        SendLog("LOCKED (พยายามเข้าใช้งาน)", 0xFF0000)
        warn("❌ [Hernexuz] สคริปต์นี้ถูกล็อกไว้กับเครื่องอื่นแล้ว")
        print("HWID ของคุณคือ: " .. My_HWID)
    end
else
    warn("❌ [Hernexuz] ไม่สามารถเชื่อมต่อฐานข้อมูลได้")
end
