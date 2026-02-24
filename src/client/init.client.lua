local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- 0. DỮ LIỆU RACE (Đã sửa lỗi cú pháp và cập nhật theo tài liệu)
local RACE_INFO = {
    ["Human"] = {
        Buff = "1. +5% EXP earned\n2. +5% All Stats",
        Skill = "Adaptability: Restores 2 Energy"
    },
    ["Orc"] = {
        Buff = "1. +10% Max Health\n2. +5% Physical Damage",
        Skill = "Frenzy: +20% Phys DMG (3 turns)"
    },
    ["Elf"] = {
        Buff = "1. +10% Magic & Phys DMG\n2. +5% Critical Rate",
        Skill = "Nature's Blessing : 15% DMG Buff for 4 turns"
    },
    ["Dwarf"] = {
        Buff = "1. +10% Phys Def\n2. 15% CC Resistance",
        Skill = "Fortify: Shield (10% Max HP)"
    },
    ["Undead"] = {
        Buff = "1. +15% Dark/Poison DMG\n2. 20% Revive chance",
        Skill = "Death Breath: -30% Enemy Healing"
    },
    ["Lizardfolk"] = {
        Buff = "1. 3% HP Regen/turn\n2. +10% DMG if HP < 50%",
        Skill = "Tail Sweep: -20% Target DMG"
    },
    ["Demon"] = {
        Buff = "1. +15% Crit DMG\n2. +2% DMG per kill",
        Skill = "Blood Pact: 10% HP for +30% DMG"
    },
    ["Celestial"] = {
        Buff = "1. +15% Heal power\n2. -10% Magic DMG taken",
        Skill = "Holy Aegis: Cleanse & +5% Mana"
    },
    ["Dragonkin"] = {
        Buff = "1. Dragon Awe: -10% Enemy Stats\n2. Sky Dragon: +15% All Stats",
        Skill = "Dragon Fire: AoE & -30% Defense"
    }
}

local RACE_MODELS = {
    ["Human"] = "rbxassetid://93825679812931",
    ["Orc"] = "rbxassetid://135547138162212",
    ["Elf"] = "rbxassetid://135381458799447",
    ["Dwarf"] = "rbxassetid://82378365109549",
    ["Demon"] = "rbxassetid://127071815896821",
    ["Celestial"] = "rbxassetid://127793662530681",
    ["Undead"] = "rbxassetid://123378480910456",
    ["Lizardfolk"] = "rbxassetid://117958946510755",
    ["Dragonkin"] = "rbxassetid://77950129143543",
    ["None"] = "rbxassetid://0",
}

local ORIGIN_INFO = {
    ["Farmer"] = {
        Buff = "+10% Max Health", -- [cite: 29]
        Passive = "Endurance: +20% Energy Regen" -- [cite: 29]
    },
    ["Smith"] = {
        Buff = "+8% Physical Damage", -- [cite: 29]
        Passive = "Weapon Mastery: +10% Weapon Stats" -- [cite: 29]
    },
    ["Apprentice"] = {
        Buff = "+10% Magic Damage", -- [cite: 29]
        Passive = "Focus: +10% DMG to CC'd enemies" -- [cite: 29]
    },
    ["Soldier"] = {
        Buff = "+8% Attack & Defense", -- [cite: 31]
        Passive = "Discipline: -10% DMG taken" -- [cite: 31]
    },
    ["Grave Robber"] = {
        Buff = "+12% Crit Rate", -- [cite: 31]
        Passive = "Keen: +8% Crit Rate" -- [cite: 31]
    },
    ["Acolyte"] = {
        Buff = "+15% Healing Effect", -- [cite: 31]
        Passive = "Devout: +25% Healing, 5% to Shield" -- [cite: 31]
    },
    ["Noble"] = {
        Buff = "+8% All Stats", -- [cite: 33]
        Passive = "Authority: +15% Gold from all sources" -- [cite: 33]
    },
    ["Ruin Hunter"] = {
        Buff = "+15% Damage", -- [cite: 33]
        Passive = "Discovery: +10% Crit Rate" -- [cite: 33]
    },
    ["Wanderer"] = {
        Buff = "+15% Max Health", -- [cite: 33]
        Passive = "Experience: -5% DMG taken for team" -- [cite: 33]
    },
    ["Fallen Knight"] = {
        Buff = "+20% Physical Damage", -- [cite: 35]
        Passive = "Revenge: +25% Phys DMG when HP < 30%" -- [cite: 35]
    },
    ["Scholar"] = {
        Buff = "+20% Magic Damage", -- [cite: 35]
        Passive = "Erudite: -1 Turn Cooldown for all skills" -- [cite: 35]
    },
    ["Gladiator"] = {
        Buff = "+10% DMG & Defense", -- [cite: 35]
        Passive = "Arena: +5% DMG per enemy on field" -- [cite: 35]
    },
    ["World Walker"] = {
        Buff = "+25% Phys/Magic DMG, +10% HP", -- [cite: 37]
        Passive = "Inversion: 10% chance to act twice" -- [cite: 37]
    },
    ["Ancient Blood"] = {
        Buff = "+30% HP, +15% Phys/Magic DMG", -- [cite: 37]
        Passive = "Immortal: Survive fatal hit with 1 HP (Once)" -- [cite: 37]
    }
}
-- 1. SETUP SCREEN GUI
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "RPG_UI"
screenGui.IgnoreGuiInset = true
screenGui.Parent = playerGui

-- 2. NỀN TRÀN MÀN HÌNH (100%)
local background = Instance.new("ImageLabel")
background.Image = "rbxassetid://130329682866275" 
background.Size = UDim2.fromScale(1, 1) -- Tràn 100%
background.BackgroundTransparency = 1
background.ScaleType = Enum.ScaleType.Stretch
background.Parent = screenGui

-- 3. HEADER
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

local function createHeaderBtn(name)
    local btn = Instance.new("TextButton")
    btn.Text = name:upper()
    btn.Size = UDim2.new(0.12, 0, 0.7, 0)
    btn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.Antique
    btn.TextScaled = true
    btn.Parent = header
end
for _, n in {"Main", "Arena", "Dungeon", "Inventory"} do createHeaderBtn(n) end

-- 4. VÙNG NỘI DUNG CHÍNH (CĂN GIỮA)
local mainContent = Instance.new("Frame")
mainContent.Position = UDim2.fromScale(0.5, 0.54)
mainContent.AnchorPoint = Vector2.new(0.5, 0.5)
mainContent.Size = UDim2.fromScale(0.9, 0.85) -- Chiếm 90% màn hình
mainContent.BackgroundTransparency = 1
mainContent.Parent = background

local contentLayout = Instance.new("UIListLayout")
contentLayout.FillDirection = Enum.FillDirection.Horizontal
contentLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
contentLayout.Padding = UDim.new(0.02, 0)
contentLayout.Parent = mainContent  

local function createColumn(width)
    local col = Instance.new("Frame")
    col.Size = UDim2.new(width, -20, 1, 0)
    col.BackgroundColor3 = Color3.fromRGB(150, 150, 150)
    col.BackgroundTransparency = 0.5
    col.Parent = mainContent
    return col
end

local statsCol = createColumn(0.3)
local raceCol = createColumn(0.3)
local rollCol = createColumn(0.35)


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

local function title(name)
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

local title = title("Character Stats")
local sStr = createStat("Strength")
local sDex = createStat("Dexterity")
local sEnd = createStat("Endurance")
local sArc = createStat("Arcane")

-- [CỘT RACE - GIỮ TỈ LỆ ẢNH]
local modelImg = Instance.new("ImageLabel")
modelImg.Size = UDim2.fromScale(0.9, 0.45)
modelImg.Position = UDim2.fromScale(0.05, 0.05)
modelImg.BackgroundTransparency = 1
-- QUAN TRỌNG: ScaleType.Fit giúp ảnh không bị méo khi khung co giãn
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
infoLayout.Padding = UDim.new(0.05, 0) -- Mỗi dòng cách nhau 5%
infoLayout.Parent = infoBox

local infoPadding = Instance.new("UIPadding")
infoPadding.PaddingTop = UDim.new(0.05, 0) -- Thêm khoảng cách ở trên cho đẹp
infoPadding.Parent = infoBox

local function createInfoText(color)
    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(0.95, 0, 0.28, 0) -- Mỗi dòng chiếm 28% chiều cao infoBox
    lbl.TextColor3 = color
    lbl.BackgroundTransparency = 1
    lbl.TextScaled = true
    lbl.TextWrapped = true -- Tự động xuống dòng nếu chữ quá dài
    lbl.Parent = infoBox
    return lbl
end

-- Tạo 3 dòng chữ (Không cần set Position nữa vì infoLayout đã lo)
local bText = createInfoText(Color3.fromRGB(200, 200, 200)) -- Chữ Buff (Trắng xám)
local kText = createInfoText(Color3.fromRGB(150, 255, 150)) -- Chữ Skill (Xanh lá)
local oText = createInfoText(Color3.fromRGB(200, 200, 200)) -- Chữ Origin (Vàng cam)


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
local rBox, rBtn = rollGrp("Race", 0.1)
local oBox, oBtn = rollGrp("Origin", 0.55)

-- 5. LOGIC
local UpdateStatsEvent = ReplicatedStorage:WaitForChild("Shared"):WaitForChild("Events"):WaitForChild("UpdateStats")
local RequestRollEvent = ReplicatedStorage:WaitForChild("Shared"):WaitForChild("Events"):WaitForChild("RequestRoll")

UpdateStatsEvent.OnClientEvent:Connect(function(data)
    rBox.Text = data.Race
    oBox.Text = data.Origin
    sStr.Text = "Strength: " .. (data.Stats.Str or 0)
    sDex.Text = "Dexterity: " .. (data.Stats.Dex or 0)
    sEnd.Text = "Endurance: " .. (data.Stats.End or 0)
    sArc.Text = "Arcane: " .. (data.Stats.Arc or 0)
    
    -- Cập nhật Race Buff & Skill
    local raceInfo = RACE_INFO[data.Race]
    if raceInfo then
        bText.Text = "Race Buffs:\n" .. raceInfo.Buff
        kText.Text = "Race Skill: " .. raceInfo.Skill
    else
        bText.Text = "Race Buffs: None"
        kText.Text = "Race Skill: None"
    end
    
    -- Cập nhật Origin Buff
    local origininfo = ORIGIN_INFO[data.Origin]
    if origininfo then
        oText.Text = "Origin Stats: " .. origininfo.Buff .. "\nPassive: " .. origininfo.Passive
    else
        oText.Text = "Origin: None"
    end
    modelImg.Image = RACE_MODELS[data.Race] or RACE_MODELS["None"]
end)

rBtn.MouseButton1Click:Connect(function() RequestRollEvent:FireServer("Race") end)
oBtn.MouseButton1Click:Connect(function() RequestRollEvent:FireServer("Origin") end)