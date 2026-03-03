local RollService = {}

local RaceData = require(game.ReplicatedStorage.Shared.RaceData)
local OriginData = require(game.ReplicatedStorage.Shared.OriginData)
local UniqueSkillData = require(game.ReplicatedStorage.Shared.UniqueSkillData) -- Require file mới

-- Hàm chung để random dựa trên bảng tỉ lệ (Code cũ giữ nguyên hoặc tối ưu)
local function GetRarity(ratesTable)
    local roll = math.random(1, 1000)
    local current = 0
    for _, info in ipairs(ratesTable) do
        current = current + info.Chance
        if roll <= current then
            return info.Rarity
        end
    end
    return ratesTable[1].Rarity
end

local function GetItemByRarity(pool, rarity)
    local candidates = {}
    for name, info in pairs(pool) do
        if info.Rarity == rarity then
            table.insert(candidates, name)
        end
    end
    if #candidates == 0 then return "None" end -- Fallback
    return candidates[math.random(1, #candidates)]
end

function RollService.RollRace()
    local rarity = GetRarity(RaceData.RATES)
    return GetItemByRarity(RaceData.RACES, rarity)
end

function RollService.RollOrigin()
    local rarity = GetRarity(OriginData.RATES)
    return GetItemByRarity(OriginData.ORIGINS, rarity)
end

-- HÀM MỚI: Roll Unique Skill
function RollService.RollUniqueSkill()
    local rarity = GetRarity(UniqueSkillData.RATES)
    return GetItemByRarity(UniqueSkillData.SKILLS, rarity)
end

return RollService