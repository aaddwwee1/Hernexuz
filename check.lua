-- [[ SYSTEM LOGIC BY HERNEXUZ ]] --
local HttpService = game:GetService("HttpService")
local My_HWID = game:GetService("RbxAnalyticsService"):GetClientId()
local Player = game:GetService("Players").LocalPlayer

-- วางลิงก์ที่ก๊อปมาลงในเครื่องหมายคำพูดด้านล่างนี้
local DATABASE_URL = "https://script.google.com/macros/s/AKfycbx4FzbiCXUg4c6cINbgvyNL2dJIfX-PlA2CpZk2hpdwUA6p697zsYUqFZzTqT8rbWU/exec"
local DISCORD_WEBHOOK = "https://discord.com/api/webhooks/1495383746164162580/XKQwGWkbBwcsks7p8QN6Ljclb5coIoLeldkivCWtC-KI9ykfKE17juHs2N2U-OLmLJDx"

local function SendLog(msg, color)
    local data = {
        ["embeds"] = {{
            ["title"] = "Hernexuz Auto-Lock System",
            ["description"] = msg,
            ["color"] = color,
            ["fields"] = {
                {["name"] = "Player", ["value"] = "```" .. Player.Name .. "```", ["inline"] = true},
                {["name"] = "HWID", ["value"] = "```" .. My_HWID .. "```", ["inline"] = false}
            },
            ["footer"] = {["text"] = "Hernexuz Monitoring"},
            ["timestamp"] = os.date("!%Y-%m-%dT%H:%M:%SZ")
        }}
    }
    pcall(function() HttpService:PostAsync(DISCORD_WEBHOOK, HttpService:JSONEncode(data)) end)
end

-- ส่งค่าไปที่ Google Sheets
local success, result = pcall(function()
    return game:HttpGet(DATABASE_URL .. "?hwid=" .. My_HWID .. "&name=" .. Player.Name)
end)

if success then
    if result == "TRUE" then
        -- ถ้ามี HWID ในตารางแล้ว (ผ่าน)
        SendLog("✅ Success: Member Access", 0x00FF00)
        loadstring(game:HttpGet('https://raw.githubusercontent.com/aaddwwee1/Hernexuz/refs/heads/main/Nhk?token=GHSAT0AAAAAAD2NJTKIT6PLTNU5RSWYAVCI2PEXU3Q'))()
    elseif result == "REGISTERED" then
        -- ถ้าเป็นการรันครั้งแรก (ระบบล็อคให้อัตโนมัติ)
        SendLog("🆕 New Registration: Auto-Locked", 0xFFFF00)
        print("------------------------------------------")
        print("ระบบได้บันทึกเครื่องของคุณเรียบร้อยแล้ว!")
        print("------------------------------------------")
        loadstring(game:HttpGet('https://raw.githubusercontent.com/aaddwwee1/Hernexuz/refs/heads/main/Nhk?token=GHSAT0AAAAAAD2NJTKIT6PLTNU5RSWYAVCI2PEXU3Q'))()
    else
        warn("❌ ระบบฐานข้อมูลตอบกลับผิดพลาด")
    end
else
    warn("❌ ไม่สามารถเชื่อมต่อกับ Google Sheets ได้")
end
