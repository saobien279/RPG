local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ProfileStore = require(script.Parent.modules.ProfileStore)
local DataTemplate = require(ReplicatedStorage.Shared.DataTemplate)
local RollService = require(script.Parent.RollService)
local StatService = require(script.Parent.StatService)
local UpdateStatsEvent = ReplicatedStorage:WaitForChild("Shared"):WaitForChild("Events"):WaitForChild("UpdateStats")
local RequestRollEvent = ReplicatedStorage:WaitForChild("Shared"):WaitForChild("Events"):WaitForChild("RequestRoll")
local EconomyData = require(ReplicatedStorage.Shared.EconomyData)
local AddStatEvent = ReplicatedStorage.Shared.Events.AddStat

-- Sử dụng V3 để reset dữ liệu cho việc kiểm tra
local PlayerStore = ProfileStore.New("PlayerData_V99", DataTemplate)
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

            if profile.Data.Slot1.UniqueSkill == "None" then
                profile.Data.Slot1.UniqueSkill = RollService.RollUniqueSkill()
            end
            
            if profile.Data.Slot1.ExtraSkill == "None" then
                profile.Data.Slot1.ExtraSkill = RollService.RollExtraSkill()
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
            -- THÊM DÒNG NÀY ĐỂ GỬI DỮ LIỆU VỀ UI
            UpdateStatsEvent:FireClient(player, {
                Level = profile.Data.Slot1.Level,
                Exp = profile.Data.Slot1.Exp,
                MaxExp = profile.Data.Slot1.MaxExp,
                Points = profile.Data.Slot1.Points,
                Gold = profile.Data.Slot1.Gold,        -- Phải có dòng này
                Essence = profile.Data.Slot1.Essence,  -- Phải có dòng này
                Race = profile.Data.Slot1.Race,
                Origin = profile.Data.Slot1.Origin,
                UniqueSkill = profile.Data.Slot1.UniqueSkill,
                ExtraSkill = profile.Data.Slot1.ExtraSkill,
                Stats = finalStats
            })
        else
            profile:EndSession() -- Giải phóng dữ liệu nếu người chơi thoát nhanh
        end
    else
        player:Kick("System Error: Failed to load data.")
    end
end


--HAM ROLL
RequestRollEvent.OnServerEvent:Connect(function(player, rollType)
    local profile = Profiles[player]
    if not profile then return end

    local costInfo = EconomyData.Costs[rollType]
    if not costInfo then return end

    -- Kiểm tra xem người chơi có đủ tiền không
    local currentBalance = profile.Data.Slot1[costInfo.Currency]
    
    if currentBalance >= costInfo.Amount then
        -- TRỪ TIỀN
        profile.Data.Slot1[costInfo.Currency] -= costInfo.Amount
        
        -- THỰC HIỆN ROLL (Giữ nguyên logic cũ của bạn)
        if rollType == "Race" then
            profile.Data.Slot1.Race = RollService.RollRace()
        elseif rollType == "Origin" then
            profile.Data.Slot1.Origin = RollService.RollOrigin()
        elseif rollType == "ExtraSkill" then
            profile.Data.Slot1.ExtraSkill = RollService.RollExtraSkill()
        elseif rollType == "UniqueSkill" then
            profile.Data.Slot1.UniqueSkill = RollService.RollUniqueSkill()
        end

        -- CẬP NHẬT VÀ GỬI DỮ LIỆU VỀ CLIENT
        local finalStats = StatService.CalculateFinalStats(profile.Data)
        UpdateStatsEvent:FireClient(player, {
            Level = profile.Data.Slot1.Level,
            Exp = profile.Data.Slot1.Exp,
            MaxExp = profile.Data.Slot1.MaxExp,
            Points = profile.Data.Slot1.Points,
            Gold = profile.Data.Slot1.Gold,        -- Gửi thêm Gold
            Essence = profile.Data.Slot1.Essence,  -- Gửi thêm Essence
            Race = profile.Data.Slot1.Race,
            Origin = profile.Data.Slot1.Origin,
            UniqueSkill = profile.Data.Slot1.UniqueSkill,
            ExtraSkill = profile.Data.Slot1.ExtraSkill,
            Stats = finalStats
        })
    else
        -- Nếu không đủ tiền, có thể thông báo cho Client (tạm thời để trống)
        print("Không đủ tiền để Roll!")
    end
end)


--XP
function AddExp(player, amount)
    local profile = Profiles[player]
    if not profile then return end
    
    local data = profile.Data.Slot1
    data.Exp += amount
    
    -- Kiểm tra lên cấp (vòng lặp phòng trường hợp nhận 1 phát cực nhiều EXP)
    while data.Exp >= data.MaxExp and data.Level < 50 do
        data.Exp -= data.MaxExp
        data.Level += 1
        data.Points += 2 -- Thưởng điểm tiềm năng
        data.MaxExp = math.floor(100 * (data.Level ^ 1.5)) -- Cập nhật mốc mới
    end
    
    -- Gửi update về Client như bình thường
end


AddStatEvent.OnServerEvent:Connect(function(player, statName)
    local profile = Profiles[player]
    if not profile then return end
    
    local data = profile.Data.Slot1
    
    -- KIỂM TRA BẢO MẬT: Chỉ cho phép nếu còn điểm
    if data.Points and data.Points > 0 then
        -- 1. Trừ điểm tiềm năng
        data.Points -= 1
        
        -- 2. Cộng vào chỉ số gốc (Stats)
        -- Phải đảm bảo statName là "Str", "Dex", "End", hoặc "Arc"
        if data.Stats[statName] then
            data.Stats[statName] += 1
        end
        
        -- 3. Tính toán lại toàn bộ sức mạnh (Atk, HP, Crit...)
        local finalStats = StatService.CalculateFinalStats(profile.Data)
        
        -- 4. Gửi dữ liệu ĐÃ CẬP NHẬT về Client để hiển thị
        UpdateStatsEvent:FireClient(player, {
            Points = data.Points,
            Stats = finalStats,
            -- Gửi thêm các thông tin này để UI Client không bị reset về "None"
            Race = data.Race,
            Origin = data.Origin,
            Level = data.Level,
            Exp = data.Exp,
            MaxExp = data.MaxExp,
            Gold = data.Gold,
            Essence = data.Essence,
            UniqueSkill = data.UniqueSkill,
            ExtraSkill = data.ExtraSkill
        })
        
        print(player.Name .. " đã cộng 1 điểm vào " .. statName)
    else
        print(player.Name .. " định 'hack' điểm nhưng Server đã chặn!")
    end
end)





Players.PlayerAdded:Connect(OnPlayerAdded)
Players.PlayerRemoving:Connect(function(player)
    local profile = Profiles[player]
    if profile ~= nil then
        profile:EndSession() -- Lưu dữ liệu khi thoát
    end
end)