local player = game.Players.LocalPlayer

function CreateTab(params)
    local screenGui = Instance.new("ScreenGui")
    screenGui.Parent = game:WaitForChild("CoreGui")

    local tabFrame = Instance.new("Frame")
    tabFrame.Name = params.TABNAME
    tabFrame.Position = params.POSITION
    tabFrame.Size = params.SIZE or UDim2.new(0, 200, 0, 50)
    tabFrame.BackgroundTransparency = 0.5

    local gradient = Instance.new("UIGradient")
    gradient.Rotation = 90
    gradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(40, 40, 40)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(30, 30, 60)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(30, 30, 70))
    }
    gradient.Parent = tabFrame

    local uiStroke = Instance.new("UIStroke")
    uiStroke.Thickness = 2
    uiStroke.Color = Color3.new(0, 0, 0)
    uiStroke.Parent = tabFrame

    local uiCorner = Instance.new("UICorner")
    uiCorner.CornerRadius = UDim.new(0, 8)
    uiCorner.Parent = tabFrame

    local titleLabel = Instance.new("TextLabel")
    titleLabel.Name = "TitleLabel"
    titleLabel.Parent = tabFrame
    titleLabel.Size = UDim2.new(1, 0, 0, 20)
    titleLabel.Position = UDim2.new(0, 0, 0, 5)
    titleLabel.Text = params.NAME
    titleLabel.TextSize = 32
    titleLabel.Font = Enum.Font.DenkOne
    titleLabel.TextColor3 = Color3.new(1, 1, 1)
    titleLabel.TextStrokeTransparency = 0
    titleLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
    titleLabel.BackgroundTransparency = 1

    tabFrame.Parent = screenGui

    return tabFrame
end







function CreateToggle(params)
    local toggleButton = Instance.new("TextButton")
    toggleButton.Name = params.Name
    toggleButton.Parent = params.ParentTab
    toggleButton.Position = params.Position or UDim2.new(0, 0, 0, 0)
    toggleButton.Size = UDim2.new(0, 200, 0, 30)
    toggleButton.BackgroundTransparency = 1
    toggleButton.Text = params.Name
    toggleButton.TextSize = 24
    toggleButton.Font = Enum.Font.DenkOne
    toggleButton.TextColor3 = Color3.new(1, 1, 1)
    toggleButton.TextStrokeTransparency = 1

    local filePath = "VortexClientSV.json"
    local toggleStates = {}

    local fileExists = pcall(readfile, filePath)

    if fileExists then
        local fileContent = readfile(filePath)
        if fileContent then
            local success, decodedContent = pcall(game.HttpService.JSONDecode, game.HttpService, fileContent)
            if success and decodedContent then
                toggleStates = decodedContent
            end
        end
    end

    local isToggled = toggleStates[params.Name] or params.DefaultValue or false

    toggleButton.MouseButton1Click:Connect(function()
        isToggled = not isToggled
        params.Callback(isToggled)

        toggleButton.TextColor3 = isToggled and Color3.new(0.5, 0, 0.8) or Color3.new(1, 1, 1)
        toggleButton.BackgroundColor3 = isToggled and Color3.new(0.2, 0.2, 0.2) or Color3.new(0, 0, 0)

        toggleStates[params.Name] = isToggled
        writefile(filePath, game.HttpService:JSONEncode(toggleStates))
    end)

    return toggleButton
end








function CreateTabToggle(params)
    local screenGui = Instance.new("ScreenGui")
    screenGui.Parent = game:WaitForChild("CoreGui")

    local toggleButton = Instance.new("TextButton")
    toggleButton.Name = "TabToggle"
    toggleButton.Parent = screenGui
    toggleButton.AnchorPoint = Vector2.new(1, 0.5)
    toggleButton.Position = params.Position or UDim2.new(0.95, 0, 0.4, 0)
    toggleButton.Size = params.Size or UDim2.new(0, 80, 0, 40)
    toggleButton.BackgroundTransparency = 0.5
    toggleButton.BackgroundColor3 = Color3.new(0, 0, 0)
    toggleButton.Text = "VC"
    toggleButton.TextSize = 18
    toggleButton.Font = Enum.Font.DenkOne
    toggleButton.TextColor3 = Color3.new(1, 1, 1)

    local uiStroke = Instance.new("UIStroke")
    uiStroke.Thickness = 1
    uiStroke.Color = Color3.new(0, 0, 0)
    uiStroke.Parent = toggleButton

    local uiCorner = Instance.new("UICorner")
    uiCorner.CornerRadius = UDim.new(0, 8)
    uiCorner.Parent = toggleButton

    local tabsEnabled = true  

    toggleButton.MouseButton1Click:Connect(function()
        tabsEnabled = not tabsEnabled
        params.Callback(tabsEnabled)

        toggleButton.TextColor3 = tabsEnabled and Color3.new(1, 1, 1) or Color3.new(0.5, 0, 0.8)
    end)

    toggleButton.Visible = true  

    return toggleButton
end










--Esp func
function Espf()



local player = game.Players.LocalPlayer
local myTeam = player.Team

local function createOutline(player)
    local torso = player.Character:FindFirstChild("HumanoidRootPart")
    
    if torso then
        local billboard = Instance.new("BillboardGui")
        billboard.Size = UDim2.new(4, 0, 4, 0)
        billboard.AlwaysOnTop = true
        
        local frame = Instance.new("Frame")
        frame.Size = UDim2.new(1, 0, 1.5, 0)
        frame.Position = UDim2.new(0, 0, -torso.Size.Y / 2, 0)
        frame.BackgroundTransparency = 1

        local stroke = Instance.new("UIStroke")
        stroke.Thickness = 2
        stroke.Color = Color3.new(1, 0, 0)
        stroke.Transparency = 0

        stroke.Parent = frame
        frame.Parent = billboard
        billboard.Parent = torso
    end
end

local function updateOutlines()
    for _, otherPlayer in pairs(game.Players:GetPlayers()) do
        if otherPlayer ~= player then
            if otherPlayer.Team ~= myTeam then
                createOutline(otherPlayer)
            else
                local billboard = otherPlayer.Character:FindFirstChild("HumanoidRootPart"):FindFirstChild("BillboardGui")
                if billboard then
                    billboard:Destroy()
                end
            end
        end
    end
end

while wait(1) do
    updateOutlines()
end



end










--PlayerTp Func

function tpToplayerF()
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")

local LocalPlayer = Players.LocalPlayer
local teleportationDelay = 4
local hasTeleported = false

function FindNearestPlayer()
    local nearestPlayer = nil
    local minDistance = math.huge

    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Team ~= LocalPlayer.Team then
            local character = player.Character
            if character and character:FindFirstChild("HumanoidRootPart") then
                local distance = (character.HumanoidRootPart.Position - LocalPlayer.Character.HumanoidRootPart.Position).magnitude
                if distance < minDistance then
                    nearestPlayer = character.HumanoidRootPart
                    minDistance = distance
                end
            end
        end
    end
    return nearestPlayer
end

function TweenToNearestPlayer()
    local nearestPlayerRootPart = FindNearestPlayer()
    if nearestPlayerRootPart and not hasTeleported then
        hasTeleported = true

        local humanoidRootPart = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if humanoidRootPart then
            local targetCFrame = nearestPlayerRootPart.CFrame + Vector3.new(0, 6, 0)
            local tweenInfo = TweenInfo.new(0.8) -- Set the duration to 1 second (adjust as needed)
            local tween = TweenService:Create(humanoidRootPart, tweenInfo, {CFrame = targetCFrame})
            tween:Play()
        end
    end
end

local humanoid = LocalPlayer.Character:WaitForChild("Humanoid")
humanoid.Health = 0

wait(teleportationDelay)
TweenToNearestPlayer()





end















--KillAura Function
function killaura()

local LocalPlayer = game.Players.LocalPlayer

local Camera = workspace.CurrentCamera

local KnitClient = debug.getupvalue(require(LocalPlayer.PlayerScripts.TS.knit).setup, 6)

local CombatConstants = require(game:GetService("ReplicatedStorage").TS.combat["combat-constant"]).CombatConstant
local BedwarsSwords = require(game:GetService("ReplicatedStorage").TS.games.bedwars["bedwars-swords"]).BedwarsMelees
local ClientHandlerStore = require(LocalPlayer.PlayerScripts.TS.ui.store).ClientStore
local SwordController = KnitClient.Controllers.SwordController

local Cooldown = true

local function GetInventory(Player)
	if not Player then 
		return {Items = {}, Armor = {}}
	end

	local Success, Return = pcall(function() 
		return require(game:GetService("ReplicatedStorage").TS.inventory["inventory-util"]).InventoryUtil.getInventory(Player)
	end)

	if not Success then 
		return {Items = {}, Armor = {}}
	end
	if Player.Character and Player.Character:FindFirstChild("InventoryFolder") then 
		local InvFolder = Player.Character:FindFirstChild("InventoryFolder").Value
		if not InvFolder then return Return end
		for i, v in next, Return do 
			for i2, v2 in next, v do 
				if typeof(v2) == 'table' and v2.itemType then
					v2.instance = InvFolder:FindFirstChild(v2.itemType)
				end
			end
			if typeof(v) == 'table' and v.itemType then
				v.instance = InvFolder:FindFirstChild(v.itemType)
			end
		end
	end
	return Return
end

function HashFunc(Vec)
	return {value = Vec}
end

function GetSword()
	local Highest, Returning = -9e9, nil
	for i, v in next, GetInventory(LocalPlayer).items do 
		local Power = table.find(BedwarsSwords, v.itemType)
		if not Power then continue end 
		if Power > Highest then 
			Returning = v
			Highest = Power
		end
	end
	return Returning
end

function IsAlive(Player)
	Player = Player or LocalPlayer
	if not Player.Character then return false end
	if not Player.Character:FindFirstChild("Head") then return false end
	if not Player.Character:FindFirstChild("Humanoid") then return false end
	if Player.Character:FindFirstChild("Humanoid").Health < 0.11 then return false end
	return true
end

function GetMatchState()
	return ClientHandlerStore:getState().Game.matchState
end

local OrigC0 = game:GetService("ReplicatedStorage").Assets.Viewmodel.RightHand.RightWrist.C0
local Animations = {
	["VerticalSpin"] = {
		{CFrame = CFrame.new(0, 0, 0) * CFrame.Angles(math.rad(-90), math.rad(8), math.rad(5)), Time = 0.1},
		{CFrame = CFrame.new(0, 0, 0) * CFrame.Angles(math.rad(180), math.rad(3), math.rad(13)), Time = 0.1},
		{CFrame = CFrame.new(0, 0, 0) * CFrame.Angles(math.rad(90), math.rad(-5), math.rad(8)), Time = 0.1},
		{CFrame = CFrame.new(0, 0, 0) * CFrame.Angles(math.rad(0), math.rad(0), math.rad(0)), Time = 0.1}
	}
}

local CurrentAnimation = {["Value"] = "VerticalSpin"}

spawn(function()
	repeat
		task.wait()
		for i, v in pairs(game:GetService("Players"):GetChildren()) do
			if v.Team ~= LocalPlayer.Team and IsAlive(v) and GetMatchState() ~= 0 and IsAlive(LocalPlayer) and not v.Character:FindFirstChildOfClass("ForceField") then
				local Magnitude = (v.Character:FindFirstChild("HumanoidRootPart").Position - LocalPlayer.Character:FindFirstChild("HumanoidRootPart").Position).Magnitude
				local Sword = GetSword()
				CombatConstants.RAYCAST_SWORD_CHARACTER_DISTANCE = 22
				if Sword ~= nil then
					
					spawn(function()
						if Cooldown and Magnitude < 18 then
							Cooldown = false
							for i, v in pairs(Animations[CurrentAnimation["Value"]]) do
								game:GetService("TweenService"):Create(Camera.Viewmodel.RightHand.RightWrist,TweenInfo.new(v.Time),{C0 = OrigC0 * v.CFrame}):Play()
								task.wait(v.Time - 0.01)
							end
							Cooldown = true
						end
					end)

					SwordController.lastAttack = game:GetService("Workspace"):GetServerTimeNow()
					local Args = {
						[1] = {
							["chargedAttack"] = {["chargeRatio"] = 0},
							["entityInstance"] = v.Character,
							["validate"] = {
								["targetPosition"] = HashFunc(v.Character:FindFirstChild("HumanoidRootPart").Position),
								["selfPosition"] = HashFunc(LocalPlayer.Character:FindFirstChild("HumanoidRootPart").Position + Vector3.new(0, -0.03, 0) + ((LocalPlayer.Character:FindFirstChild("HumanoidRootPart").Position - v.Character:FindFirstChild("HumanoidRootPart").Position).Magnitude > 14 and (CFrame.lookAt(LocalPlayer.Character:FindFirstChild("HumanoidRootPart").Position, v.Character:FindFirstChild("HumanoidRootPart").Position).LookVector * 4) or Vector3.new(0, 0, 0))),
							}, 
							["weapon"] = Sword.tool,
						}}
					game:GetService("ReplicatedStorage").rbxts_include.node_modules:FindFirstChild("@rbxts").net.out._NetManaged.SwordHit:FireServer(unpack(Args))
				end
			end
		end
	until not game
end)

end













--TpToBed Function
function TpToBed()
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")

local LocalPlayer = Players.LocalPlayer
local teleportationDelay = 4
local hasTeleported = false

function FindNearestBed()
    local nearestBed = nil
    local minDistance = math.huge

    for _, v in pairs(game.Workspace:GetDescendants()) do
        if v.Name:lower() == "bed" and v:FindFirstChild("Covers") and v:FindFirstChild("Covers").BrickColor ~= LocalPlayer.Team.TeamColor then
            local distance = (v.Position - LocalPlayer.Character.HumanoidRootPart.Position).magnitude
            if distance < minDistance then
                nearestBed = v
                minDistance = distance
            end
        end
    end
    return nearestBed
end

function TweenToNearestBed()
    local nearestBed = FindNearestBed()
    if nearestBed and not hasTeleported then
        hasTeleported = true

        local humanoidRootPart = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if humanoidRootPart then
            local targetCFrame = nearestBed.CFrame + Vector3.new(0, 6, 0)
            local tweenInfo = TweenInfo.new(0.8) 
            local tween = TweenService:Create(humanoidRootPart, tweenInfo, {CFrame = targetCFrame})
            tween:Play()
        end
    end
end


local humanoid = LocalPlayer.Character:WaitForChild("Humanoid")
humanoid.Health = 0


wait(teleportationDelay)
TweenToNearestBed()


end





--Tabs
local myTab = CreateTab({
    TABNAME = "CombatTab",
    POSITION = UDim2.new(0, 10, 0, 10),
    NAME = "Combat",
    SIZE = UDim2.new(0, 200, 0.8, 50)
})

local myTab2 = CreateTab({
    TABNAME = "UtlityTab",
    POSITION = UDim2.new(0, 220, 0, 10),
    NAME = "Utility",
    SIZE = UDim2.new(0, 200, 0.8, 50)
})



local myTab4 = CreateTab({
    TABNAME = "VisualsTab",
    POSITION = UDim2.new(0, 430, 0, 10),
    NAME = "Visuals",
    SIZE = UDim2.new(0, 200, 0.8, 50)
})


local myTab3 = CreateTab({
    TABNAME = "WorldTab",
    POSITION = UDim2.new(0, 640, 0, 10),
    NAME = "World",
    SIZE = UDim2.new(0, 200, 0.8, 50)
})















--TabToggle
CreateTabToggle({
    Position = UDim2.new(0.95, 0, 0.4, 0),
    Size = UDim2.new(0, 80, 0, 40),
    Callback = function(tabsEnabled)
        if tabsEnabled then
            myTab.Visible = true
            myTab2.Visible = true
            myTab3.Visible = true
            myTab4.Visible = true
            
        else
            myTab.Visible = false
            myTab2.Visible = false
            myTab3.Visible = false
            myTab4.Visible = false
            
        end
    end
})











--KILLAURA
CreateToggle({
    Name = "Killaura",
    ParentTab = myTab,
    Position = UDim2.new(0, 10, 0, 60),
    DefaultValue = false,
    Callback = function(isToggled)
        if isToggled then
       killaura()
       end
    end
})













--REACH
local settings = {
    reach = {
        enabled = false,
        range = 28,
    }
}

local reachDistance = settings.reach.range
local isReachEnabled = false

local function setReachDistance(distance)
    bedwars["CombatConstant"].RAYCAST_SWORD_CHARACTER_DISTANCE = distance
end

local function toggleReach()
    isReachEnabled = not isReachEnabled
    settings.reach.enabled = isReachEnabled

    if isReachEnabled then
        repeat
            wait()
            setReachDistance(reachDistance)
        until not isReachEnabled
    else
        repeat
            wait()
            setReachDistance(14.4)
        until isReachEnabled
    end
end

local reachToggle = false

local function toggleReachFunction()
    reachToggle = not reachToggle
    isReachEnabled = reachToggle
    settings.reach.enabled = reachToggle

    if reachToggle then
        spawn(toggleReach)
    end
end


CreateToggle({
    Name = "Reach",
    ParentTab = myTab,
    Position = UDim2.new(0, 10, 0, 100),
    DefaultValue = false,
    Callback = function(isToggled)
        toggleReachFunction()
        print("Toggle Reach is now:", isToggled)
    end
})















--Fly
local LocalPlayer = game.Players.LocalPlayer
local Settings = {
    Fly = {
        Value = false, -- Set to false to disable fly mode by default
        Up = 50,
        Down = 50,
    }
}

local flyup = false
local flydown = false
local velo
local UpValue = Settings.Fly.Up
local DownValue = Settings.Fly.Down

local function enableFly(enabledFly)
    if enabledFly then
        velo = Instance.new("BodyVelocity")
        velo.MaxForce = Vector3.new(0, 9e9, 0)
        velo.Parent = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")

        local UIS = game:GetService("UserInputService")
        UIS.InputBegan:Connect(function(input)
            if input.KeyCode == Enum.KeyCode.Space then
                flyup = true
            end
            if input.KeyCode == Enum.KeyCode.LeftShift then
                flydown = true
            end
        end)

        UIS.InputEnded:Connect(function(input)
            if input.KeyCode == Enum.KeyCode.Space then
                flyup = false
            end
            if input.KeyCode == Enum.KeyCode.LeftShift then
                flydown = false
            end
        end)

        spawn(function()
            while wait() do
                if not enabledFly then return end
                velo.Velocity = Vector3.new(0, (flyup and UpValue or 0) + (flydown and -DownValue or 0), 0)
            end
        end)
    elseif LocalPlayer.Character.HumanoidRootPart:FindFirstChild("BodyVelocity") then
        LocalPlayer.Character.HumanoidRootPart:FindFirstChild("BodyVelocity"):Destroy()
        flyup = false
        flydown = false
    end
end

local function onFlyToggleCallback(enabledFly)
    Settings.Fly.Value = enabledFly
    enableFly(enabledFly)
end


CreateToggle({
    Name = "Fly",
    ParentTab = myTab,
    Position = UDim2.new(0, 10, 0, 140),
    DefaultValue = false,
    Callback = function(isToggled)
        onFlyToggleCallback(isToggled)
        print("Toggle Fly is now:", isToggled)
    end
})

















--AutoSprint

local LocalPlayer = game.Players.LocalPlayer
local RunService = game:GetService("RunService")

local Sprinting = false

local function enableAutoSprint(enabled)
    if enabled then
        local KnitClient = debug.getupvalue(require(LocalPlayer.PlayerScripts.TS.knit).setup, 6)
        local SprintController = KnitClient.Controllers.SprintController
        Sprinting = true

        RunService.Heartbeat:Connect(function()
            if Sprinting then
                SprintController:startSprinting()
            end
        end)
    else
        Sprinting = false
    end
end

local function onAutoSprintToggleCallback(enabled)
    enableAutoSprint(enabled)
end



CreateToggle({
    Name = "AutoSprint",
    ParentTab = myTab,
    Position = UDim2.new(0, 10, 0, 180),
    DefaultValue = false,
    Callback = function(isToggled)
        onAutoSprintToggleCallback(isToggled)
        print("Toggle AutoSprint is now:", isToggled)
    end
})


local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

local isSpeedEnabled = false

local function updateSpeed()
    humanoid.WalkSpeed = isSpeedEnabled and 23 or 16 -- 
end

CreateToggle({
    Name = "Speed",
    ParentTab = myTab,
    Position = UDim2.new(0, 10, 0, 220),
    DefaultValue = false,
    Callback = function(isToggled)
        isSpeedEnabled = isToggled
        updateSpeed()
        while true do
    updateSpeed()
    wait(0.5)
end

    end
    
})







--BedTp

CreateToggle({
    Name = "BedTp",
    ParentTab = myTab2,
    Position = UDim2.new(0, 10, 0, 60),
    DefaultValue = false,
    Callback = function(isToggled)
    print("Toggle BedTp is now:", isToggled)
        TpToBed()
    end
})


CreateToggle({
    Name = "PlayerTp",
    ParentTab = myTab2,
    Position = UDim2.new(0, 10, 0, 100),
    DefaultValue = false,
    Callback = function(isToggled)
       tpToplayerF()
    end
})



















--AntiKb

local settings = {
    antiKb = {
        enabled = false,
        horizontalStrength = 100,
        verticalStrength = 100,
    }
}

local horizontalKb = settings.antiKb.horizontalStrength
local verticalKb = settings.antiKb.verticalStrength
local isAntiKbEnabled = false

local function getKnockbackTable()
    return debug.getupvalue(require(game:GetService("ReplicatedStorage").TS.damage["knockback-util"]).KnockbackUtil.calculateKnockbackVelocity, 1)
end

local function setKnockbackStrength(direction, strength)
    local knockbackTable = getKnockbackTable()

    if knockbackTable then
        knockbackTable["kb" .. direction .. "Strength"] = strength
    end
end

local function toggleAntiKb()
    isAntiKbEnabled = not isAntiKbEnabled
    settings.antiKb.enabled = isAntiKbEnabled

    if isAntiKbEnabled then
        setKnockbackStrength("Direction", horizontalKb)
        setKnockbackStrength("Upward", verticalKb)
    else
        setKnockbackStrength("Direction", 100)
        setKnockbackStrength("Upward", 100)
    end
end

local antiKbToggle = false

local function toggleAntiKbFunction()
    antiKbToggle = not antiKbToggle
    isAntiKbEnabled = antiKbToggle
    settings.antiKb.enabled = antiKbToggle

    if antiKbToggle then
        spawn(toggleAntiKb)
    end
end


CreateToggle({
    Name = "AntiKB",
    ParentTab = myTab2,
    Position = UDim2.new(0, 10, 0, 140),
    DefaultValue = false,
    Callback = function(isToggled)
        toggleAntiKbFunction()
        print("Toggle AntiKB is now:", isToggled)
    end
})














--NOFALL

local NofallEnabled = false
local Settings = {
    NoFall = {
        Value = false, -- Set the initial state as needed
    },
}

local function ToggleNoFall()
    NofallEnabled = not NofallEnabled
    Settings.NoFall.Value = NofallEnabled

    if NofallEnabled then
        spawn(function()
            repeat
                game:GetService("ReplicatedStorage").rbxts_include.node_modules:FindFirstChild("@rbxts").net.out._NetManaged.GroundHit:FireServer()
                wait(4)
            until not NofallEnabled
        end)
    end
end

-- Assuming your toggle API is named CreateToggle
CreateToggle({
    Name = "NoFall",
    ParentTab = myTab2,
    Position = UDim2.new(0, 10, 0, 180),


    DefaultValue = false,
    Callback = function(isToggled)
        ToggleNoFall()
        print("Toggle NoFall is now:", isToggled)
    end
})

















--rangeHl
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local highlights = {}
local isRangeHLEnabled = false

local function createPlayerHighlight(player)
    local highlight = Instance.new("Highlight")
    highlight.Parent = player.Character
    return highlight
end

local function isPlayerWithinRange(player, range)
    local character = player.Character
    local myCharacter = Players.LocalPlayer.Character
    if character and myCharacter then
        local playerPosition = character.PrimaryPart.Position
        local myPosition = myCharacter.PrimaryPart.Position
        local distance = (playerPosition - myPosition).Magnitude
        return distance <= range
    end
    return false
end

local function updateHighlights()
    local myPlayer = Players.LocalPlayer
    local highlightRange = 18

    for _, player in pairs(Players:GetPlayers()) do
        if player ~= myPlayer then
            if isPlayerWithinRange(player, highlightRange) then
                if not highlights[player] then
                    highlights[player] = createPlayerHighlight(player)
                end
            else
                if highlights[player] then
                    highlights[player]:Destroy()
                    highlights[player] = nil
                end
            end
        end
    end
end

local function enableRangeHL(enabled)
    isRangeHLEnabled = enabled
    if not enabled then
        for _, highlight in pairs(highlights) do
            highlight:Destroy()
        end
        highlights = {}
    end
end

local function onRangeHLToggleCallback(enabled)
    enableRangeHL(enabled)
end

CreateToggle({
    Name = "RangeHL",
    ParentTab = myTab2,
    Position = UDim2.new(0, 10, 0, 220),
    DefaultValue = true,
    Callback = function(isToggled)
        onRangeHLToggleCallback(isToggled)
        print("Toggle RangeHL is now:", isToggled)
    end
})

RunService.Heartbeat:Connect(function()
    if isRangeHLEnabled then
        updateHighlights()
    end
end)
















--InfJump
local InfiniteJumpEnabled = true

local function enableInfiniteJump(enabled)
    InfiniteJumpEnabled = enabled
end

local function onInfJumpToggleCallback(enabled)
    enableInfiniteJump(enabled)
end
CreateToggle({
    Name = "InfJump",
    ParentTab = myTab2,
    Position = UDim2.new(0, 10, 0, 260),
    DefaultValue = false,
    Callback = function(isToggled)
        onInfJumpToggleCallback(isToggled)
    end
})

game:GetService("UserInputService").JumpRequest:connect(function()
    if InfiniteJumpEnabled then
        game:GetService"Players".LocalPlayer.Character:FindFirstChildOfClass'Humanoid':ChangeState("Jumping")
    end
end)















--Nuker
local settings = {
    nuker = {
        enabled = false,
        range = 30,
    }
}

local nukerRange = settings.nuker.range
local isNukerEnabled = false
local localPlayer = game.Players.LocalPlayer

local function getServerPos(position)
    local x = math.round(position.X / 3)
    local y = math.round(position.Y / 3)
    local z = math.round(position.Z / 3)
    return Vector3.new(x, y, z)
end

local function fetchBeds()
    local beds = {}
    for _, bed in pairs(game.Workspace:GetChildren()) do
        if string.lower(bed.Name) == "bed" and bed:FindFirstChild("Covers") ~= nil and bed:FindFirstChild("Covers").Color ~= localPlayer.Team.TeamColor then
            table.insert(beds, bed)
        end
    end
    return beds
end

local function destroyBeds()
    repeat
        wait(0.1)
        if localPlayer.Character and localPlayer.Character:FindFirstChild("Humanoid") and localPlayer.Character:FindFirstChild("Humanoid").Health > 0.1 then
            local beds = fetchBeds()
            for _, bed in pairs(beds) do
                local distance = (bed.Position - localPlayer.Character:FindFirstChild("HumanoidRootPart").Position).Magnitude
                if distance < nukerRange then
                    game:GetService("ReplicatedStorage").rbxts_include.node_modules:FindFirstChild("@easy-games"):FindFirstChild("block-engine").node_modules:FindFirstChild("@rbxts").net.out._NetManaged.DamageBlock:InvokeServer({
                        ["blockRef"] = {
                            ["blockPosition"] = getServerPos(bed.Position)
                        },
                        ["hitPosition"] = getServerPos(bed.Position),
                        ["hitNormal"] = getServerPos(bed.Position)
                    })
                end
            end
        end
    until not isNukerEnabled
end

local function enableNuker(enabled)
    isNukerEnabled = enabled
    if not enabled then
    end
end

local function onNukerToggleCallback(enabled)
    enableNuker(enabled)
end


CreateToggle({
    Name = "Nuker (Beta)",
    ParentTab = myTab3,
    Position = UDim2.new(0, 10, 0, 60),
    DefaultValue = false,
    Callback = function(isToggled)
        onNukerToggleCallback(isToggled)
        print("Toggle Nuker (Beta) is now:", isToggled)
    end
})







--AntiVoid

local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

local isAntiVoidEnabled = false
local rainbowPart = Instance.new("Part")

local function createRainbowPart()
    local part = Instance.new("Part")
    part.Size = Vector3.new(10000, 1, 10000)
    part.Position = humanoid.Parent.Head.Position - Vector3.new(0, 14, 0)
    part.Anchored = true
    part.Velocity = Vector3.new(0, 45, 0)  
    part.Transparency = 0.5
    part.BrickColor = BrickColor.new("Bright violet")
    part.Material = Enum.Material.SmoothPlastic
    part.Parent = workspace
    return part
end

local function enableAntiVoid(enabled)
    isAntiVoidEnabled = enabled
    if not enabled and rainbowPart then
        rainbowPart:Destroy()
        rainbowPart = nil
    end
end

local function onAntiVoidToggleCallback(enabled)
    if enabled then
        rainbowPart = createRainbowPart()
    end
    enableAntiVoid(enabled)
end


CreateToggle({
    Name = "AntiVoid",
    ParentTab = myTab3,
    Position = UDim2.new(0, 10, 0, 100),
    DefaultValue = false,
    Callback = function(isToggled)
        onAntiVoidToggleCallback(isToggled)
        print("Toggle AntiVoid is now:", isToggled)
    end
})

local function setBlueVioletColor()
    if rainbowPart then
        local hue = tick() % 5 / 5
        rainbowPart.BrickColor = BrickColor.new(Color3.fromHSV(hue, 0.7, 1))
    end
end

game:GetService("RunService").RenderStepped:Connect(function()
    if isAntiVoidEnabled then
        setBlueVioletColor()
    end
end)



local SkyboxAssets = {
    "rbxassetid://14993957229", 
    "rbxassetid://14993958854", 
    "rbxassetid://14993961695", 
}

local isSkyboxEnabled = false
local selectedSkybox = SkyboxAssets[1]

local function setSkybox(assetID)
    local sky = Instance.new("Sky")
    sky.SkyboxBk = assetID
    sky.SkyboxDn = assetID
    sky.SkyboxFt = assetID
    sky.SkyboxLf = assetID
    sky.SkyboxRt = assetID
    sky.SkyboxUp = assetID

    sky.Parent = game.Lighting
end

local function enableSkybox(enabled)
    isSkyboxEnabled = enabled
    if enabled then
        setSkybox(selectedSkybox)
    else
        local existingSky = game.Lighting:FindFirstChild("Sky")
        if existingSky then
            existingSky:Destroy()
        end
    end
end

local function onSkyboxToggleCallback(enabled)
    enableSkybox(enabled)
end










--SkyBox


CreateToggle({
    Name = "Skybox",
    ParentTab = myTab3,
    Position = UDim2.new(0, 10, 0, 140),
    DefaultValue = false,
    Callback = function(isToggled)
        onSkyboxToggleCallback(isToggled)
    end
})









--Esp
local player = game.Players.LocalPlayer
local myTeam = player.Team
local espOutlines = {}

local function createOutline(player)
    local torso = player.Character:FindFirstChild("HumanoidRootPart")
    
    if torso then
        local billboard = Instance.new("BillboardGui")
        billboard.Size = UDim2.new(4, 0, 4, 0)
        billboard.AlwaysOnTop = true
        
        local frame = Instance.new("Frame")
        frame.Size = UDim2.new(1, 0, 1.5, 0)
        frame.Position = UDim2.new(0, 0, -torso.Size.Y / 2, 0)
        frame.BackgroundTransparency = 1

        local stroke = Instance.new("UIStroke")
        stroke.Thickness = 2
        stroke.Color = Color3.new(1, 0, 0)
        stroke.Transparency = 0

        stroke.Parent = frame
        frame.Parent = billboard
        billboard.Parent = torso

        table.insert(espOutlines, billboard)
    end
end

local function destroyOutlines()
    for _, billboard in pairs(espOutlines) do
        billboard:Destroy()
    end
    espOutlines = {}
end

local function updateOutlines()
    destroyOutlines()

    for _, otherPlayer in pairs(game.Players:GetPlayers()) do
        if otherPlayer ~= player then
            if otherPlayer.Team ~= myTeam then
                createOutline(otherPlayer)
            end
        end
    end
end

local isESPToggled = false

local function enableESP(enabled)
    isESPToggled = enabled
    if not enabled then
        destroyOutlines()
    else
        updateOutlines()
    end
end

local function onESPToggleCallback(enabled)
    enableESP(enabled)
end


CreateToggle({
    Name = "ESP",
    ParentTab = myTab4,
    Position = UDim2.new(0, 10, 0, 60),
    DefaultValue = false,
    Callback = function(isToggled)
        onESPToggleCallback(isToggled)
        print("Toggle ESP is now:", isToggled)
    end
})


while wait(1) do
    if isESPToggled then
        updateOutlines()
    end
end







