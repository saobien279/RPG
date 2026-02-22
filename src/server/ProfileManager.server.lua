local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ProfileStore = require(script.Parent.modules.ProfileStore)
local DataTemplate = require(ReplicatedStorage.Shared.DataTemplate)
local RollService = require(script.Parent.RollService)
local StatService = require(script.Parent.StatService)
local UpdateStatsEvent = ReplicatedStorage:WaitForChild("Shared"):WaitForChild("Events"):WaitForChild("UpdateStats")

-- Sử dụng V3 để reset dữ liệu cho việc kiểm tra
local PlayerStore = ProfileStore.New("PlayerData_V3", DataTemplate)
local Profiles = {}

local function OnPlayerAdded(player)
    -- Bắt đầu phiên làm việc dữ liệu
    local profile = PlayerStore:StartSessionAsync("Player_" .. player.UserId)

    if profile ~= nil then
        profile:Reconcile() -- Đồng bộ dữ liệu mới từ Template

        -- Sử dụng đúng sự kiện OnSessionEnd
        profile.OnSessionEnd:Connect(function()
            Profiles[player] = nil
            player:Kick("Data session ended. Please rejoin.")
        end)

        if player:IsDescendantOf(Players) then
            Profiles[player] = profile
            
            -- Thực hiện Roll nếu Race là "None"
            if profile.Data.Slot1.Race == "None" then
                profile.Data.Slot1.Race = RollService.RollRace()
                print("Race Rolled: " .. profile.Data.Slot1.Race)
            end

            -- Thực hiện Roll nếu Origin là "None"
            if profile.Data.Slot1.Origin == "None" then
                profile.Data.Slot1.Origin = RollService.RollOrigin()
                print("Origin Rolled: " .. profile.Data.Slot1.Origin)
            end

            -- TÍNH TOÁN CHỈ SỐ CUỐI CÙNG
            local finalStats = StatService.CalculateFinalStats(profile.Data)
            
            print("-----------------------------------")
            print("📊 CHARACTER STATS: " .. player.Name)
            print("Race: " .. profile.Data.Slot1.Race .. " | Origin: " .. profile.Data.Slot1.Origin)
            print("Strength: " .. finalStats.Str)
            print("Dexterity: " .. finalStats.Dex)
            print("Endurance: " .. finalStats.End)
            print("Arcane: " .. finalStats.Arc)
            print("-----------------------------------")
            
            print("✅ Data loaded successfully for " .. player.Name)
        else
            profile:EndSession() -- Giải phóng dữ liệu nếu người chơi thoát nhanh
        end
    else
        player:Kick("System Error: Failed to load data.")
    end
end

Players.PlayerAdded:Connect(OnPlayerAdded)
Players.PlayerRemoving:Connect(function(player)
    local profile = Profiles[player]
    if profile ~= nil then
        profile:EndSession() -- Lưu dữ liệu khi thoát
    end
end)