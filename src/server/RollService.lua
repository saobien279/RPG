local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RaceData = require(ReplicatedStorage.Shared.RaceData)
local OriginData = require(ReplicatedStorage.Shared.OriginData)

local RollService = {}

-- Hàm thực hiện quay số chọn Tộc (Race)
function RollService.RollRace()
    -- Tạo số ngẫu nhiên từ 0.1 đến 100
    local roll = math.random(1, 1000) / 10
    
    -- Kiểm tra tỷ lệ dựa trên dữ liệu từ RaceData
    if roll <= 0.5 then 
        return "Dragonkin" -- Legendary
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

-- Hàm thực hiện quay số chọn Xuất thân (Origin)
function RollService.RollOrigin()
    -- Mỗi lần gọi math.random() sẽ tạo ra một con số khác nhau
    local roll = math.random(1, 1000) / 10
    
    -- Kiểm tra tỷ lệ dựa trên dữ liệu từ OriginData
    if roll <= 0.5 then 
        local list = OriginData.Legendary.Origins
        return list[math.random(1, #list)]
    elseif roll <= (0.5 + 5) then
        local list = OriginData.Epic.Origins
        return list[math.random(1, #list)]
    elseif roll <= (0.5 + 5 + 10) then
        local list = OriginData.Rare.Origins
        return list[math.random(1, #list)]
    elseif roll <= (0.5 + 5 + 10 + 30) then
        local list = OriginData.Uncommon.Origins
        return list[math.random(1, #list)]
    else
        local list = OriginData.Common.Origins
        return list[math.random(1, #list)]
    end
end

return RollService