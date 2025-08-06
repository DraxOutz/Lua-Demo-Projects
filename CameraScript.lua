local module = {}

local Cmr = game.Workspace.CurrentCamera
local Plr = game.Players.LocalPlayer
local Zoom = 10
local Mouse = Plr:GetMouse()
local Tween = game:GetService("TweenService")

local UserInputService = game:GetService("UserInputService")
local X , Y = 0,0
local Shake = 0
local ShakeDelay = 0

local ArtificialCamera = Instance.new("Part",game.ReplicatedStorage)
ArtificialCamera.CanCollide = false
ArtificialCamera.Anchored = true

local Lock = false


local Stooped = 0
local Moving = false

local CX,CY = 0,0

UserInputService.InputChanged:Connect(function(inputObject,Chat)
	if Chat then return end
	--
	if inputObject.KeyCode == Enum.KeyCode.Thumbstick2 then
		--
			CX =inputObject.Position.X*2
		CY =inputObject.Position.Y*2
		--
	end
	--
end)

UserInputService.InputBegan:Connect(function(inputObject,Chat)
	if Chat then return end
	--
	if inputObject.UserInputType == Enum.UserInputType.MouseButton2 then
		Lock = true
	end
	--
end)

UserInputService.InputEnded:Connect(function(inputObject,Chat)
	if Chat then return end
	--
	if inputObject.UserInputType == Enum.UserInputType.MouseButton2 then
		Lock = false
	end
	--
end)

local CutsCenePlaying = false

function module.Cutscene(Tipo)
	task.spawn(function()
	--
	if CutsCenePlaying == false then
	--
	local Camera = game.Workspace.CurrentCamera
	local Local = game.Workspace.Cutscene:FindFirstChild(Tipo)
	--
	if Local then
		--
				CutsCenePlaying = true
		--
		script.Parent.Parent.Configuration.Cutscene.Value = true
				Plr.PlayerGui.MainGui.Midlle.AnimeFrame.Visible = false
		--
		Local:WaitForChild("C1")
		--
		Camera.CFrame = Local.C1.CFrame
		--
			task.wait(Local.C1.Time.Value)
		--
		local Cutscene = Local:GetChildren()
		--
		local X=1
		--
		for i=1,#Cutscene-1 do
			--
			X+=1
			--
				local Part = Local:FindFirstChild("C"..X)
			--
			if  Part:FindFirstChild("Transition") then
				--
				local Timer = Part.Transition.Value
				--
					local changes = {
						CFrame =  Part.CFrame
					}
					--
					local tweenInfo = TweenInfo.new(
						Timer,									
						Enum.EasingStyle.Linear,			
						Enum.EasingDirection.In,			
						0,									
						false,								
						0									
					)
					--
					local tween = Tween:Create(Camera, tweenInfo, changes)
					--
					tween:Play()
				--
				task.wait(Timer)
				--
			end
			--
			Camera.CFrame = Part.CFrame
			--
			task.wait(Part.Time.Value)
			--
					script.Parent.Parent.Configuration.Cutscene.Value = true
			--
			if Part:FindFirstChild("ModuleScript") then
				task.spawn(function()
				--
				local X = require(Part.ModuleScript)
				X.Start()
				--
				end)
			end
			--
		end
		--
			require(script.Parent.Gui).Teleport("None")
			--
				CutsCenePlaying = false
			--
			script.Parent.Parent.Configuration.Cutscene.Value = false
			--
	end
	--
	end
	--
	end)
end

function module.Camera()
	--
	local Delta = UserInputService:GetMouseDelta()
	local Sensi = UserSettings():GetService("UserGameSettings").MouseSensitivity
	--
	if Lock == true then
	UserInputService.MouseBehavior = Enum.MouseBehavior.LockCurrentPosition
	else
		UserInputService.MouseBehavior = Enum.MouseBehavior.Default
	end
	--
	local PH = true
	--
	if UserInputService.TouchEnabled == true then
		--
		if Mouse.X <=  Plr.PlayerGui.MainGui.AbsoluteSize.X/3 then
			PH = false
		end
		--
	end
	--
	if PH == true then
	--
	X+=(Delta.X+CX)*Sensi
	Y+=	(Delta.Y+CY)*Sensi
	--
	end
	--
	local function ArtiCmr()
		--
		if Y <= -90 then
			Y = -90
		elseif Y >= 90 then
			Y = 90
		end
		--
		local Vec = Plr.Character.Torso.Position.Y-Plr.Character.HumanoidRootPart.Position.Y
		--
		local RootPart = Plr.Character.HumanoidRootPart
		ArtificialCamera.Orientation = Vector3.new(Y,X,Shake)
		ArtificialCamera.Position =  RootPart.Position+Vector3.new(0,Vec,0)
		--
	end
	--
	local function GetPerfectZoomCollision(Zoom)
		--
		local raycastParams = RaycastParams.new()
		local rayOrigin = Plr.Character.Head.Position
		local rayDirection =  (ArtificialCamera.CFrame*CFrame.new(0,1.5,Zoom+1)).p-rayOrigin
		--
		raycastParams.FilterDescendantsInstances = {Plr.Character;game.Workspace.Effects;game.Workspace.Enemys}
		raycastParams.FilterType = Enum.RaycastFilterType.Exclude
		raycastParams.IgnoreWater = true

		--
		local raycastResult = workspace:Raycast(rayOrigin, rayDirection, raycastParams)
		--
		if raycastResult then
			if raycastResult.Instance.CanCollide == true then
			--
			Zoom = raycastResult.Distance-1
			--
			end
			end
		--
		return Zoom
		--
	end
	--
	ArtiCmr()
	--
	Cmr.FieldOfView = 70+(Plr.Character.Torso.AssemblyLinearVelocity.Magnitude/10)
	Cmr.CameraType = Enum.CameraType.Scriptable
	--
	local	ZoomNew = GetPerfectZoomCollision(Zoom)
	--
	if script.Parent.Parent.Configuration.Cutscene.Value == false and Plr.PlayerGui.MainGui.Teleport.Value.Value == false then
	Cmr.CFrame = ArtificialCamera.CFrame*CFrame.new(0,1.5,ZoomNew)
	end
	--
end

function module.CameraShake(Tipo)
	if tick() >= ShakeDelay then
	--
	ShakeDelay = tick()+0.2
	--
	local K = 1
	--
	if Tipo then
		--
		if Tipo == "Leve" then
			K=0.4
		end
		--
			if Tipo == "Medio" then
				K=0.8
			end
			--
	end
	--
	for i=1, 5 do
		Shake+= 2*K
		game.Lighting.Blur.Size += 1*K
			game:GetService("RunService").RenderStepped:Wait()
	end
	--
	for i=1, 10 do
		Shake-= 2*K
			game:GetService("RunService").RenderStepped:Wait()
	end
	--
	for i=1, 5 do
		Shake+= 2*K
		game.Lighting.Blur.Size -= 1*K
		game:GetService("RunService").RenderStepped:Wait()
	end
	--
	end
	--
end

return module
