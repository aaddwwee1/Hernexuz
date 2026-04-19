-- [[ Logic อยู่บน GitHub ทั้งหมด ]] --
local User_Key = _G.User_Key
local HttpService = game:GetService("HttpService")

-- ลิงก์ที่เก็บค่า script_key = "..."
local KEY_URL = "https://raw.githubusercontent.com/aaddwwee1/Hernexuz/refs/heads/main/HNZ%20KEY?token=GHSAT0AAAAAAD2NJTKIWW3V7KUAMXPSRBHW2PEXITQ"

local success, content = pcall(function() return game:HttpGet(KEY_URL) end)

if success then
    local serverKey = string.match(content, 'script_key%s*=%s*"([^"]+)"')
    
    if serverKey and User_Key == serverKey then
        print("✅ Hernexuz: Access Granted!")
        -- รันสคริปต์หลักทันทีเมื่อคีย์ถูกต้อง
        loadstring(game:HttpGet('https://raw.githubusercontent.com/aaddwwee1/Hernexuz/refs/heads/main/Nhk?token=GHSAT0AAAAAAD2NJTKJZAT3V4DOVPUAV5TA2PEXIKQ'))()
    else
        warn("❌ Hernexuz: Invalid Key or Key Expired!")
    end
else
    warn("❌ Hernexuz: Connection Error!")
end
