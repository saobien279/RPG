local UIManager = {}

function UIManager.BuildMainUI(playerGui)
    -- 1. SETUP SCREEN GUI
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "RPG_UI"
    screenGui.IgnoreGuiInset = true
    screenGui.Parent = playerGui

    -- 2. NỀN
    local background = Instance.new("ImageLabel")
    background.Image = "rbxassetid://130329682866275" 
    background.Size = UDim2.fromScale(1, 1)
    background.BackgroundTransparency = 1
    background.ScaleType = Enum.ScaleType.Stretch
    background.Parent = screenGui

   -- =====================================
    -- 3. HEADER (Giảm xuống 3 nút)
    -- =====================================
    local header = Instance.new("Frame")
    header.Size = UDim2.new(1, 0, 0.08, 0)
    header.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    header.Parent = background

    local headerLayout = Instance.new("UIListLayout")
    headerLayout.FillDirection = Enum.FillDirection.Horizontal
    headerLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    headerLayout.VerticalAlignment = Enum.VerticalAlignment.Center
    headerLayout.Padding = UDim.new(0.01, 0)
    headerLayout.Parent = header

    local headerBtns = {}

    local function createHeaderBtn(name)
        local btn = Instance.new("TextButton")
        btn.Text = name:upper()
        btn.Size = UDim2.new(0.15, 0, 0.7, 0) -- Cho nút to ra một chút vì giờ chỉ có 3 nút
        btn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        btn.Font = Enum.Font.Antique
        btn.TextScaled = true
        btn.Parent = header
        headerBtns[name] = btn
    end
    -- CHỈ TẠO 3 NÚT: MAIN, AREA, INVENTORY
    for _, n in {"Main", "Area", "Skills", "Inventory"} do createHeaderBtn(n) end

    -- 3.1 KHU VỰC HIỂN THỊ TIỀN (Gold và Essence) HEADER
    local moneyFrame = Instance.new("Frame")
    moneyFrame.Size = UDim2.fromScale(0.3, 1)
    moneyFrame.Position = UDim2.fromScale(0.7, 0)
    moneyFrame.BackgroundTransparency = 1
    moneyFrame.Parent = header

    local moneyLayout = Instance.new("UIListLayout")
    moneyLayout.FillDirection = Enum.FillDirection.Horizontal
    moneyLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
    moneyLayout.VerticalAlignment = Enum.VerticalAlignment.Center
    moneyLayout.Padding = UDim.new(0.05, 0)
    moneyLayout.Parent = moneyFrame

    local function createMoneyLabel(color)
        local lbl = Instance.new("TextLabel")
        lbl.Size = UDim2.fromScale(0.4, 0.6)
        lbl.TextColor3 = color
        lbl.BackgroundTransparency = 1
        lbl.TextScaled = true
        lbl.Font = Enum.Font.Antique
        lbl.Parent = moneyFrame
        return lbl
    end

    local goldLbl = createMoneyLabel(Color3.fromRGB(255, 215, 0)) -- Màu vàng Gold
    local essenceLbl = createMoneyLabel(Color3.fromRGB(0, 255, 255)) -- Màu xanh Essence





    -- =====================================
    -- 4. HỆ THỐNG TAB
    -- =====================================
    local tabContainer = Instance.new("Frame")
    tabContainer.Position = UDim2.fromScale(0.5, 0.54)
    tabContainer.AnchorPoint = Vector2.new(0.5, 0.5)
    tabContainer.Size = UDim2.fromScale(0.9, 0.85)
    tabContainer.BackgroundTransparency = 1
    tabContainer.Parent = background

    local tabs = {}

    local function createTab(name)
        local tab = Instance.new("Frame")
        tab.Name = name .. "Tab"
        tab.Size = UDim2.fromScale(1, 1)
        tab.BackgroundTransparency = 1
        tab.Visible = false
        tab.Parent = tabContainer
        tabs[name] = tab
        return tab
    end

    -- ĐÚC CÁC TAB CHÍNH VÀ TAB PHỤ
    local mainTab = createTab("Main")
    local areaTab = createTab("Area")
    local inventoryTab = createTab("Inventory")
    
    -- Các Tab phụ nằm bên trong Area
    local dungeonTab = createTab("Dungeon")
    local smithTab = createTab("Smith")
    local merchantTab = createTab("Merchant")

    -- Thêm chữ chờ thi công cho Inventory và các tab phụ
    for _, tabName in {"Inventory", "Dungeon", "Smith", "Merchant"} do
        local txt = Instance.new("TextLabel")
        txt.Text = tabName:upper() .. " IS UNDER CONSTRUCTION"
        txt.Size = UDim2.fromScale(1, 1)
        txt.TextColor3 = Color3.fromRGB(200, 200, 200)
        txt.BackgroundTransparency = 1
        txt.Font = Enum.Font.Antique
        txt.TextScaled = true
        txt.Parent = tabs[tabName]
    end

    mainTab.Visible = true

    -- =====================================
    -- 4.1 THIẾT KẾ TAB ROLL RACE (Giữ nguyên đồ cũ)
    -- =====================================
    local mainLayout = Instance.new("UIListLayout")
    mainLayout.FillDirection = Enum.FillDirection.Horizontal
    mainLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    mainLayout.Padding = UDim.new(0.02, 0)
    mainLayout.Parent = mainTab  

    local function createColumn(width)
        local col = Instance.new("Frame")
        col.Size = UDim2.new(width, -20, 1, 0)
        col.BackgroundColor3 = Color3.fromRGB(150, 150, 150)
        col.BackgroundTransparency = 0.5
        col.Parent = mainTab
        return col
    end

    local statsCol = createColumn(0.3)
    local raceCol = createColumn(0.3)
    local rollCol = createColumn(0.35)

    -- =====================================
    -- 4.2 THIẾT KẾ TAB AREA (3 Thẻ to bằng nhau)
    -- =====================================
    local areaLayout = Instance.new("UIListLayout")
    areaLayout.FillDirection = Enum.FillDirection.Horizontal
    areaLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    areaLayout.VerticalAlignment = Enum.VerticalAlignment.Center
    areaLayout.Padding = UDim.new(0.03, 0)
    areaLayout.Parent = areaTab

    local areaBtns = {}

    local function createAreaCard(name, color)
        local cardBtn = Instance.new("TextButton")
        cardBtn.Name = name .. "Card"
        cardBtn.Size = UDim2.new(0.31, 0, 0.9, 0) -- Chiếm 31% chiều ngang, 90% chiều cao
        cardBtn.BackgroundColor3 = color
        cardBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        cardBtn.Font = Enum.Font.Antique
        cardBtn.TextScaled = true
        cardBtn.Text = name:upper()
        cardBtn.Parent = areaTab

        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(0.05, 0) -- Bo tròn góc cho thẻ
        corner.Parent = cardBtn

        areaBtns[name] = cardBtn
    end

    createAreaCard("Dungeon", Color3.fromRGB(80, 40, 40))
    createAreaCard("Smith", Color3.fromRGB(60, 60, 60))
    createAreaCard("Merchant", Color3.fromRGB(40, 80, 40))

    -- [CỘT STATS]
    local statsContainer = Instance.new("Frame")
    statsContainer.Size = UDim2.fromScale(0.9, 0.9)
    statsContainer.Position = UDim2.fromScale(0.05, 0.05)
    statsContainer.BackgroundTransparency = 1
    statsContainer.Parent = statsCol

    local statsLayout = Instance.new("UIListLayout")
    statsLayout.Padding = UDim.new(0.05, 0)
    statsLayout.Parent = statsContainer
    statsLayout.SortOrder = Enum.SortOrder.LayoutOrder -- Ép nó sắp xếp theo số thứ tự mình đặt

    local function createTitle(name, order)
        local lbl = Instance.new("TextLabel")
        lbl.Text = name 
        lbl.Size = UDim2.new(1, 0, 0.20, 0)
        lbl.BackgroundTransparency = 1
        lbl.TextColor3 = Color3.fromRGB(255, 255, 255)
        lbl.Font = Enum.Font.Antique
        lbl.TextXAlignment = Enum.TextXAlignment.Center
        lbl.TextScaled = true
        lbl.Parent = statsContainer
        lbl.LayoutOrder = order
        return lbl
    end


    local function createStat(name, order)
    local container = Instance.new("Frame")
    container.Size = UDim2.new(1, 0, 0.12, 0)
    container.BackgroundTransparency = 1
    container.LayoutOrder = order
    container.Parent = statsContainer

    local lbl = Instance.new("TextLabel")
    lbl.Text = name .. ": 0"
    lbl.Size = UDim2.fromScale(0.7, 1)
    lbl.BackgroundTransparency = 1
    lbl.TextColor3 = Color3.fromRGB(255, 255, 255)
    lbl.Font = Enum.Font.Antique
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.TextScaled = true
    lbl.Parent = container

    local btn = Instance.new("TextButton")
    btn.Text = "[+]"
    btn.Size = UDim2.fromScale(0.25, 0.8)
    btn.Position = UDim2.fromScale(0.75, 0.1)
    btn.BackgroundColor3 = Color3.fromRGB(50, 80, 50)
    btn.TextColor3 = Color3.fromRGB(200, 255, 200)
    btn.TextScaled = true
    btn.Visible = false -- Mặc định ẩn, chỉ hiện khi có Point
    btn.Parent = container

    return lbl, btn
end

    -- Thêm một nhãn hiện số điểm tiềm năng còn dư lên trên đầu
    local pLabel = Instance.new("TextLabel")
    pLabel.Text = "Points: 0"
    pLabel.Size = UDim2.new(1, 0, 0.1, 0)
    pLabel.TextColor3 = Color3.fromRGB(255, 255, 0)
    pLabel.BackgroundTransparency = 1
    pLabel.TextScaled = true
    pLabel.Parent = statsContainer
    pLabel.LayoutOrder = 6


    -- 1. TITLE TRÊN CÙNG (Số 1)
    createTitle("Character Stats", 1)

    -- 2. CÁC STATS Ở GIỮA (Số 2, 3, 4, 5)
    local sStr, bStr = createStat("Strength", 2)
    local sDex, bDex = createStat("Dexterity", 3)
    local sEnd, bEnd = createStat("Endurance", 4)
    local sArc, bArc = createStat("Arcane", 5)

    -- [CỘT RACE]
    local modelImg = Instance.new("ImageLabel")
    modelImg.Size = UDim2.fromScale(0.9, 0.45)
    modelImg.Position = UDim2.fromScale(0.05, 0.05)
    modelImg.BackgroundTransparency = 1
    modelImg.ScaleType = Enum.ScaleType.Fit 
    modelImg.Parent = raceCol

    local infoBox = Instance.new("Frame")
    infoBox.Size = UDim2.fromScale(0.9, 0.45)
    infoBox.Position = UDim2.fromScale(0.05, 0.55)
    infoBox.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    infoBox.Parent = raceCol

    local infoLayout = Instance.new("UIListLayout")
    infoLayout.FillDirection = Enum.FillDirection.Vertical
    infoLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    infoLayout.Padding = UDim.new(0.05, 0)
    infoLayout.Parent = infoBox

    --Check Padding sau
    local infoPadding = Instance.new("UIPadding")
    infoPadding.PaddingTop = UDim.new(0.05, 0)
    infoPadding.Parent = infoBox

    local function createInfoText(color)
        local lbl = Instance.new("TextLabel")
        lbl.Size = UDim2.new(0.95, 0, 0.30, 0)
        lbl.TextColor3 = color
        lbl.BackgroundTransparency = 1
        lbl.TextScaled = true
        lbl.TextWrapped = true
        lbl.Parent = infoBox
        return lbl
    end

    local bText = createInfoText(Color3.fromRGB(200, 200, 200))
    local kText = createInfoText(Color3.fromRGB(150, 255, 150))
    local oText = createInfoText(Color3.fromRGB(200, 200, 200))

    -- [CỘT ROLL]
    local function rollGrp(name, y)
        local box = Instance.new("TextLabel")
        box.Text = "None"
        box.Size = UDim2.fromScale(0.7, 0.12)
        box.Position = UDim2.fromScale(0.15, y)
        box.BackgroundColor3 = Color3.fromRGB(60, 40, 40)
        box.TextColor3 = Color3.fromRGB(255, 255, 255)
        box.TextScaled = true
        box.Parent = rollCol
        
        local btn = Instance.new("TextButton")
        btn.Text = "ROLL"
        btn.Size = UDim2.fromScale(0.4, 0.1)
        btn.Position = UDim2.fromScale(0.3, y + 0.15)
        btn.BackgroundColor3 = Color3.fromRGB(80, 50, 50)
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        btn.TextScaled = true
        btn.Parent = rollCol
        return box, btn
    end

    local rBox, rBtn = rollGrp("Race", 0.15)      
    local oBox, oBtn = rollGrp("Origin", 0.55)      

    -- =====================================
    -- 5. BẢNG CẢNH BÁO (CONFIRM DIALOG)
    -- =====================================
    local confirmBg = Instance.new("Frame")
    confirmBg.Size = UDim2.fromScale(1, 1)
    confirmBg.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    confirmBg.BackgroundTransparency = 0.5 -- Phủ nền đen mờ
    confirmBg.ZIndex = 10 -- Ép nó nổi lên trên tất cả mọi thứ
    confirmBg.Visible = false -- Mặc định tàng hình
    confirmBg.Parent = screenGui

    local confirmBox = Instance.new("Frame")
    confirmBox.Size = UDim2.fromScale(0.35, 0.25)
    confirmBox.Position = UDim2.fromScale(0.5, 0.5)
    confirmBox.AnchorPoint = Vector2.new(0.5, 0.5)
    confirmBox.BackgroundColor3 = Color3.fromRGB(40, 30, 30)
    confirmBox.ZIndex = 11
    confirmBox.Parent = confirmBg

    local uiCorner = Instance.new("UICorner")
    uiCorner.CornerRadius = UDim.new(0.1, 0)
    uiCorner.Parent = confirmBox

    local confirmText = Instance.new("TextLabel")
    confirmText.Size = UDim2.fromScale(0.9, 0.5)
    confirmText.Position = UDim2.fromScale(0.05, 0.1)
    confirmText.BackgroundTransparency = 1
    confirmText.TextColor3 = Color3.fromRGB(255, 255, 255)
    confirmText.Font = Enum.Font.Antique
    confirmText.TextScaled = true
    confirmText.TextWrapped = true
    confirmText.ZIndex = 12
    confirmText.Parent = confirmBox

    local btnYes = Instance.new("TextButton")
    btnYes.Text = "YES"
    btnYes.Size = UDim2.fromScale(0.4, 0.2)
    btnYes.Position = UDim2.fromScale(0.07, 0.7)
    btnYes.BackgroundColor3 = Color3.fromRGB(150, 50, 50)
    btnYes.TextColor3 = Color3.fromRGB(255, 255, 255)
    btnYes.Font = Enum.Font.Antique
    btnYes.TextScaled = true
    btnYes.ZIndex = 12
    btnYes.Parent = confirmBox

    local btnNo = Instance.new("TextButton")
    btnNo.Text = "NO"
    btnNo.Size = UDim2.fromScale(0.4, 0.2)
    btnNo.Position = UDim2.fromScale(0.53, 0.7)
    btnNo.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    btnNo.TextColor3 = Color3.fromRGB(255, 255, 255)
    btnNo.Font = Enum.Font.Antique
    btnNo.TextScaled = true
    btnNo.ZIndex = 12
    btnNo.Parent = confirmBox












    --SKILLS
    local skillTab = createTab("Skills")

    -- Layout cho Tab Skills (xếp dọc cho đẹp)
    local skillLayout = Instance.new("UIListLayout")
    skillLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    skillLayout.VerticalAlignment = Enum.VerticalAlignment.Center
    skillLayout.Padding = UDim.new(0.05, 0)
    skillLayout.Parent = skillTab

    -- Hàm tạo khu vực Roll riêng cho Tab Skill (to hơn cho ngầu)
    local function createSkillRollGroup(name)
    local container = Instance.new("Frame")
    container.Size = UDim2.fromScale(0.8, 0.4)
    container.BackgroundTransparency = 1
    container.Parent = skillTab

    local title = Instance.new("TextLabel")
    title.Text = name:upper()
    title.Size = UDim2.fromScale(1, 0.2)
    title.BackgroundTransparency = 1
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.TextScaled = true
    title.Parent = container

    local box = Instance.new("TextLabel")
    box.Text = "None"
    box.Size = UDim2.fromScale(0.7, 0.3)
    box.Position = UDim2.fromScale(0.15, 0.25)
    box.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
    box.TextColor3 = Color3.fromRGB(255, 255, 255)
    box.TextScaled = true
    box.Parent = container

    local btn = Instance.new("TextButton")
    btn.Text = "ROLL " .. name:upper()
    btn.Size = UDim2.fromScale(0.4, 0.2)
    btn.Position = UDim2.fromScale(0.3, 0.6)
    btn.BackgroundColor3 = Color3.fromRGB(50, 50, 80)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextScaled = true
    btn.Parent = container

    local desc = Instance.new("TextLabel")
    desc.Text = ""
    desc.Size = UDim2.fromScale(1, 0.25)
    desc.Position = UDim2.fromScale(0, 0.85)
    desc.BackgroundTransparency = 1
    desc.TextColor3 = Color3.fromRGB(200, 200, 200)
    desc.TextScaled = true
    desc.Parent = container

    return box, btn, desc
end

    local eBox, eBtn, eDesc = createSkillRollGroup("Extra Skill")
    local uBox, uBtn, uDesc = createSkillRollGroup("Unique Skill")

     -- 6. TRẢ VỀ CÁC PHẦN TỬ CẦN THIẾT CHO LOGIC
     -- Trả về các phần tử liên quan đến Stats
    -- Trả về tất cả các phần tử cần tương tác
--     return {
--         HeaderBtns = headerBtns, -- Phải có dòng này
--         Tabs = tabs,             -- Phải có dòng này
--         AreaBtns = areaBtns,    
--         Stats = { Str = sStr, Dex = sDex, End = sEnd, Arc = sArc },
--         Labels = { RaceBox = rBox, OriginBox = oBox, UniqueSkillBox = uBox, Buff = bText, Skill = kText, Origin = oText, UniqueSkillDesc = uText },
--         ModelImage = modelImg,
--         Buttons = { RaceRoll = rBtn, OriginRoll = oBtn, UniqueSkillRoll = uBtn },
--         Dialog = { Background = confirmBg, Message = confirmText, Yes = btnYes, No = btnNo }
--     }
-- end



--EXP BAR
local expBack = Instance.new("Frame")
expBack.Name = "EXPBar"
expBack.Size = UDim2.fromScale(0.4, 0.02) -- Độ mỏng của thanh
expBack.Position = UDim2.fromScale(0.5, 0.98) -- Nằm sát đáy màn hình
expBack.AnchorPoint = Vector2.new(0.5, 0.5)
expBack.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
expBack.BorderSizePixel = 0
expBack.Parent = background

local expFill = Instance.new("Frame")
expFill.Name = "Fill"
expFill.Size = UDim2.fromScale(0, 1) -- Bắt đầu bằng 0
expFill.BackgroundColor3 = Color3.fromRGB(0, 200, 255) -- Màu xanh ma tố
expFill.BorderSizePixel = 0
expFill.Parent = expBack

local expLabel = Instance.new("TextLabel")
expLabel.Size = UDim2.fromScale(1, 1)
expLabel.BackgroundTransparency = 1
expLabel.Text = "Lv. 1 [ 0 / 100 ]"
expLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
expLabel.TextScaled = true
expLabel.Font = Enum.Font.Code
expLabel.Parent = expBack


    return {
            HeaderBtns = headerBtns,
            Tabs = tabs,
            AreaBtns = areaBtns,
            
            -- Các chỉ số chiến đấu thực tế (Atk, HP, Crit...) - Để hiện ở chỗ khác nếu cần
            Stats = { 
                Str = sStr, 
                Dex = sDex, 
                End = sEnd, 
                Arc = sArc 
            },

            Labels = { 
                -- Các nhãn chính
                RaceBox = rBox, 
                OriginBox = oBox, 
                Buff = bText, 
                Skill = kText, 
                Origin = oText,
                
                -- Nhãn điểm tiềm năng
                Points = pLabel, -- <--- PHẢI CÓ để hiện "Points: 5"

                -- Nhãn Skill (Tab Skills)
                ExtraSkillBox = eBox,
                ExtraSkillDesc = eDesc,
                UniqueSkillBox = uBox,
                UniqueSkillDesc = uDesc,

                -- Tiền tệ và EXP
                Gold = goldLbl,
                Essence = essenceLbl,
                ExpFill = expFill,
                ExpText = expLabel
            },

            Buttons = { 
                -- Nút Roll
                RaceRoll = rBtn, 
                OriginRoll = oBtn,
                ExtraSkillRoll = eBtn,
                UniqueSkillRoll = uBtn,

                -- Nút cộng điểm [+] (Để init.client.lua kết nối Click)
                AddStr = bStr, -- <--- Đưa nút bStr vào đây
                AddDex = bDex, 
                AddEnd = bEnd, 
                AddArc = bArc 
            },

            Dialog = { 
                Background = confirmBg, 
                Message = confirmText, 
                Yes = btnYes, 
                No = btnNo 
            },
            
            ModelImage = modelImg
        }
    end
return UIManager