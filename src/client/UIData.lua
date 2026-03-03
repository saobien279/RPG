local UIData = {}

-- BẢNG MÀU THEO ĐỘ HIẾM
UIData.RARITY_COLORS = {
    ["Common"] = Color3.fromRGB(255, 255, 255),    -- Trắng
    ["Uncommon"] = Color3.fromRGB(80, 255, 80),    -- Xanh lá
    ["Rare"] = Color3.fromRGB(80, 180, 255),       -- Xanh nước biển
    ["Epic"] = Color3.fromRGB(200, 100, 255),      -- Tím
    ["Legendary"] = Color3.fromRGB(255, 215, 0)    -- Vàng
}

-- DỮ LIỆU RACE
UIData.RACE_INFO = {
    ["Human"] = { Buff = "1. +5% EXP earned\n2. +5% All Stats", Skill = "Adaptability: Restores 2 Energy", Rarity = "Common" },
    ["Orc"] = { Buff = "1. +10% Max Health\n2. +5% Physical Damage", Skill = "Frenzy: +20% Phys DMG (3 turns)", Rarity = "Common" },
    
    ["Elf"] = { Buff = "1. +10% Magic & Phys DMG\n2. +5% Critical Rate", Skill = "Nature's Blessing: 15% DMG Buff", Rarity = "Uncommon" },
    ["Dwarf"] = { Buff = "1. +10% Phys Def\n2. 15% CC Resistance", Skill = "Fortify: Shield (10% Max HP)", Rarity = "Uncommon" },
    
    ["Undead"] = { Buff = "1. +15% Dark/Poison DMG\n2. 20% Revive chance", Skill = "Death Breath: -30% Enemy Healing", Rarity = "Rare" },
    ["Lizardfolk"] = { Buff = "1. 3% HP Regen/turn\n2. +10% DMG if HP < 50%", Skill = "Tail Sweep: -20% Target DMG", Rarity = "Rare" },
    
    ["Demon"] = { Buff = "1. +15% Crit DMG\n2. +2% DMG per kill", Skill = "Blood Pact: 10% HP for +30% DMG", Rarity = "Epic" },
    ["Celestial"] = { Buff = "1. +15% Heal power\n2. -10% Magic DMG taken", Skill = "Holy Aegis: Cleanse & +5% Mana", Rarity = "Epic" },
    
    ["Dragonkin"] = { Buff = "1. Dragon Awe: -10% Enemy Stats\n2. Sky Dragon: +15% All Stats", Skill = "Dragon Fire: AoE & -30% Defense", Rarity = "Legendary" }
}

-- (Giữ nguyên UIData.RACE_MODELS như cũ của bạn)
UIData.RACE_MODELS = {
    ["Human"] = "rbxassetid://93825679812931",
    ["Orc"] = "rbxassetid://135547138162212",
    ["Elf"] = "rbxassetid://135381458799447",
    ["Dwarf"] = "rbxassetid://82378365109549",
    ["Demon"] = "rbxassetid://127071815896821",
    ["Celestial"] = "rbxassetid://127793662530681",
    ["Undead"] = "rbxassetid://123378480910456",
    ["Lizardfolk"] = "rbxassetid://117958946510755",
    ["Dragonkin"] = "rbxassetid://77950129143543",
    ["None"] = "rbxassetid://0",
}

-- DỮ LIỆU XUẤT THÂN
UIData.ORIGIN_INFO = {
    ["Farmer"] = { Buff = "+10% Max Health", Passive = "Endurance: +20% Energy Regen", Rarity = "Common" },
    ["Smith"] = { Buff = "+8% Physical Damage", Passive = "Weapon Mastery: +10% Weapon Stats", Rarity = "Common" },
    ["Apprentice"] = { Buff = "+10% Magic Damage", Passive = "Focus: +10% DMG to CC'd enemies", Rarity = "Common" },
    
    ["Soldier"] = { Buff = "+8% Attack & Defense", Passive = "Discipline: -10% DMG taken", Rarity = "Uncommon" },
    ["Grave Robber"] = { Buff = "+12% Crit Rate", Passive = "Keen: +8% Crit Rate", Rarity = "Uncommon" },
    ["Acolyte"] = { Buff = "+15% Healing Effect", Passive = "Devout: +25% Healing, 5% to Shield", Rarity = "Uncommon" },
    
    ["Noble"] = { Buff = "+8% All Stats", Passive = "Authority: +15% Gold from all sources", Rarity = "Rare" },
    ["Ruin Hunter"] = { Buff = "+15% Damage", Passive = "Discovery: +10% Crit Rate", Rarity = "Rare" },
    ["Wanderer"] = { Buff = "+15% Max Health", Passive = "Experience: -5% DMG taken for team", Rarity = "Rare" },
    
    ["Fallen Knight"] = { Buff = "+20% Physical Damage", Passive = "Revenge: +25% Phys DMG when HP < 30%", Rarity = "Epic" },
    ["Scholar"] = { Buff = "+20% Magic Damage", Passive = "Erudite: -1 Turn Cooldown for all skills", Rarity = "Epic" },
    ["Gladiator"] = { Buff = "+10% DMG & Defense", Passive = "Arena: +5% DMG per enemy on field", Rarity = "Epic" },
    
    ["World Walker"] = { Buff = "+25% Phys/Magic DMG, +10% HP", Passive = "Inversion: 10% chance to act twice", Rarity = "Legendary" },
    ["Ancient Blood"] = { Buff = "+30% HP, +15% Phys/Magic DMG", Passive = "Immortal: Survive fatal hit with 1 HP", Rarity = "Legendary" }
}

-- DANH SÁCH HIỂN THỊ CHO UNIQUE SKILL
UIData.UNIQUE_SKILL_INFO = {
    -- [COMMON]
    ["Sticky Thread"] = { Rarity = "Common", Desc = "Create sticky threads.", Buff = "+5% Dex" },
    ["Body Armor"] = { Rarity = "Common", Desc = "Magical armor.", Buff = "+8% Defense" },
    ["Magic Sense"] = { Rarity = "Common", Desc = "Perceive magicules.", Buff = "+8% Arcane" },

    -- [UNCOMMON] (Mới)
    ["Black Lightning"] = { Rarity = "Uncommon", Desc = "Dark lightning.", Buff = "+12% Mag DMG" },
    ["Shadow Motion"] = { Rarity = "Uncommon", Desc = "Move in shadows.", Buff = "+10% Dex" },
    ["Herculean Strength"] = { Rarity = "Uncommon", Desc = "Physical strength.", Buff = "+15% Str" },
    ["Water Blade"] = { Rarity = "Uncommon", Desc = "Water cutter.", Buff = "Armor Pen" },

    -- [RARE]
    ["Berserker"] = { Rarity = "Rare", Desc = "Power over reason.", Buff = "+25% Phys DMG" },
    ["Survivor"] = { Rarity = "Rare", Desc = "Resilience.", Buff = "+20% Regen" },
    ["Severer"] = { Rarity = "Rare", Desc = "Cut space.", Buff = "Ignore 15% Def" },

    -- [EPIC]
    ["Degenerate"] = { Rarity = "Epic", Desc = "Synthesis.", Buff = "+25% All Stats" },
    ["Mathematician"] = { Rarity = "Epic", Desc = "Fast Calc.", Buff = "100% Hit Rate" },
    ["Starved"] = { Rarity = "Epic", Desc = "Steal power.", Buff = "Heal on Kill" },

    -- [LEGENDARY]
    ["Predator"] = { Rarity = "Legendary", Desc = "Predation.", Buff = "Absorb Skills" },
    ["Great Sage"] = { Rarity = "Legendary", Desc = "AI Assistant.", Buff = "Auto-Battle" },
    ["Gluttony"] = { Rarity = "Legendary", Desc = "Ravenous hunger.", Buff = "AoE Absorb" },

    -- [MẶC ĐỊNH]
    ["None"] = { Rarity = "Common", Desc = "No Skill", Buff = "" }
}
return UIData