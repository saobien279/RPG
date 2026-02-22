-- src/shared/RaceData.lua
local RaceData = {
    -- Định nghĩa các tầng (Tiers) và tỉ lệ %
    -- Lưu ý: Tổng tỉ lệ của ông đang là ~105%, máy sẽ tính từ hiếm nhất xuống nhé!
    ["Legendary"] = {Chance = 0.5, Races = {"Dragonkin"}},
    ["Epic"]      = {Chance = 5,   Races = {"Demon", "Celestial"}},
    ["Rare"]      = {Chance = 10,  Races = {"Undead", "Lizardfolk"}},
    ["Uncommon"]  = {Chance = 30,  Races = {"Elf", "Dwarf"}},
    ["Common"]    = {Chance = 60,  Races = {"Human", "Orc"}},
}

return RaceData