local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ProfileStore = require(script.Parent.modules.ProfileStore)
local DataTemplate = require(ReplicatedStorage.Shared.DataTemplate)

-- Khởi tạo kho lưu trữ tên là "PlayerData_V1"
local PlayerStore = ProfileStore.New("PlayerData_V1", DataTemplate)

local Profiles = {}

local function OnPlayerAdded(player)
    -- Bắt đầu phiên làm việc dữ liệu
    local profile = PlayerStore:StartSessionAsync("Player_" .. player.UserId)

    if profile ~= nil then
        profile:Reconcile() -- Tự động cập nhật chỉ số nếu Template thay đổi

        profile.OnReleased:Connect(function()
            Profiles[player] = nil
            player:Kick("Dữ liệu đã bị đóng ở server khác.")
        end)

        if player:IsDescendantOf(Players) then
            Profiles[player] = profile
            print("✅ Đã tải dữ liệu cho " .. player.Name)
        else
            profile:End()
        end
    else
        player:Kick("Không thể tải dữ liệu.")
    end
end

Players.PlayerAdded:Connect(OnPlayerAdded)
Players.PlayerRemoving:Connect(function(player)
    local profile = Profiles[player]
    if profile ~= nil then
        profile:End() -- Tự động lưu khi thoát
    end
end)