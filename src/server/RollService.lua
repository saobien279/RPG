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
    -- Each call to math.random() creates a unique number, 
    -- so Race and Origin results will naturally be different.
    local roll = math.random(1, 1000) / 10
    
    if roll <= 0.5 then -- Adjusted to 0.5% for Fallen Lord based on your OriginData
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