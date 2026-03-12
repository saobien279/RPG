local DataTemplate = {
    Slot1 = {
        Level = 1,
        Exp = 0,
        MaxExp = 100,
        Points = 2,
        Gold = 500,        -- Tặng sẵn 500 Gold khi mới chơi
        Essence = 100,      -- Tặng sẵn 10 Essence để Test Roll
        Race = "None", -- Sẽ Roll sau [cite: 3]
        Origin = "None", -- Sẽ Roll sau [cite: 3]
        UniqueSkill = "None",
        ExtraSkill = "None",
        Stats = {
            Str = 0, -- Sức mạnh vật lý 
            Arc = 0, -- Sát thương phép 
            End = 0, -- Tăng máu 
            Dex = 0  -- Chí mạng 
        },
        Inventory = {},
    },
    -- Bank = { -- Dữ liệu dùng chung giữa các Slot
    --     Gold = 0,
    --     Items = {}
    -- }
}
return DataTemplate	