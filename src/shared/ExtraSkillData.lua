local ExtraSkillData = {
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
        Chance = 70,
        Skills = {"Sticky Thread", "Body Armor", "Magic Sense"},
        Stats = {
            ["Sticky Thread"] = { Dex = 3 },
            ["Body Armor"] = { End = 5 },
            ["Magic Sense"] = { Arc = 4 }
        }
    }
}

return ExtraSkillData