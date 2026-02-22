local ReplicatedStorage = game:GetService("ReplicatedStorage")
-- Thêm .Shared vào giữa đường dẫn
local UpdateStatsEvent = ReplicatedStorage:WaitForChild("Shared"):WaitForChild("Events"):WaitForChild("UpdateStats")

UpdateStatsEvent.OnClientEvent:Connect(function(data)
    print("✨ Đã nhận dữ liệu từ Server!")
    print("Tộc: " .. data.Race)
    print("Xuất thân: " .. data.Origin)
    -- Sau này mình sẽ dán data.Stats vào UI ở đây
end)