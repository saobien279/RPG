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
    for _, n in {"Main", "Area", "Inventory"} do createHeaderBtn(n) end

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
    -- 4.1 THIẾT KẾ TAB MAIN (Giữ nguyên đồ cũ)
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

    local function createStat(name)
        local lbl = Instance.new("TextLabel")
        lbl.Text = name .. ": 0"
        lbl.Size = UDim2.new(1, 0, 0.15, 0)
        lbl.BackgroundTransparency = 1
        lbl.TextColor3 = Color3.fromRGB(255, 255, 255)
        lbl.Font = Enum.Font.Antique
        lbl.TextXAlignment = Enum.TextXAlignment.Left
        lbl.TextScaled = true
        lbl.Parent = statsContainer
        return lbl
    end

    local function createTitle(name)
        local lbl = Instance.new("TextLabel")
        lbl.Text = name 
        lbl.Size = UDim2.new(1, 0, 0.20, 0)
        lbl.BackgroundTransparency = 1
        lbl.TextColor3 = Color3.fromRGB(255, 255, 255)
        lbl.Font = Enum.Font.Antique
        lbl.TextXAlignment = Enum.TextXAlignment.Center
        lbl.TextScaled = true
        lbl.Parent = statsContainer
        return lbl
    end

    createTitle("Character Stats")
    local sStr = createStat("Strength")
    local sDex = createStat("Dexterity")
    local sEnd = createStat("Endurance")
    local sArc = createStat("Arcane")

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
        lbl.Size = UDim2.new(0.95, 0, 0.20, 0)
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
    local uText = createInfoText(Color3.fromRGB(200, 200, 200))

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

    local rBox, rBtn = rollGrp("Race", 0.05)        -- Nằm ở trên cùng (5%)
    local oBox, oBtn = rollGrp("Origin", 0.35)      -- Nằm ở giữa (35%)
    local uBox, uBtn = rollGrp("UniqueSkill", 0.65) -- Nằm ở dưới (65%) <-- ĐÂY CHÍNH LÀ NÓ

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

     -- 6. TRẢ VỀ CÁC PHẦN TỬ CẦN THIẾT CHO LOGIC
     -- Trả về các phần tử liên quan đến Stats
    -- Trả về tất cả các phần tử cần tương tác
    return {
        HeaderBtns = headerBtns, -- Phải có dòng này
        Tabs = tabs,             -- Phải có dòng này
        AreaBtns = areaBtns,    
        Stats = { Str = sStr, Dex = sDex, End = sEnd, Arc = sArc },
        Labels = { RaceBox = rBox, OriginBox = oBox, UniqueSkillBox = uBox, Buff = bText, Skill = kText, Origin = oText, UniqueSkillDesc = uText },
        ModelImage = modelImg,
        Buttons = { RaceRoll = rBtn, OriginRoll = oBtn, UniqueSkillRoll = uBtn },
        Dialog = { Background = confirmBg, Message = confirmText, Yes = btnYes, No = btnNo }
    }
end

return UIManager