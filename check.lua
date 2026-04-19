-- [[ HERNEXUZ KEY SYSTEM ]] --
local HttpService = game:GetService("HttpService")
local My_HWID = game:GetService("RbxAnalyticsService"):GetClientId()

-- เปลี่ยน URL เป็นลิงก์ Web App ของคุณ
local DATABASE_URL = "ใส่_WEB_APP_URL_ของคุณ"
local My_Key = _G.Key or ""

if My_Key == "" then
    warn("❌ กรุณาใส่คีย์ใน _G.Key ก่อนรันสคริปต์!")
    return
end

local success, result = pcall(function()
    return game:HttpGet(DATABASE_URL .. "?key=" .. My_Key .. "&hwid=" .. My_HWID)
end)

if success then
    if result == "TRUE" or result == "REGISTERED" then
        print("✅ คีย์ถูกต้อง! กำลังโหลดสคริปต์...")
        -- ลิงก์สคริปต์หลักของคุณ (Nhk)
        loadstring(game:HttpGet("https://raw.githubusercontent.com/aaddwwee1/Hernexuz/main/Nhk"))()
    elseif result == "WRONG_HWID" then
        warn("❌ คีย์นี้ถูกล็อคไว้กับเครื่องอื่นแล้ว!")
    elseif result == "INVALID_KEY" then
        warn("❌ คีย์ไม่ถูกต้อง!")
    end
else
    warn("❌ ไม่สามารถเชื่อมต่อกับเซิร์ฟเวอร์ฐานข้อมูลได้")
end
