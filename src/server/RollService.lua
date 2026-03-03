-- src/server/RollService.lua
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RaceData = require(ReplicatedStorage.Shared.RaceData)
local OriginData = require(ReplicatedStorage.Shared.OriginData)
local UniqueSkillData = require(ReplicatedStorage.Shared.UniqueSkillData)

local RollService = {}

function RollService.RollRace()
    local roll = math.random(1, 1000) / 10
    
    if roll <= 0.5 then -- Legend
        return "Dragonkin"
    elseif roll <= (0.5 + 5) then -- Epic
        local list = RaceData.Epic.Races
        return list[math.random(1, #list)]
    elseif roll <= (0.5 + 5 + 10) then -- Rare
        local list = RaceData.Rare.Races
        return list[math.random(1, #list)]
    elseif roll <= (0.5 + 5 + 10 + 30) then -- Uncommon
        local list = RaceData.Uncommon.Races
        return list[math.random(1, #list)]
    else -- Common (54.5%)
        local list = RaceData.Common.Races
        return list[math.random(1, #list)]
    end
end

function RollService.RollOrigin()
    local roll = math.random(1, 1000) / 10
    
    -- Tỷ lệ Origin cũng nên tương đương để đảm bảo tính cân bằng
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

-- Hàm Roll Unique Skill (Mới)
function RollService.RollUniqueSkill()
    local roll = math.random(1, 100) -- Gieo xúc xắc từ 1 đến 100
    
    -- Tỷ lệ: Legend(3) + Epic(7) + Rare(15) + Uncommon(30) + Common(45) = 100%
    
    if roll <= 3 then -- Legendary (3%)
        local list = UniqueSkillData.Legendary.Skills
        return list[math.random(1, #list)]
        
    elseif roll <= (3 + 7) then -- Epic (Cộng dồn là 10%)
        local list = UniqueSkillData.Epic.Skills
        return list[math.random(1, #list)]
        
    elseif roll <= (3 + 7 + 15) then -- Rare (Cộng dồn là 25%)
        local list = UniqueSkillData.Rare.Skills
        return list[math.random(1, #list)]
        
    elseif roll <= (3 + 7 + 15 + 30) then -- Uncommon (Cộng dồn là 55%)
        local list = UniqueSkillData.Uncommon.Skills
        return list[math.random(1, #list)]
        
    else -- Common (45% còn lại)
        local list = UniqueSkillData.Common.Skills
        return list[math.random(1, #list)]
    end
end

return RollService