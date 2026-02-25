local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

-- Nạp 2 file Module vừa tạo
local UIData = require(script:WaitForChild("UIData"))
local UIManager = require(script:WaitForChild("UIManager"))

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Dựng giao diện và lấy các biến Element về
local UI = UIManager.BuildMainUI(playerGui)

-- Kết nối Server
local UpdateStatsEvent = ReplicatedStorage:WaitForChild("Shared"):WaitForChild("Events"):WaitForChild("UpdateStats")
local RequestRollEvent = ReplicatedStorage:WaitForChild("Shared"):WaitForChild("Events"):WaitForChild("RequestRoll")

-- BIẾN GHI NHỚ ĐỘ HIẾM VÀ LOẠI ĐANG CHỜ ROLL
local currentRaceRarity = "Common"
local currentOriginRarity = "Common"
local pendingRoll = nil 

-- Logic khi nhận dữ liệu từ Server
UpdateStatsEvent.OnClientEvent:Connect(function(data)
    UI.Labels.RaceBox.Text = data.Race
    UI.Labels.OriginBox.Text = data.Origin
    
    UI.Stats.Str.Text = "Strength: " .. (data.Stats.Str or 0)
    UI.Stats.Dex.Text = "Dexterity: " .. (data.Stats.Dex or 0)
    UI.Stats.End.Text = "Endurance: " .. (data.Stats.End or 0)
    UI.Stats.Arc.Text = "Arcane: " .. (data.Stats.Arc or 0)
    
    -- XỬ LÝ RACE (Đã gộp chung Text và Màu sắc)
    local raceInfo = UIData.RACE_INFO[data.Race]
    if raceInfo then
        -- Lấy Rarity, nếu trong UIData bạn lỡ quên ghi Rarity thì nó tự gán là "Common" để không bị lỗi
        currentRaceRarity = raceInfo.Rarity or "Common" 
        UI.Labels.RaceBox.TextColor3 = UIData.RARITY_COLORS[currentRaceRarity] or Color3.fromRGB(255, 255, 255)
        
        UI.Labels.Buff.Text = "Race Buffs:\n" .. raceInfo.Buff
        UI.Labels.Skill.Text = "Race Skill: " .. raceInfo.Skill
    else
        currentRaceRarity = "Common"
        UI.Labels.RaceBox.TextColor3 = UIData.RARITY_COLORS["Common"]
        UI.Labels.Buff.Text = "Race Buffs: None"
        UI.Labels.Skill.Text = "Race Skill: None"
    end
    
    -- XỬ LÝ ORIGIN (Đã gộp chung Text và Màu sắc)
    local originInfo = UIData.ORIGIN_INFO[data.Origin]
    if originInfo then
        currentOriginRarity = originInfo.Rarity or "Common"
        UI.Labels.OriginBox.TextColor3 = UIData.RARITY_COLORS[currentOriginRarity] or Color3.fromRGB(255, 255, 255)
        
        UI.Labels.Origin.Text = "Origin Stats: " .. originInfo.Buff .. "\nPassive: " .. originInfo.Passive
    else
        currentOriginRarity = "Common"
        UI.Labels.OriginBox.TextColor3 = UIData.RARITY_COLORS["Common"]
        UI.Labels.Origin.Text = "Origin: None"
    end

    UI.ModelImage.Image = UIData.RACE_MODELS[data.Race] or UIData.RACE_MODELS["None"]
end)

-- HÀM KIỂM TRA ĐỘ HIẾM KHI BẤM NÚT ROLL
local function handleRollRequest(rollType, currentRarity)
    if currentRarity == "Epic" or currentRarity == "Legendary" then
        -- Mở bảng cảnh báo
        pendingRoll = rollType
        UI.Dialog.Message.Text = "You have a [" .. rollType .. "] rarity " .. currentRarity .. "!\nAre you sure you want to discard it and roll again?"
        UI.Dialog.Background.Visible = true
    else
        -- Không phải đồ xịn thì cho Roll thẳng tay
        RequestRollEvent:FireServer(rollType)
    end
end

-- NÚT ROLL CHÍNH (Chỉ giữ lại 1 sự kiện click duy nhất)
UI.Buttons.RaceRoll.MouseButton1Click:Connect(function() 
    handleRollRequest("Race", currentRaceRarity)
end)

UI.Buttons.OriginRoll.MouseButton1Click:Connect(function() 
    handleRollRequest("Origin", currentOriginRarity)
end)

-- NÚT XỬ LÝ CỦA BẢNG CẢNH BÁO
UI.Dialog.Yes.MouseButton1Click:Connect(function()
    if pendingRoll then
        RequestRollEvent:FireServer(pendingRoll) -- Bắn server yêu cầu Roll
        pendingRoll = nil -- Reset lại biến
    end
    UI.Dialog.Background.Visible = false -- Tắt bảng đi
end)

UI.Dialog.No.MouseButton1Click:Connect(function()
    pendingRoll = nil -- Hủy lệnh Roll
    UI.Dialog.Background.Visible = false -- Tắt bảng đi
end)