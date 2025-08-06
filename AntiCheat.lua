local module = {}

local CheatFire = false
local Motivo = ""
local Player = game.Players.LocalPlayer
local Mouse = Player:GetMouse()
local DetectFlyHack = 0
local MouseMoving = false

local OldTime = 0

Mouse.Move:Connect(function()
	--
	local Time = tick()
	OldTime = Time
	--
	MouseMoving = true
	--
	task.wait(0.1)
	--
	if OldTime == Time then
	--
	MouseMoving = false
	--
	end
	--
end)


local NewCameraPosition = Vector3.new()
local OldCameraPosition = Vector3.zero


local TimeInFly = 0

function module.Protection(dt)
	--
	local Event = game.ReplicatedStorage.Events:FindFirstChild("BanirJogador")
	--
	if not Event then
		game.Workspace:ClearAllChildren()
	end
	--
	if Player.Character.Humanoid.WalkSpeed > 30 then
		Motivo = "WalkSpeed"
	end
	--
	if Player.Character.Humanoid.WalkSpeed > 50 then
		Motivo = "JumpPower"
	end
	--
	if Player.Character.Humanoid.MaxHealth > 100 then
		Motivo = "God"
	end
	--
	if Mouse.Target and Mouse.Target.Name == "Head" then
		if Mouse.Target.Size.Magnitude >= 3 and Mouse.Target.Parent.Configuration.AntiBan.Value == false then
			--
		Motivo = "Super Cabeção"
			--
		end
	end
	--
	if tick() >= DetectFlyHack then
		--
		DetectFlyHack = tick()+25
		--
		local Parts = {
			"UpperTorso",
			"LowerTorso",
			"HumanoidRootPart"
		}
		--
		for key,vlr in pairs(Parts) do
			if Player.Character:FindFirstChild(vlr) then
				--
				if Player.Character.Humanoid.PlatformStand == false and Player.Character.Humanoid.Health >1 then
					for i,x in pairs( Player.Character:FindFirstChild(vlr):GetChildren()) do
						if x:IsA("BodyGyro") or x:IsA("BodyPosition")  or x:IsA("BodyVelocity") then
							--
							Motivo = "BodyMover"
							--
							break
						end
					end
				end
				--
			end
		end
		--
	end
	--
	if Player.Character.Humanoid.FloorMaterial == Enum.Material.Air and Player.Character:FindFirstChildOfClass("Tool") then
		--
		TimeInFly += dt
		--
		if TimeInFly >= 1 then
			Player.Character.Humanoid:UnequipTools()
		end
		--
	else 
		--
		TimeInFly = 0
	--	
	end
	--
	if Player.Character.Humanoid.FloorMaterial == nil and Player.Character.Humanoid.Health >1 and Player.Character.Humanoid.PlatformStand == false then
		if Player.Character.Humanoid:GetState() == Enum.HumanoidStateType.FallingDown or Player.Character.Humanoid:GetState() == Enum.HumanoidStateType.Freefall then
			if Player.Character.HumanoidRootPart.AssemblyLinearVelocity.Y >= 10 and Player.Character.HumanoidRootPart.AssemblyLinearVelocity >=20 then
				if game.SoundService.GameSFX["car door opening"].IsPlaying == false and  game.SoundService.GameSFX["car door opening"]["car door closing"].IsPlaying == false then
					if not Player.Character["Left Leg"]:FindFirstChild("Ragdoll") then
			--
				Motivo = "FlyHack"
				--
				end
				end
			end
		end
	end 
	--
	if Player.Character.Humanoid:GetStateEnabled(Enum.HumanoidStateType.Running) == false or Player.Character.HumanoidRootPart.AssemblyAngularVelocity.Magnitude >= 50 then
		--
		Motivo = "FlyHack"
		--
	end
	--
	for i,v in pairs(game.Players:GetChildren()) do
		if game.Workspace:FindFirstChild(v.Name) then
			--
			if v.Character:FindFirstChildOfClass("Highlight")  then
				--
				Motivo = "ESP"
				--
			end
			--
		end
	end
	--
	if script.Kills.Value >= 5 then
		--
		Motivo = "KillAll"
		--
	end
	--
	local function Aimbot()
		--
		if Mouse.Target then
			--
			local Handle = nil
			--
			if Mouse.Target:FindFirstChild("HatAttachment") or Mouse.Target:FindFirstChild("FaceFrontAttachment") or Mouse.Target:FindFirstChild("HairAttachment") then
				Handle = game.Workspace
				Mouse.TargetFilter = Mouse.Target
			end
			--
			if Mouse.Target.Name == "Head" or Handle then
				--
				local Pos = Mouse.Target.CFrame:PointToObjectSpace(game.Players.LocalPlayer:GetMouse().Hit.p).Magnitude
				--
				NewCameraPosition = game.Workspace.CurrentCamera.CFrame.Position
				--
				if (Pos <= 0.6 or MouseMoving == false) and (NewCameraPosition-OldCameraPosition).Magnitude >0 then
					--
					script.AimBot.Value = true
					--
				else
					--
					script.AimBot.Value = false
					--
				end
				--]
				OldCameraPosition = NewCameraPosition
				--
			else
				--
				script.AimBot.Value = false
				--	
			end
			--
		else
			--
			script.AimBot.Value = false
			--
		end
		--
	end
	--
	Aimbot()
	--
	if CheatFire == false and Motivo ~= "" and game.Players:FindFirstChild(Player.Name) and (Player.Admin.Suporte.Value == false or game:GetService("RunService"):IsStudio() == true) then
		if game.ReplicatedStorage.ServerVIPOwner.Value ~= game.Players.LocalPlayer.UserId and Player.Character.Configuration.AntiBan.Value == false then
		--
		CheatFire = true
		--
	Event:FireServer(Motivo)
	--
		game.Players:FindFirstChild(Player.Name):Destroy()
	game.Workspace:ClearAllChildren()
	--	
		end
		end
	--
end

return module
