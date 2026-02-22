-- src/shared/RaceData.lua
local RaceData = {
    ["Legendary"] = {
        Chance = 0.5,
        Races = {"Dragonkin"},
        Stats = {
            ["Dragonkin"] = {Str = 8, Dex = 5, End = 8, Arc = 6}
        }
    },
    ["Epic"] = {
        Chance = 5,
        Races = {"Demon", "Celestial"},
        Stats = {
            ["Demon"] = {Str = 4, Dex = 3, End = -2, Arc = 7},
            ["Celestial"] = {Str = -2, Dex = 1, End = 2, Arc = 9}
        }
    },
    ["Rare"] = {
        Chance = 10,
        Races = {"Undead", "Lizardfolk"},
        Stats = {
            ["Undead"] = {Str = 1, Dex = 2, End = -3, Arc = 4},
            ["Lizardfolk"] = {Str = 3, Dex = 1, End = 3, Arc = -3}
        }
    },
    ["Uncommon"] = {
        Chance = 30,
        Races = {"Elf", "Dwarf"},
        Stats = {
            ["Elf"] = {Str = -2, Dex = 4, End = -2, Arc = 4},
            ["Dwarf"] = {Str = 2, Dex = 2, End = 4, Arc = -4}
        }
    },
    ["Common"] = {
        Chance = 60,
        Races = {"Human", "Orc"},
        Stats = {
            ["Human"] = {Str = 0, Dex = 0, End = 0, Arc = 0},
            ["Orc"] = {Str = 5, End = 3, Dex = -2, Arc = -2}
        }
    },
}

return RaceData