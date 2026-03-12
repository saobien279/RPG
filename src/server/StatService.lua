local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RaceData = require(ReplicatedStorage.Shared.RaceData)
local OriginData = require(ReplicatedStorage.Shared.OriginData)
local UniqueSkillData = require(ReplicatedStorage.Shared.UniqueSkillData)
local ExtraSkillData = require(ReplicatedStorage.Shared.ExtraSkillData) -- [THÊM DÒNG NÀY]

local StatService = {}

-- Hàm bổ trợ tìm chỉ số trong bảng dữ liệu
local function GetStatsModifier(name, dataTable)
    if name == "None" or not name then return {} end
    for _, tierInfo in pairs(dataTable) do
        if tierInfo.Stats and tierInfo.Stats[name] then
            return tierInfo.Stats[name]
        end
    end
    return {}
end

function StatService.CalculateFinalStats(profileData)
    local slot = profileData.Slot1
    local base = slot.Stats
    
    -- Lấy chỉ số cộng thêm từ cả 4 nguồn
    local raceMod = GetStatsModifier(slot.Race, RaceData)
    local originMod = GetStatsModifier(slot.Origin, OriginData)
    local uSkillMod = GetStatsModifier(slot.UniqueSkill, UniqueSkillData)
    local eSkillMod = GetStatsModifier(slot.ExtraSkill, ExtraSkillData) -- [LẤY THÊM EXTRA SKILL]

    -- Logic tính toán chỉ số cơ bản
    local function getFinalBaseStat(statName, baseVal)
        -- Cộng tất cả các nguồn cộng thẳng (Flat Add)
        local flatAdd = (raceMod[statName] or 0) 
                      + (uSkillMod[statName] or 0) 
                      + (eSkillMod[statName] or 0) -- [CỘNG VÀO ĐÂY]
        
        local totalFlat = baseVal + flatAdd
        
        -- Áp dụng % từ Origin
        local multiplier = 1 + (((originMod[statName] or 0) + (originMod.All or 0)) / 100)
        return math.ceil(totalFlat * multiplier)
    end

    local finalStr = getFinalBaseStat("Str", base.Str)
    local finalArc = getFinalBaseStat("Arc", base.Arc)
    local finalEnd = getFinalBaseStat("End", base.End)
    local finalDex = getFinalBaseStat("Dex", base.Dex)

    -- CHUYỂN ĐỔI SANG CHỈ SỐ CHIẾN ĐẤU (Công thức của Sen)
    return {
        Str = finalStr, Dex = finalDex, End = finalEnd, Arc = finalArc,
        
        PhysAtk = finalStr,
        MagicAtk = finalArc,
        MaxHP = finalEnd * 5,
        CritChance = math.min(75, finalDex * 0.5),
        CritDmg = 150 + (finalDex * 1.5)
    }
end

return StatService