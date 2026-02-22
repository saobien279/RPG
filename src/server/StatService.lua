-- src/server/StatService.lua
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RaceData = require(ReplicatedStorage.Shared.RaceData)
local OriginData = require(ReplicatedStorage.Shared.OriginData)

local StatService = {}

local function GetStatsModifier(name, dataTable)
    for _, tierInfo in pairs(dataTable) do
        if tierInfo.Stats and tierInfo.Stats[name] then
            return tierInfo.Stats[name]
        end
    end
    return {}
end

function StatService.CalculateFinalStats(profileData)
    local base = profileData.Slot1.Stats -- Giá trị khởi đầu là 0
    local raceName = profileData.Slot1.Race
    local originName = profileData.Slot1.Origin

    local raceMod = GetStatsModifier(raceName, RaceData)
    local originMod = GetStatsModifier(originName, OriginData)

    -- Logic: (Base + Race) * (1 + %Origin)
    local function calculate(baseVal, raceFlat, originPercent)
        local totalAfterRace = baseVal + (raceFlat or 0)
        -- Sử dụng % từ Origin (hoặc All nếu là Quý Tộc)
        local multiplier = 1 + ((originPercent or originMod.All or 0) / 100)
        
        -- Làm tròn lên để buff % nhỏ nhất (+8%) vẫn có giá trị ít nhất là 1 điểm
        return math.ceil(totalAfterRace * multiplier)
    end

    return {
        Str = calculate(base.Str, raceMod.Str, originMod.Str),
        Dex = calculate(base.Dex, raceMod.Dex, originMod.Dex),
        End = calculate(base.End, raceMod.End, originMod.End),
        Arc = calculate(base.Arc, raceMod.Arc, originMod.Arc),
    }
end

return StatService