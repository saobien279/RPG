-- src/server/RaceService.lua
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RaceData = require(ReplicatedStorage.Shared.RaceData)

local RaceService = {}

-- HÀM QUAY SỐ: Giải thích 1-1 bên dưới
function RaceService.Roll()
    -- 1. Tạo một số ngẫu nhiên từ 0.1 đến 100
    local roll = math.random(1, 1000) / 10
    local roll1 = math.random(1, 1000) / 10  
    
    -- 2. Kiểm tra xem số đó rơi vào "khoảng" nào
    -- Chúng ta kiểm tra từ Hiếm nhất -> Thường nhất
    
    if roll <= 0.5 then 
        return "Dragonkin" -- Trúng 0.5% Legend
    elseif roll <= (0.5 + 5) then 
        local list = RaceData.Epic.Races
        return list[math.random(1, #list)] -- Trúng Epic
    elseif roll <= (0.5 + 5 + 10) then
        local list = RaceData.Rare.Races
        return list[math.random(1, #list)] -- Trúng Rare
    elseif roll <= (0.5 + 5 + 10 + 30) then
        local list = RaceData.Uncommon.Races
        return list[math.random(1, #list)] -- Trúng Uncommon
    else
        local list = RaceData.Common.Races
        return list[math.random(1, #list)] -- Trúng Common (Mặc định)
    end
end

return RaceService

-- src/server/RollService.lua
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RaceData = require(ReplicatedStorage.Shared.RaceData)
local OriginData = require(ReplicatedStorage.Shared.OriginData)

local RollService = {}

-- Function to roll for a random Race
function RollService.RollRace()
    local roll = math.random(1, 1000) / 10
    
    if roll <= 0.5 then 
        return "Dragonkin"
    elseif roll <= (0.5 + 5) then 
        local list = RaceData.Epic.Races
        return list[math.random(1, #list)]
    elseif roll <= (0.5 + 5 + 10) then
        local list = RaceData.Rare.Races
        return list[math.random(1, #list)]
    elseif roll <= (0.5 + 5 + 10 + 30) then
        local list = RaceData.Uncommon.Races
        return list[math.random(1, #list)]
    else
        local list = RaceData.Common.Races
        return list[math.random(1, #list)]
    end
end

-- Function to roll for a random Origin
function RollService.RollOrigin()
    local roll = math.random(1, 1000) / 10
    
    if roll1 <= 1 then 
        local list = OriginData.Legendary.Origins
        return list[math.random(1, #list)]
    elseif roll1 <= (1 + 5) then
        local list = OriginData.Epic.Origins
        return list[math.random(1, #list)]
    elseif roll1 <= (1 + 5 + 10) then
        local list = OriginData.Rare.Origins
        return list[math.random(1, #list)]
    elseif roll1 <= (1 + 5 + 10 + 30) then
        local list = OriginData.Uncommon.Origins
        return list[math.random(1, #list)]
    else
        local list = OriginData.Common.Origins
        return list[math.random(1, #list)]
    end
end

return RollService