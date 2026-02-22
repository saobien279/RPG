-- src/server/StatService.lua
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RaceData = require(ReplicatedStorage.Shared.RaceData)
local OriginData = require(ReplicatedStorage.Shared.OriginData)

local StatService = {}

-- Hàm lấy bảng chỉ số cộng thêm
local function GetStatsModifier(name, dataTable)
    for _, tierInfo in pairs(dataTable) do
        if tierInfo.Stats and tierInfo.Stats[name] then
            return tierInfo.Stats[name]
        end
    end
    return {}
end

function StatService.CalculateFinalStats(profileData)
    local base = profileData.Slot1.Stats -- Currently 0
    local raceName = profileData.Slot1.Race
    local originName = profileData.Slot1.Origin

    local raceMod = GetStatsModifier(raceName, RaceData)
    local originMod = GetStatsModifier(originName, OriginData)

    -- Logic: Cộng Race trước, sau đó nhân % của Origin
    local function calculate(baseVal, raceFlat, originPercent)
        local afterRace = baseVal + (raceFlat or 0)
        local multiplier = 1 + ((originPercent or originMod.All or 0) / 100)
        
        -- Dùng math.ceil (làm tròn lên) để đảm bảo buff % luôn có tác dụng (ít nhất +1)
        return math.ceil(afterRace * multiplier)
    end

    return {
        Str = calculate(base.Str, raceMod.Str, originMod.Str),
        Dex = calculate(base.Dex, raceMod.Dex, originMod.Dex),
        End = calculate(base.End, raceMod.End, originMod.End),
        Arc = calculate(base.Arc, raceMod.Arc, originMod.Arc),
    }
end

return StatService