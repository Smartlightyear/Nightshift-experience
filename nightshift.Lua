local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()

local Window = OrionLib:MakeWindow({Name = "Night Shift Helper", HidePremium = false, SaveConfig = true, ConfigFolder = "NightShiftConfig"})

-- Main Tab
local MainTab = Window:MakeTab({
    Name = "Main Features",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

-- Player Tab
local PlayerTab = Window:MakeTab({
    Name = "Player",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

-- Main Features
MainTab:AddToggle({
    Name = "Auto Collect Cash",
    Default = false,
    Callback = function(Value)
        _G.AutoCollect = Value
        while _G.AutoCollect and wait() do
            for _, v in pairs(workspace:GetDescendants()) do
                if v.Name == "Cash" and v:IsA("Model") then
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.PrimaryPart.CFrame
                    wait(0.1)
                end
            end
        end
    end
})

MainTab:AddToggle({
    Name = "Auto Complete Tasks",
    Default = false,
    Callback = function(Value)
        _G.AutoTasks = Value
        while _G.AutoTasks and wait() do
            for _, v in pairs(workspace:GetDescendants()) do
                if v.Name == "TaskPart" and v:IsA("Part") then
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.CFrame
                    wait(0.5)
                    fireproximityprompt(v.TaskPrompt)
                end
            end
        end
    end
})

-- Player Features
PlayerTab:AddSlider({
    Name = "WalkSpeed",
    Min = 16,
    Max = 500,
    Default = 16,
    Color = Color3.fromRGB(255,255,255),
    Increment = 1,
    ValueName = "Speed",
    Callback = function(Value)
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
    end    
})

PlayerTab:AddSlider({
    Name = "JumpPower",
    Min = 50,
    Max = 500,
    Default = 50,
    Color = Color3.fromRGB(255,255,255),
    Increment = 1,
    ValueName = "Power",
    Callback = function(Value)
        game.Players.LocalPlayer.Character.Humanoid.JumpPower = Value
    end    
})

PlayerTab:AddToggle({
    Name = "Noclip",
    Default = false,
    Callback = function(Value)
        _G.Noclip = Value
        game:GetService("RunService").RenderStepped:Connect(function()
            if _G.Noclip then
                game.Players.LocalPlayer.Character.Humanoid:ChangeState(11)
            end
        end)
    end
})

OrionLib:Init()
