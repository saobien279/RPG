local UniqueSkillData = {
    ["Legendary"] = {
        Chance = 3,
        -- Server chỉ quan tâm danh sách tên để Random
        Skills = {"Predator", "Great Sage", "Gluttony"},
        -- Server quan tâm chỉ số để cộng sức mạnh (Thay text bằng số)
        Stats = {
            ["Predator"] = { Str = 0, Dex = 0, End = 0, Arc = 0, Special = "Absorb" }, 
            ["Great Sage"] = { ExpRate = 1.5, AutoBattle = true }, -- Ví dụ: Tăng 50% Exp
            ["Gluttony"] = { Str = 0, Dex = 0, End = 0, Arc = 0, Special = "AoE_Absorb" }
        }
    },
    ["Epic"] = {
        Chance = 7,
        Skills = {"Degenerate", "Mathematician", "Starved"},
        Stats = {
            ["Degenerate"] = { Str = 5, Dex = 5, End = 5, Arc = 5 }, -- Cộng đều các chỉ số
            ["Mathematician"] = { Arc = 20 }, -- Tập trung vào phép
            ["Starved"] = { Lifesteal = 0.15 } -- Hút máu 15%
        }
    },
    ["Rare"] = {
        Chance = 15,
        Skills = {"Berserker", "Survivor", "Severer"},
        Stats = {
            ["Berserker"] = { Str = 15, Def = -5 }, -- Tăng công giảm thủ
            ["Survivor"] = { Regen = 20 },
            ["Severer"] = { Crit = 15 }
        }
    },
    ["Uncommon"] = {
        Chance = 30,
        Skills = {"Black Lightning", "Shadow Motion", "Herculean Strength", "Water Blade"},
        Stats = {
            ["Black Lightning"] = { Arc = 10 },
            ["Shadow Motion"] = { Dex = 8 },
            ["Herculean Strength"] = { Str = 12 },
            ["Water Blade"] = { Arc = 5 }
        }
    },
    ["Common"] = {
        Chance = 45,
        Skills = {"Sticky Thread", "Body Armor", "Magic Sense"},
        Stats = {
            ["Sticky Thread"] = { Dex = 3 },
            ["Body Armor"] = { End = 5 },
            ["Magic Sense"] = { Arc = 4 }
        }
    }
}

return UniqueSkillData