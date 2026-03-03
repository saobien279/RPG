local UniqueSkillData = {}

-- Tỉ lệ quay (Tổng = 1000)
UniqueSkillData.RATES = {
    { Chance = 450, Rarity = "Common" },    -- 45% (Giảm từ 60%)
    { Chance = 300, Rarity = "Uncommon" },  -- 30% (MỚI)
    { Chance = 150, Rarity = "Rare" },      -- 15% (Giảm từ 25%)
    { Chance = 70, Rarity = "Epic" },       -- 7%  (Giảm từ 10%)
    { Chance = 30, Rarity = "Legendary" }   -- 3%  (Giảm từ 5%)
}

-- Danh sách Kỹ năng (Đã thêm Uncommon)
UniqueSkillData.SKILLS = {
    -- [COMMON]
    ["Sticky Thread"] = { 
        Rarity = "Common", 
        Desc = "Create and manipulate sticky threads.",
        Buff = "+5% Dex, Chance to Slow"
    },
    ["Body Armor"] = { 
        Rarity = "Common", 
        Desc = "Covers body in magical armor.",
        Buff = "+8% Defense"
    },
    ["Magic Sense"] = { 
        Rarity = "Common", 
        Desc = "Perceive magicules.",
        Buff = "+8% Arcane"
    },

    -- [UNCOMMON] - MỚI
    ["Black Lightning"] = { 
        Rarity = "Uncommon", 
        Desc = "Discharge powerful dark lightning (Ranga's Skill).",
        Buff = "+12% Magic DMG, Chance to Paralyze"
    },
    ["Shadow Motion"] = { 
        Rarity = "Uncommon", 
        Desc = "Move instantly within shadows.",
        Buff = "+10% Dex, +5% Dodge Rate"
    },
    ["Herculean Strength"] = { 
        Rarity = "Uncommon", 
        Desc = "Immense physical strength boost.",
        Buff = "+15% Strength"
    },
    ["Water Blade"] = { 
        Rarity = "Uncommon", 
        Desc = "High-pressure water cutter.",
        Buff = "+10% Arcane, Armor Penetration"
    },

    -- [RARE]
    ["Berserker"] = { 
        Rarity = "Rare", 
        Desc = "Trade rationality for power.",
        Buff = "+25% Phys DMG, -15% Defense"
    },
    ["Survivor"] = { 
        Rarity = "Rare", 
        Desc = "Resilience against all environments.",
        Buff = "+20% HP Regen, Pain Nullification"
    },
    ["Severer"] = { 
        Rarity = "Rare", 
        Desc = "Ability to cut through space.",
        Buff = "+15% Crit Rate, Ignore 15% Def"
    },

    -- [EPIC]
    ["Degenerate"] = { 
        Rarity = "Epic", 
        Desc = "Synthesis and Separation.",
        Buff = "+25% All Stats, Fusion Crafting"
    },
    ["Mathematician"] = { 
        Rarity = "Epic", 
        Desc = "Accelerated Calculation.",
        Buff = "+40% Magic DMG, 100% Hit Rate"
    },
    ["Starved"] = { 
        Rarity = "Epic", 
        Desc = "Steal power from prey.",
        Buff = "Heal 15% HP on Kill, Scaling Stats"
    },

    -- [LEGENDARY]
    ["Predator"] = { 
        Rarity = "Legendary", 
        Desc = "Predation, Stomach, Mimicry.",
        Buff = "Absorb Enemies, Learn Skills"
    },
    ["Great Sage"] = { 
        Rarity = "Legendary", 
        Desc = "AI Assistant, Parallel Processing.",
        Buff = "Auto-Battle, Weakness Scan, +50% EXP"
    },
    ["Gluttony"] = { 
        Rarity = "Legendary", 
        Desc = "Ravenous hunger (Upgrade of Predator).",
        Buff = "AoE Absorption, Instant Kill minions"
    }
}

return UniqueSkillData