-- src/shared/OriginData.lua
local OriginData = {
    ["Legendary"] = {
        Chance = 0.5,
        Origins = {"Ancient Blood", "World Walker"},
        Stats = {
            ["Ancient Blood"] = {End = 30, Str = 15, Arc = 15}, -- [cite: 12]
            ["World Walker"] = {Str = 25, Arc = 25, End = 10}  -- [cite: 12]
        }
    },
    ["Epic"] = {
        Chance = 5,
        Origins = {"Fallen Knight", "Scholar", "Gladiator"},
        Stats = {
            ["Fallen Knight"] = {Str = 20}, -- [cite: 10]
            ["Scholar"] = {Arc = 20},       -- [cite: 10]
            ["Gladiator"] = {Str = 10, End = 10} -- [cite: 10]
        }
    },
    ["Rare"] = {
        Chance = 10,
        Origins = {"Noble", "Ruin Hunter", "Wanderer"},
        Stats = {
            ["Noble"] = {All = 8}, -- [cite: 8]
            ["Ruin Hunter"] = {Str = 15, Dex = 10}, -- [cite: 8]
            ["Wanderer"] = {End = 15} -- [cite: 8]
        }
    },
    ["Uncommon"] = {
        Chance = 30,
        Origins = {"Soldier", "Grave Robber", "Acolyte"},
        Stats = {
            ["Soldier"] = {Str = 8, End = 8}, -- 
            ["Grave Robber"] = {Dex = 12},     -- 
            ["Acolyte"] = {Arc = 15}           -- 
        }
    },
    ["Common"] = {
        Chance = 60,
        Origins = {"Farmer", "Smith", "Apprentice"},
        Stats = {
            ["Farmer"] = {End = 10}, -- [cite: 4]
            ["Smith"] = {Str = 8},   -- [cite: 4]
            ["Apprentice"] = {Arc = 10} -- [cite: 4]
        }
    },
}

return OriginData