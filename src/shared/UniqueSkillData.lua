local UniqueSkillData = {
    ["Legendary"] = {
        Chance = 5, -- Tăng nhẹ tỷ lệ vì giờ chỉ còn 3 cấp
        Skills = {"Predator", "Great Sage", "Gluttony"},
        Stats = {
            ["Predator"] = { Special = "Absorb" }, 
            ["Great Sage"] = { ExpRate = 1.5 },
            ["Gluttony"] = { Special = "AoE_Absorb" }
        }
    },
    ["Epic"] = {
        Chance = 15,
        Skills = {"Degenerate", "Mathematician", "Starved"},
        Stats = {
            ["Degenerate"] = { Str = 5, Dex = 5, End = 5, Arc = 5 },
            ["Mathematician"] = { Arc = 20 },
            ["Starved"] = { Lifesteal = 0.15 }
        }
    },
    ["Rare"] = {
        Chance = 80, -- Trong nhóm Unique thì Rare là phổ biến nhất
        Skills = {"Berserker", "Survivor", "Severer"},
        Stats = {
            ["Berserker"] = { Str = 15, Def = -5 },
            ["Survivor"] = { Regen = 20 },
            ["Severer"] = { Crit = 15 }
        }
    }
}

return UniqueSkillData