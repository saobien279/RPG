-- src/server/ProfileManager.server.lua
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ProfileStore = require(script.Parent.modules.ProfileStore)
local DataTemplate = require(ReplicatedStorage.Shared.DataTemplate)
local RollService = require(script.Parent.RollService) -- Make sure the file name matches

local PlayerStore = ProfileStore.New("PlayerData_V2", DataTemplate)
local Profiles = {}

local function OnPlayerAdded(player)
    local profile = PlayerStore:StartSessionAsync("Player_" .. player.UserId)

    if profile ~= nil then
        profile:Reconcile()

        profile.OnSessionEnd:Connect(function()
            Profiles[player] = nil
            player:Kick("Data session ended. Please rejoin.")
        end)

        if player:IsDescendantOf(Players) then
            Profiles[player] = profile
            
            -- CHECK RACE
            if profile.Data.Slot1.Race == "None" then
                profile.Data.Slot1.Race = RollService.RollRace()
                print("🎉 " .. player.Name .. " rolled Race: " .. profile.Data.Slot1.Race)
            end

            -- CHECK ORIGIN
            if profile.Data.Slot1.Origin == "None" then
                profile.Data.Slot1.Origin = RollService.RollOrigin()
                print("📜 " .. player.Name .. " rolled Origin: " .. profile.Data.Slot1.Origin)
            end
            
            print("✅ Data loaded successfully for " .. player.Name)
        else
            profile:EndSession()
        end
    else
        player:Kick("System Error: Failed to load data.")
    end
end

Players.PlayerAdded:Connect(OnPlayerAdded)
Players.PlayerRemoving:Connect(function(player)
    local profile = Profiles[player]
    if profile ~= nil then
        profile:EndSession()
    end
end)