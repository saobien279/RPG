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
local AddStatEvent = ReplicatedStorage:WaitForChild("Shared"):WaitForChild("Events"):WaitForChild("AddStat")


-- BIẾN GHI NHỚ ĐỘ HIẾM VÀ LOẠI ĐANG CHỜ ROLL
local currentRaceRarity = "Common"
local currentOriginRarity = "Common"
local currentUniqueSkillRarity = "Common"
local currentExtraSkillRarity = "Common"
local currentUniqueSkillRarity = "Common"
local pendingRoll = nil 

-- Logic khi nhận dữ liệu từ Server
UpdateStatsEvent.OnClientEvent:Connect(function(data)
    UI.Labels.RaceBox.Text = data.Race
    UI.Labels.OriginBox.Text = data.Origin

    UI.Labels.Gold.Text = "Gold: " .. (data.Gold or 0)
    UI.Labels.Essence.Text = "Essence: " .. (data.Essence or 0)
    
    
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



    -- 3. Xử lý Skills (Dùng hàm updateSkill cho gọn, xóa bỏ đoạn code thủ công phía trên)
    local function updateSkill(name, labels, rarityRef)
        local info = UIData.SKILL_INFO[name] or UIData.SKILL_INFO["None"]
        labels.Box.Text = name
        labels.Box.TextColor3 = UIData.RARITY_COLORS[info.Rarity]
        labels.Desc.Text = info.Desc .. "\n(" .. info.Buff .. ")"
        
        -- Cập nhật lại biến Rarity toàn cục để handleRollRequest dùng
        if labels.Box == UI.Labels.ExtraSkillBox then
            currentExtraSkillRarity = info.Rarity
        else
            currentUniqueSkillRarity = info.Rarity
        end
    end



    -- Hiển thị số điểm tiềm năng
    UI.Labels.Points.Text = "Points: " .. (data.Points or 0)

    -- Kiểm tra: Nếu có điểm (> 0) thì hiện nút [+], nếu hết điểm thì ẩn đi
    local canAdd = (data.Points or 0) > 0
    UI.Buttons.AddStr.Visible = canAdd
    UI.Buttons.AddDex.Visible = canAdd
    UI.Buttons.AddEnd.Visible = canAdd
    UI.Buttons.AddArc.Visible = canAdd

    
    --Xử Lí EXP
    local expRatio = math.min(1, data.Exp / (data.MaxExp or 100))
    -- Hiệu ứng chạy thanh EXP cho mượt (Tween)
    local TweenService = game:GetService("TweenService")
    TweenService:Create(UI.Labels.ExpFill, TweenInfo.new(0.5), {
        Size = UDim2.fromScale(expRatio, 1)
    }):Play()

    -- Cập nhật chữ hiển thị
    UI.Labels.ExpText.Text = string.format("Lv. %d [ %d / %d ]", data.Level, data.Exp, data.MaxExp)

    updateSkill(data.ExtraSkill, {Box = UI.Labels.ExtraSkillBox, Desc = UI.Labels.ExtraSkillDesc})
    updateSkill(data.UniqueSkill, {Box = UI.Labels.UniqueSkillBox, Desc = UI.Labels.UniqueSkillDesc})

    UI.ModelImage.Image = UIData.RACE_MODELS[data.Race] or UIData.RACE_MODELS["None"]
end)



--STATS
    local function connectStatBtn(btn, statName)
        btn.MouseButton1Click:Connect(function()
            AddStatEvent:FireServer(statName)
        end)
    end

    connectStatBtn(UI.Buttons.AddStr, "Str")
    connectStatBtn(UI.Buttons.AddDex, "Dex")
    connectStatBtn(UI.Buttons.AddEnd, "End")
    connectStatBtn(UI.Buttons.AddArc, "Arc")




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

UI.Buttons.UniqueSkillRoll.MouseButton1Click:Connect(function() 
    handleRollRequest("UniqueSkill", currentUniqueSkillRarity)
end)

UI.Buttons.ExtraSkillRoll.MouseButton1Click:Connect(function()
    handleRollRequest("ExtraSkill", currentExtraSkillRarity)
end)


UI.Buttons.UniqueSkillRoll.MouseButton1Click:Connect(function()
    handleRollRequest("UniqueSkill", currentUniqueSkillRarity)
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


-- XỬ LÝ CHUYỂN TAB
local function switchTab(targetTabName)
    -- 1. Tắt hiển thị CỦA TẤT CẢ CÁC TAB (Duyệt qua hộp Tabs chứ không phải HeaderBtns nữa)
    for _, tab in pairs(UI.Tabs) do
        tab.Visible = false
    end
    
    -- 2. Đưa tất cả các nút trên Header về màu tối
    for _, btn in pairs(UI.HeaderBtns) do
        btn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    end
    
    -- 3. Bật cái Tab được yêu cầu lên (Không cần quan tâm nó có nằm trên Header hay không)
    if UI.Tabs[targetTabName] then
        UI.Tabs[targetTabName].Visible = true
    end
    
    -- 4. Nếu Tab đó có nút trên Header (Main, Area, Inventory) thì làm sáng nút đó lên
    if UI.HeaderBtns[targetTabName] then
        UI.HeaderBtns[targetTabName].BackgroundColor3 = Color3.fromRGB(80, 80, 80)
    end
end

-- 3. Gắn cảm biến click cho 4 cái nút Header
for tabName, btn in pairs(UI.HeaderBtns) do
    btn.MouseButton1Click:Connect(function()
        switchTab(tabName)
    end)
end

for areaName, btn in pairs(UI.AreaBtns) do
    btn.MouseButton1Click:Connect(function()
        -- Khi bấm vào thẻ "Dungeon", gọi hàm switchTab để chuyển qua Tab Dungeon
        switchTab(areaName)
    end)
end

-- 4. Khi vừa vào game, tự động mở Tab "Main"
switchTab("Main")