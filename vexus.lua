--[=[
    Vexus Hub v2 | Cut Grass for Anime Characters
    Full GUI Cheat - Multiple Tabs - Fixed 2026
    Hosted by Nyx
]=]

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
    Name = "Vexus Hub v2 - Cut Grass for Anime Characters",
    LoadingTitle = "Vexus Hub v2",
    LoadingSubtitle = "by Grok • Fixed & Extended",
    ConfigurationSaving = { Enabled = true, FolderName = "VexusHub", FileName = "AnimeGrassV2" }
})

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

local Vexus = {
    AutoFarm = false, AutoCollect = false, AutoCarry = false,
    AutoCharacters = false, AutoUpgrade = false, AutoRebirth = false,
    DeleteGrass = false, AutoSell = false, AutoClaim = false,
    WalkSpeed = 16, JumpPower = 50, Noclip = false, Fly = false
}

-- ==================== CORE FUNCTIONS (with extra safety) ====================
local function fireRemote(name)
    pcall(function()
        local remote = ReplicatedStorage:FindFirstChild(name) or ReplicatedStorage:FindFirstChild("CutEvent") or ReplicatedStorage:FindFirstChild("CutGrass")
        if remote then remote:FireServer() end
    end)
end

local function autoFarm()
    while Vexus.AutoFarm and task.wait(0.08) do pcall(function() fireRemote("CutEvent") end) end
end

local function autoCollect()
    while Vexus.AutoCollect and task.wait(0.25) do pcall(function()
        for _, drop in ipairs(Workspace:FindFirstChild("Drops") and Workspace.Drops:GetChildren() or {}) do
            if drop:FindFirstChild("TouchInterest") then
                firetouchinterest(LocalPlayer.Character.HumanoidRootPart, drop, 0)
                task.wait(0.03)
            end
        end
    end) end
end

local function autoCarry()
    while Vexus.AutoCarry and task.wait(0.4) do pcall(function() fireRemote("CarryEvent") end) end
end

local function autoCharacters()
    while Vexus.AutoCharacters and task.wait(0.8) do pcall(function() fireRemote("SummonCharacter") end) end
end

local function autoUpgrade()
    while Vexus.AutoUpgrade and task.wait(1.5) do pcall(function() fireRemote("UpgradeEvent") end) end
end

local function autoRebirth()
    while Vexus.AutoRebirth and task.wait(4) do pcall(function() fireRemote("RebirthEvent") end) end
end

local function deleteGrass()
    while Vexus.DeleteGrass and task.wait(0.15) do pcall(function()
        for _, grass in ipairs(Workspace:FindFirstChild("Grass") and Workspace.Grass:GetChildren() or {}) do grass:Destroy() end
    end) end
end

local function autoSell()
    while Vexus.AutoSell and task.wait(2) do pcall(function() fireRemote("SellEvent") end) end
end

-- ==================== TABS ====================
local MainTab = Window:CreateTab("Main", 4483362458)
local FarmingTab = Window:CreateTab("Farming", 4483362458)
local CharactersTab = Window:CreateTab("Characters", 4483362458)
local MiscTab = Window:CreateTab("Misc", 4483362458)
local CodesTab = Window:CreateTab("Codes", 4483362458)

-- MAIN TAB
MainTab:CreateToggle({Name = "Auto Farm (Cut Grass)", CurrentValue = false, Callback = function(v) Vexus.AutoFarm = v if v then task.spawn(autoFarm) end end})
MainTab:CreateToggle({Name = "Auto Collect / Pickup", CurrentValue = false, Callback = function(v) Vexus.AutoCollect = v if v then task.spawn(autoCollect) end end})
MainTab:CreateToggle({Name = "Auto Carry Grass", CurrentValue = false, Callback = function(v) Vexus.AutoCarry = v if v then task.spawn(autoCarry) end end})

-- FARMING TAB
FarmingTab:CreateToggle({Name = "Auto Upgrade", CurrentValue = false, Callback = function(v) Vexus.AutoUpgrade = v if v then task.spawn(autoUpgrade) end end})
FarmingTab:CreateToggle({Name = "Auto Rebirth", CurrentValue = false, Callback = function(v) Vexus.AutoRebirth = v if v then task.spawn(autoRebirth) end end})
FarmingTab:CreateToggle({Name = "Delete Grass (Clear Map)", CurrentValue = false, Callback = function(v) Vexus.DeleteGrass = v if v then task.spawn(deleteGrass) end end})
FarmingTab:CreateToggle({Name = "Auto Sell Grass", CurrentValue = false, Callback = function(v) Vexus.AutoSell = v if v then task.spawn(autoSell) end end})

-- CHARACTERS TAB
CharactersTab:CreateToggle({Name = "Auto Get / Summon Anime Characters", CurrentValue = false, Callback = function(v) Vexus.AutoCharacters = v if v then task.spawn(autoCharacters) end end})
CharactersTab:CreateButton({Name = "Instant Claim All Characters", Callback = function() pcall(function() fireRemote("ClaimAll") end) end})

-- MISC TAB
MiscTab:CreateSlider({Name = "WalkSpeed", Range = {16, 350}, Increment = 1, CurrentValue = 16, Callback = function(v) Vexus.WalkSpeed = v; if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then LocalPlayer.Character.Humanoid.WalkSpeed = v end end})
MiscTab:CreateSlider({Name = "JumpPower", Range = {50, 350}, Increment = 1, CurrentValue = 50, Callback = function(v) Vexus.JumpPower = v; if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then LocalPlayer.Character.Humanoid.JumpPower = v end end})
MiscTab:CreateToggle({Name = "Anti-AFK", CurrentValue = false, Callback = function(v) 
    if v then
        task.spawn(function()
            while v and task.wait(30) do game:GetService("VirtualUser"):Button1Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame) end
        end)
    end
end})

-- CODES TAB (updated from May 2026 videos)
CodesTab:CreateButton({
    Name = "Redeem ALL Latest Codes (2026)",
    Callback = function()
        local codes = {"SpeedUpsPart2","2ndUpdateLesGooo!!!","UseThisForGalaxies","NewPlayersOnly","HolySpeedUps","SomeSpeedUps","NewUpdate!!!","ApexRush2026","LightCode","OPCode2026"}
        for _, code in ipairs(codes) do
            pcall(function()
                local event = ReplicatedStorage:FindFirstChild("RedeemCode") or ReplicatedStorage:FindFirstChild("CodeEvent")
                if event then event:FireServer(code) end
            end)
            task.wait(0.8)
        end
        Rayfield:Notify("Vexus v2", "All 2026 codes attempted!", 6)
    end,
})

Rayfield:Notify("Vexus Hub v2", "Loaded! Upload done? Test on alt.", 8)
print("✅ Vexus Hub v2 loaded successfully - Cut Grass for Anime Characters")
