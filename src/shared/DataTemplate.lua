local DataTemplate = {
    Slot1 = {
        Level = 1,
        Exp = 0,
        Race = "None", -- Sẽ Roll sau [cite: 3]
        Origin = "None", -- Sẽ Roll sau [cite: 3]
        Stats = {
            Str = 10, -- Sức mạnh vật lý 
            Arc = 10, -- Sát thương phép 
            End = 10, -- Tăng máu 
            Dex = 10  -- Chí mạng 
        },
        Inventory = {},
    },
    -- Bank = { -- Dữ liệu dùng chung giữa các Slot
    --     Gold = 0,
    --     Items = {}
    -- }
}
return DataTemplate	