--[=[
    Vexus Hub v4 | Cut Grass for Anime Characters
    SMART TARGETING + FULL DEBUG - May 2026
    Hosted by Nyx
]=]

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
    Name = "Vexus Hub v4 - Cut Grass for Anime Characters",
    LoadingTitle = "Vexus Hub v1",
    LoadingSubtitle = "Originated by Nyx",
    ConfigurationSaving = { Enabled = true, FolderName = "VexusHub", FileName = "AnimeGrassV4" }
})

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local LocalPlayer = Players.LocalPlayer

local Vexus = {
    AutoFarm = false, AutoCollect = false, AutoCarry = false,
    AutoCharacters = false, AutoUpgrade = false, AutoRebirth = false,
    DeleteGrass = false, AutoSell = false,
    WalkSpeed = 16, JumpPower = 50,
    RarityFilter = "Rare"
}

-- Dynamic Remote Finder
local function findRemote(keyword)
    for _, v in ipairs(ReplicatedStorage:GetDescendants()) do
        if (v:IsA("RemoteEvent") or v:IsA("RemoteFunction")) and string.find(string.lower(v.Name), string.lower(keyword)) then
            return v
        end
    end
    return nil
end

-- ==================== SMART AUTO FARM (with objective) ====================
local function autoFarm()
    while Vexus.AutoFarm and task.wait(0.08) do
        pcall(function()
            local cutRemote = findRemote("Cut") or findRemote("Harvest") or findRemote("Grass") or findRemote("Slash")
            if cutRemote then
                for _, obj in ipairs(Workspace:GetDescendants()) do
                    if obj.Name:lower():find("grass") or obj.Name:lower():find("bush") or obj:FindFirstChild("Cuttable") then
                        cutRemote:FireServer(obj)  -- ← THIS is the "objective"
                        task.wait(0.03)
                    end
                end
            end
        end)
    end
end

-- ==================== SMART AUTO PICKUP ====================
local function autoCollect()
    while Vexus.AutoCollect and task.wait(0.2) do
        pcall(function()
            for _, drop in ipairs(Workspace:GetDescendants()) do
                if drop:FindFirstChild("TouchInterest") then
                    local rarityVal = drop:FindFirstChild("Rarity") or drop:FindFirstChild("Value") or drop.Name
                    local rarity = tostring(rarityVal):lower()
                    if Vexus.RarityFilter == "All" or string.find(rarity, Vexus.RarityFilter:lower()) then
                        firetouchinterest(LocalPlayer.Character.HumanoidRootPart, drop, 0)
                        task.wait(0.03)
                    end
                end
            end
        end)
    end
end

-- ==================== AUTO CARRY / CLAIM / UPGRADE ====================
local function autoCarry()
    while Vexus.AutoCarry and task.wait(0.4) do pcall(function()
        local carry = findRemote("Carry") or findRemote("Bring") or findRemote("Bag")
        if carry then carry:FireServer() end
    end) end
end

local function autoCharacters()
    while Vexus.AutoCharacters and task.wait(0.9) do
        pcall(function()
            local claim = findRemote("Claim") or findRemote("Summon") or findRemote("GetAnime") or findRemote("CollectChar")
            if claim then
                for _, char in ipairs(Workspace:GetDescendants()) do
                    if char.Name:lower():find("character") or char:FindFirstChild("Anime") then
                        claim:FireServer(char)
                        task.wait(0.05)
                    end
                end
            end
        end)
    end
end

local function autoUpgrade() while Vexus.AutoUpgrade and task.wait(1.8) do pcall(function() local up = findRemote("Upgrade") or findRemote("Buy") if up then up:FireServer() end end) end end
local function autoRebirth() while Vexus.AutoRebirth and task.wait(5) do pcall(function() local reb = findRemote("Rebirth") if reb then reb:FireServer() end end) end end

local function deleteGrass()
    while Vexus.DeleteGrass and task.wait(0.1) do
        pcall(function()
            for _, obj in ipairs(Workspace:GetDescendants()) do
                if obj.Name:lower():find("grass") or obj.Name:lower():find("bush") then
                    obj:Destroy()
                end
            end
        end)
    end
end

-- ==================== TABS & GUI ====================
local MainTab = Window:CreateTab("Main", 4483362458)
local PickupTab = Window:CreateTab("Pickup", 4483362458)
local FarmingTab = Window:CreateTab("Farming", 4483362458)
local CharactersTab = Window:CreateTab("Characters", 4483362458)
local MiscTab = Window:CreateTab("Misc", 4483362458)

MainTab:CreateToggle({Name = "Auto Farm (Smart Cut)", CurrentValue = false, Callback = function(v) Vexus.AutoFarm = v if v then task.spawn(autoFarm) end end})
MainTab:CreateToggle({Name = "Auto Carry Grass", CurrentValue = false, Callback = function(v) Vexus.AutoCarry = v if v then task.spawn(autoCarry) end end})

PickupTab:CreateDropdown({Name = "Rarity Filter", Options = {"All","Common","Uncommon","Rare","Legendary","Godly"}, CurrentOption = {"Rare"}, Callback = function(opt) Vexus.RarityFilter = opt[1] end})
PickupTab:CreateToggle({Name = "Auto Collect / Pickup Drops", CurrentValue = false, Callback = function(v) Vexus.AutoCollect = v if v then task.spawn(autoCollect) end end})

FarmingTab:CreateToggle({Name = "Auto Upgrade", CurrentValue = false, Callback = function(v) Vexus.AutoUpgrade = v if v then task.spawn(autoUpgrade) end end})
FarmingTab:CreateToggle({Name = "Auto Rebirth", CurrentValue = false, Callback = function(v) Vexus.AutoRebirth = v if v then task.spawn(autoRebirth) end end})
FarmingTab:CreateToggle({Name = "Delete Grass (Instant)", CurrentValue = false, Callback = function(v) Vexus.DeleteGrass = v if v then task.spawn(deleteGrass) end end})

CharactersTab:CreateToggle({Name = "Auto Claim Anime Characters", CurrentValue = false, Callback = function(v) Vexus.AutoCharacters = v if v then task.spawn(autoCharacters) end end})

MiscTab:CreateSlider({Name = "WalkSpeed", Range = {16, 350}, Increment = 1, CurrentValue = 16, Callback = function(v) Vexus.WalkSpeed = v; if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then LocalPlayer.Character.Humanoid.WalkSpeed = v end end})
MiscTab:CreateSlider({Name = "JumpPower", Range = {50, 350}, Increment = 1, CurrentValue = 50, Callback = function(v) Vexus.JumpPower = v; if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then LocalPlayer.Character.Humanoid.JumpPower = v end end})

MiscTab:CreateButton({
    Name = "🔧 DEBUG: Print Game Structure (F9)",
    Callback = function()
        print("=== VEXUS v4 DEBUG - WORKSPACE ===")
        for _, folder in ipairs(Workspace:GetChildren()) do
            print("Folder:", folder.Name, " | Children:", #folder:GetChildren())
        end
        print("=== REMOTES FOUND ===")
        for _, v in ipairs(ReplicatedStorage:GetDescendants()) do
            if v:IsA("RemoteEvent") or v:IsA("RemoteFunction") then
                print(v:GetFullName())
            end
        end
        Rayfield:Notify("Vexus v4", "Check F9 console! Copy the output and send it to me.", 10)
    end
})

Rayfield:Notify("Vexus Hub v4", "Smart targeting enabled! Turn on Auto Farm + Debug button first.", 10)
print("✅ Vexus Hub v4 loaded - Smart objectives fixed")
