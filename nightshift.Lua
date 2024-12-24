local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()
local Window = OrionLib:MakeWindow({
    Name = "YoNoodle Hub | Night Shift", 
    HidePremium = false, 
    SaveConfig = true, 
    ConfigFolder = "YoNoodleConfig",
    IntroIcon = "rbxassetid://99710104300936",
    IntroText = "YoNoodle Hub"
})

-- Tabs
local MainTab = Window:MakeTab({Name = "Main Features", Icon = "rbxassetid://4483345998", PremiumOnly = false})
local PlayerTab = Window:MakeTab({Name = "Player", Icon = "rbxassetid://4483345998", PremiumOnly = false})
local ESPTab = Window:MakeTab({Name = "ESP", Icon = "rbxassetid://4483345998", PremiumOnly = false})
local TeleportTab = Window:MakeTab({Name = "Teleports", Icon = "rbxassetid://4483345998", PremiumOnly = false})

-- ESP Functions
local function createESP(object, color, text)
    local esp = Instance.new("Highlight")
    esp.Name = "ESP"
    esp.FillColor = color
    esp.OutlineColor = color
    esp.FillTransparency = 0.5
    esp.Parent = object

    local billboardGui = Instance.new("BillboardGui")
    billboardGui.Size = UDim2.new(0, 200, 0, 50)
    billboardGui.AlwaysOnTop = true
    billboardGui.Parent = object

    local textLabel = Instance.new("TextLabel")
    textLabel.Size = UDim2.new(1, 0, 1, 0)
    textLabel.BackgroundTransparency = 1
    textLabel.TextColor3 = Color3.new(1, 1, 1)
    textLabel.Text = text
    textLabel.Parent = billboardGui
end

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

MainTab:AddToggle({
    Name = "Auto Kill Enemies",
    Default = false,
    Callback = function(Value)
        _G.AutoKill = Value
        while _G.AutoKill and wait() do
            for _, v in pairs(workspace:GetDescendants()) do
                if v.Name == "Enemy" and v:IsA("Model") then
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.PrimaryPart.CFrame
                    wait(0.1)
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

-- ESP Features
ESPTab:AddToggle({
    Name = "Cash ESP",
    Default = false,
    Callback = function(Value)
        _G.CashESP = Value
        while _G.CashESP do
            for _, v in pairs(workspace:GetDescendants()) do
                if v.Name == "Cash" and v:IsA("Model") and not v:FindFirstChild("ESP") then
                    createESP(v, Color3.fromRGB(0, 255, 0), "Cash")
                end
            end
            wait(1)
        end
    end
})

ESPTab:AddToggle({
    Name = "Task ESP",
    Default = false,
    Callback = function(Value)
        _G.TaskESP = Value
        while _G.TaskESP do
            for _, v in pairs(workspace:GetDescendants()) do
                if v.Name == "TaskPart" and not v:FindFirstChild("ESP") then
                    createESP(v, Color3.fromRGB(255, 165, 0), "Task")
                end
            end
            wait(1)
        end
    end
})

ESPTab:AddToggle({
    Name = "Enemy ESP",
    Default = false,
    Callback = function(Value)
        _G.EnemyESP = Value
        while _G.EnemyESP do
            for _, v in pairs(workspace:GetDescendants()) do
                if v.Name == "Enemy" and not v:FindFirstChild("ESP") then
                    createESP(v, Color3.fromRGB(255, 0, 0), "Enemy")
                end
            end
            wait(1)
        end
    end
})

-- Teleport Features
TeleportTab:AddButton({
    Name = "Teleport to Safe Zone",
    Callback = function()
        if workspace:FindFirstChild("SafeZone") then
            game.Players.LocalPlayer.Character:MoveTo(workspace.SafeZone.Position)
        end
    end
})

TeleportTab:AddButton({
    Name = "Teleport to Shop",
    Callback = function()
        if workspace:FindFirstChild("Shop") then
            game.Players.LocalPlayer.Character:MoveTo(workspace.Shop.Position)
        end
    end
})

-- Additional Features
MainTab:AddToggle({
    Name = "Instant Task Complete",
    Default = false,
    Callback = function(Value)
        _G.InstantTask = Value
        if Value then
            for _, v in pairs(workspace:GetDescendants()) do
                if v:IsA("ProximityPrompt") then
                    v.HoldDuration = 0
                end
            end
        end
    end
})

MainTab:AddToggle({
    Name = "Auto Collect All Items",
    Default = false,
    Callback = function(Value)
        _G.AutoCollectAll = Value
        while _G.AutoCollectAll and wait() do
            for _, v in pairs(workspace:GetDescendants()) do
                if v:IsA("ProximityPrompt") then
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.Parent.CFrame
                    wait(0.1)
                    fireproximityprompt(v)
                end
            end
        end
    end
})

OrionLib:Init()

