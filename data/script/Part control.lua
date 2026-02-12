if not game:IsLoaded() then game.Loaded:Wait() end

local S = {
    P = game:GetService("Players"),
    U = game:GetService("UserInputService"),
    R = game:GetService("RunService"),
    C = game:GetService("CoreGui"),
    T = game:GetService("TweenService")
}

local LP = S.P.LocalPlayer
local SelectedPart = nil
local TargetCFrame = nil

local IsFollowing = false
local IsTrolling = false
local TrollTick = 0
local ControlsEnabled = false
local HoldingUp = false
local HoldingDown = false

local function ClaimNetwork(part)
    task.spawn(function()
        while SelectedPart == part do
            pcall(function()
                sethiddenproperty(LP, "SimulationRadius", math.huge)
                sethiddenproperty(LP, "MaxSimulationRadius", math.huge)
                settings().Physics.AllowSleep = false
            end)
            task.wait(0.1)
        end
    end)
end


local Gui = Instance.new("ScreenGui", S.C)
Gui.Name = "SuperPartControl_V2"

local MainFrame = Instance.new("Frame", Gui)
MainFrame.Size = UDim2.fromOffset(180, 360) -- Formato Vertical
MainFrame.Position = UDim2.new(0.05, 0, 0.2, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
MainFrame.BackgroundTransparency = 0.75
MainFrame.Active = true
MainFrame.Draggable = true
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 10)

local TopBar = Instance.new("Frame", MainFrame)
TopBar.Size = UDim2.new(1, 0, 0, 30)
TopBar.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
TopBar.BackgroundTransparency = 0.5
local TBTitle = Instance.new("TextLabel", TopBar)
TBTitle.Size = UDim2.new(1, -30, 1, 0)
TBTitle.Text = "Super Part Control V2"
TBTitle.TextColor3 = Color3.new(1, 1, 1)
TBTitle.TextSize = 12
TBTitle.Font = Enum.Font.GothamBold
TBTitle.BackgroundTransparency = 1
Instance.new("UICorner", TopBar).CornerRadius = UDim.new(0, 10)

local MinBtn = Instance.new("TextButton", Gui)
MinBtn.Size = UDim2.fromOffset(13, 13)
MinBtn.Position = UDim2.new(0.05, 0, 0.2, 0)
MinBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
MinBtn.BackgroundTransparency = 0.75
MinBtn.Text = "P"
MinBtn.Font = Enum.Font.GothamBold
MinBtn.Visible = false
Instance.new("UICorner", MinBtn).CornerRadius = UDim.new(1, 0)

local CloseBtn = Instance.new("TextButton", TopBar)
CloseBtn.Size = UDim2.fromOffset(20, 20)
CloseBtn.Position = UDim2.new(1, -25, 0, 5)
CloseBtn.Text = "−"
CloseBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
CloseBtn.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", CloseBtn)

local BtnContainer = Instance.new("Frame", MainFrame)
BtnContainer.Position = UDim2.new(0, 0, 0, 35)
BtnContainer.Size = UDim2.new(1, 0, 1, -40)
BtnContainer.BackgroundTransparency = 1

local Layout = Instance.new("UIListLayout", BtnContainer)
Layout.FillDirection = Enum.FillDirection.Vertical
Layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
Layout.Padding = UDim.new(0, 5)

local function CreateBtn(text, color)
    local b = Instance.new("TextButton", BtnContainer)
    b.Size = UDim2.new(0.9, 0, 0, 38)
    b.BackgroundColor3 = color
    b.BackgroundTransparency = 0.3
    b.Text = text
    b.TextColor3 = Color3.new(1,1,1)
    b.Font = Enum.Font.GothamBold
    b.TextSize = 11
    Instance.new("UICorner", b)
    return b
end

local btnSelect   = CreateBtn("TRAVAR ABAIXO", Color3.fromRGB(0, 200, 100))
local btnMove     = CreateBtn("ATIVAR SETAS 3D", Color3.fromRGB(0, 120, 255))
local btnFollow   = CreateBtn("SEGUIR: OFF", Color3.fromRGB(150, 0, 255))
local btnTroll    = CreateBtn("TROLL: OFF", Color3.fromRGB(255, 100, 0))
local btnControls = CreateBtn("BOTÕES TELA: OFF", Color3.fromRGB(100, 100, 100))
local btnDrop     = CreateBtn("DESATIVAR TUDO", Color3.fromRGB(200, 0, 0))


local MobileFrame = Instance.new("Frame", Gui)
MobileFrame.Size = UDim2.fromOffset(60, 130)
MobileFrame.Position = UDim2.new(1, -110, 1, -235) -- 35px acima do botão de pulo padrão
MobileFrame.BackgroundTransparency = 1
MobileFrame.Visible = false

local function CreateArrow(text, pos)
    local b = Instance.new("TextButton", MobileFrame)
    b.Size = UDim2.fromOffset(55, 55)
    b.Position = pos
    b.BackgroundColor3 = Color3.new(0,0,0)
    b.BackgroundTransparency = 0.5
    b.Text = text
    b.TextColor3 = Color3.new(1,1,1)
    b.TextSize = 25
    Instance.new("UICorner", b).CornerRadius = UDim.new(1, 0)
    return b
end

local arrowUp = CreateArrow("↑", UDim2.new(0, 0, 0, 0))
local arrowDown = CreateArrow("↓", UDim2.new(0, 0, 0, 65))


CloseBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
    MinBtn.Visible = true
end)

MinBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = true
    MinBtn.Visible = false
end)


local SelectionOutline = Instance.new("SelectionBox", workspace)
SelectionOutline.LineThickness = 0.2
SelectionOutline.Color3 = Color3.fromRGB(0, 255, 255)
local MoveHandles = Instance.new("Handles", Gui)

local function ClearSelection()
    SelectedPart = nil
    TargetCFrame = nil
    IsFollowing = false
    IsTrolling = false
    SelectionOutline.Adornee = nil
    MoveHandles.Adornee = nil
    btnFollow.Text = "SEGUIR: OFF"
    btnTroll.Text = "TROLL: OFF"
end

btnSelect.MouseButton1Click:Connect(function()
    if not LP.Character or not LP.Character:FindFirstChild("HumanoidRootPart") then return end
    local params = RaycastParams.new()
    params.FilterType = Enum.RaycastFilterType.Exclude
    params.FilterDescendantsInstances = {LP.Character}
    local res = workspace:Raycast(LP.Character.HumanoidRootPart.Position, Vector3.new(0, -50, 0), params)
    if res and res.Instance and res.Instance:IsA("BasePart") and not res.Instance.Anchored then
        ClearSelection()
        SelectedPart = res.Instance
        TargetCFrame = SelectedPart.CFrame
        SelectionOutline.Adornee = SelectedPart
        SelectedPart.CustomPhysicalProperties = PhysicalProperties.new(100, 0.3, 0.5, 100, 100)
        ClaimNetwork(SelectedPart)
    end
end)

btnMove.MouseButton1Click:Connect(function()
    if SelectedPart then MoveHandles.Adornee = SelectedPart end
end)

btnFollow.MouseButton1Click:Connect(function()
    IsFollowing = not IsFollowing
    btnFollow.Text = IsFollowing and "SEGUIR: ON" or "SEGUIR: OFF"
end)

btnTroll.MouseButton1Click:Connect(function()
    IsTrolling = not IsTrolling
    btnTroll.Text = IsTrolling and "TROLL: ON" or "TROLL: OFF"
end)

btnControls.MouseButton1Click:Connect(function()
    ControlsEnabled = not ControlsEnabled
    MobileFrame.Visible = ControlsEnabled
    btnControls.Text = ControlsEnabled and "BOTÕES TELA: ON" or "BOTÕES TELA: OFF"
end)

btnDrop.MouseButton1Click:Connect(ClearSelection)

arrowUp.MouseButton1Down:Connect(function() HoldingUp = true end)
arrowUp.MouseButton1Up:Connect(function() HoldingUp = false end)
arrowDown.MouseButton1Down:Connect(function() HoldingDown = true end)
arrowDown.MouseButton1Up:Connect(function() HoldingDown = false end)

task.spawn(function()
    while task.wait() do
        if TargetCFrame then
            if HoldingUp then TargetCFrame = TargetCFrame * CFrame.new(0, 0.5, 0) end
            if HoldingDown then TargetCFrame = TargetCFrame * CFrame.new(0, -0.5, 0) end
        end
    end
end)

local lastDist = 0
MoveHandles.MouseDrag:Connect(function(face, distance)
    if not TargetCFrame then return end
    local delta = math.floor(distance) - lastDist
    TargetCFrame = TargetCFrame * CFrame.new(Vector3.FromNormalId(face) * delta)
    lastDist = math.floor(distance)
end)
MoveHandles.MouseButton1Up:Connect(function() lastDist = 0 end)


S.R.PreRender:Connect(function()
    if SelectedPart and TargetCFrame then
        if IsFollowing and LP.Character and LP.Character:FindFirstChild("HumanoidRootPart") then
            local pPos = LP.Character.HumanoidRootPart.Position
            TargetCFrame = CFrame.new(pPos.X, TargetCFrame.Y, pPos.Z) * (TargetCFrame - TargetCFrame.Position)
        end
        
        local finalCFrame = TargetCFrame
        if IsTrolling then
            TrollTick = TrollTick + 0.5
            finalCFrame = TargetCFrame * CFrame.new(0, math.sin(TrollTick) * 5, 0)
        end

        SelectedPart.CFrame = finalCFrame
        SelectedPart.AssemblyLinearVelocity = Vector3.zero
        SelectedPart.AssemblyAngularVelocity = Vector3.zero
    end
end)

S.R.Heartbeat:Connect(function()
    if SelectedPart and TargetCFrame then
        SelectedPart.Velocity = Vector3.new(0, 0.05, 0)
    end
end)
