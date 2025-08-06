local module = {}

local SFX = game.SoundService:WaitForChild("SFX")
local Animations = game.ReplicatedStorage:WaitForChild("Animations")
local Plr = game.Players.LocalPlayer

local SlashDelay = 0

local Vigor = script.Parent.Parent:WaitForChild("Configuration"):WaitForChild("Vigor")

local WalkAnimation 
local RunningAnimation
local FallAnim
local OldChar
local IdleAnimationWeapon 
local IdleAnimation
local OldTool

local Speed = 0
local OldThrotlle = 0

function module.Drive(dt,v)
	--
	local Seat =  v.Seat
	local Root = v.HumanoidRootPart
	--
	local s = (Seat.TurnSpeed*dt)*5
	local LookVector = Plr.Character.HumanoidRootPart.CFrame.LookVector
	--
	if Speed <1 then
		OldThrotlle =  Seat.Throttle
	end
	--
	if Seat.Throttle == OldThrotlle and Seat.Throttle ~= 0 then
	--
	if Speed < Seat.MaxSpeed then
	Speed+=s
	end
	--
	elseif Speed >0 then
		--
		Speed-=(s)*2
		--
	else
		--
		Speed = 0
	--	
	end
	--
	local S = (v.PrimaryPart.AssemblyLinearVelocity.Magnitude/5)
	--
	if S>=2 then
		S=2
	end
	--
	local Y = (-Seat.Steer)*S
	--
	Root.BodyAngularVelocity.AngularVelocity = Vector3.new(0,Y,0)
	Root.BodyVelocity.Velocity = (LookVector*Speed)*OldThrotlle
	--
end

function module.Montarias(dt)
	--
	for i,v in pairs(game.Workspace.Montarias:GetChildren()) do
		if v.PrimaryPart and (v.PrimaryPart.Position-Plr.Character.HumanoidRootPart.Position).Magnitude <= 750 then
			--
			if v.Name == Plr.Name and v.Seat.Occupant then
				--
				module.Drive(dt,v)
				--
			elseif v.Name == Plr.Name then
				--
				Speed = 0
				--
				if v.Configuration.Montaria.Value then
					v.Configuration.Montaria.Value:Stop()
				end
				--
			end
			--
if v.Configuration:FindFirstChild("Idle") then
	--
				if v.Configuration:FindFirstChild("Idle").Value == nil then
					--
					local HorseIdle = v.Humanoid:LoadAnimation(v.Configuration.Idle.Animation)
					HorseIdle:Play()
					v.Configuration.Idle.Value = HorseIdle
					--
					if v.Configuration.Ride.Value == nil then
					--
					local HorseAnim = v.Humanoid:LoadAnimation(v.Configuration.Ride.Animation)
					HorseAnim:Play()
					v.Configuration.Ride.Value = HorseAnim
					--
					end
					--
					if v.Configuration.Montaria.Value == nil then
						--
						local HorseAnim = Plr.Character.Humanoid:LoadAnimation(v.Configuration.Montaria.Animation)
						HorseAnim:Play()
						HorseAnim.Priority = Enum.AnimationPriority.Action4
						v.Configuration.Montaria.Value = HorseAnim
						--
					end
					--
				else
					--
					if Speed >= v.PrimaryPart.AssemblyLinearVelocity.Magnitude+15 then
						Speed = 0
					end
					--
					if v.Seat.Throttle == 0 and v.PrimaryPart.AssemblyLinearVelocity.Magnitude <= 3 then
						--
						if v.Configuration.Ride.Value then
						v.Configuration.Ride.Value:Stop()	
						end
						--
						if v.Configuration.Idle.Value.IsPlaying == false then
							v.Configuration.Idle.Value:Play()
						end
						--
						if v.HumanoidRootPart:FindFirstChild("Running") then
						v.HumanoidRootPart:FindFirstChild("Running"):Stop()
						end
						--
					else
						--
						v.Configuration.Idle.Value:Stop()
						--
						if v.HumanoidRootPart:FindFirstChild("Running") then 
							if v.HumanoidRootPart:FindFirstChild("Running") .IsPlaying == false then
								--
								v.HumanoidRootPart:FindFirstChild("Running"):Play()
								--
							end
						end
						--
						if v.Configuration.Ride.Value then
						if v.Configuration.Ride.Value.IsPlaying == false then
							--
							v.Configuration.Ride.Value:Play()
							--
						else
							--
							local Speed = v.PrimaryPart.AssemblyLinearVelocity.Magnitude/15
							--
							if Speed >= 2 then
								Speed = 2
							end
							--
							v.Configuration.Ride.Value:AdjustSpeed(Speed)
							--
						end
						end
						--
					end
					--
				end
	--
end
--
		end
	end
	--
end

function module.PlayerAnimation()
	if Plr.Character:FindFirstChild("HumanoidRootPart") then
	--
	local Speed = Plr.Character.HumanoidRootPart.AssemblyLinearVelocity.Magnitude
	--
	if OldChar ~= Plr.Character then
		OldChar = Plr.Character
		WalkAnimation = nil
		RunningAnimation = nil
	end
	--
	if WalkAnimation == nil then
		--
		WalkAnimation = Plr.Character.Humanoid:LoadAnimation(Animations.Running)
		WalkAnimation:Play()
		WalkAnimation.Priority = Enum.AnimationPriority.Action3
		--	
		RunningAnimation = Plr.Character.Humanoid:LoadAnimation(Animations.Running2)
		RunningAnimation:Play()
		RunningAnimation.Priority = Enum.AnimationPriority.Action3
			--	
			IdleAnimation = Plr.Character.Humanoid:LoadAnimation(Animations.Idle)
			IdleAnimation:Play()
			IdleAnimation.Priority = Enum.AnimationPriority.Action2
			--	
		FallAnim = Plr.Character.Humanoid:LoadAnimation(Animations.Fall)
		FallAnim:Play()
		FallAnim.Priority = Enum.AnimationPriority.Action3
		--	
	else
		--
		if Plr.Character.Humanoid:GetState() == Enum.HumanoidStateType.Freefall then
			if FallAnim.IsPlaying == false then
				FallAnim:Play()
				FallAnim.Priority = Enum.AnimationPriority.Action3
			end
		else
			FallAnim:Stop()
		end
		--
		if Speed >= 1 and Plr.Character.Humanoid:GetState() == Enum.HumanoidStateType.Running then
			--
				IdleAnimation:Stop()
			--
			if IdleAnimationWeapon then
				IdleAnimationWeapon:Stop()
				IdleAnimationWeapon = nil
			end
			--
		if Plr.Character.Humanoid.WalkSpeed <= 16 then
			--
			RunningAnimation:Stop()
			--
			if WalkAnimation.IsPlaying == false then
			WalkAnimation:Play()
			else
				WalkAnimation:AdjustSpeed(Speed/12)
			end
			--
		else
			--
			WalkAnimation:Stop()
			--
			if RunningAnimation.IsPlaying == false then
			RunningAnimation:Play()
			else
				RunningAnimation:AdjustSpeed(Speed/25)
			end
			--
		end
		else
			--
			if IdleAnimation.IsPlaying == false then
				IdleAnimation:Play()
			end
			--
			RunningAnimation:Stop()
			WalkAnimation:Stop()
			--
			if OldTool and  OldTool ~=Plr.Character:FindFirstChildOfClass("Tool") and IdleAnimationWeapon  then
				IdleAnimationWeapon:Stop()
				IdleAnimationWeapon = nil
			end
			--
			if Plr.Character:FindFirstChildOfClass("Tool") then
				if Plr.Character:FindFirstChildOfClass("Tool"):FindFirstChild("Idle") and IdleAnimationWeapon == nil then
					--
					OldTool = Plr.Character:FindFirstChildOfClass("Tool")
					--
					IdleAnimationWeapon = Plr.Character.Humanoid:LoadAnimation(Plr.Character:FindFirstChildOfClass("Tool"):FindFirstChild("Idle") )
					IdleAnimationWeapon:Play()
					IdleAnimationWeapon.Priority = Enum.AnimationPriority.Action3
					--
				end
			elseif IdleAnimationWeapon then
				IdleAnimationWeapon:Stop()
				IdleAnimationWeapon = nil
			end
			--
			if IdleAnimationWeapon and IdleAnimationWeapon.IsPlaying == false then
				IdleAnimationWeapon:Play()
			end
			--
		end
		--
	end
	--
	end
	end

function module.Slash(Combo)
	if (SFX.Slash.IsPlaying == false and tick() >= SlashDelay) or Combo then
		if  Plr.Stats.SkillLevel.Value >=1 then
	--
	SFX.Slash:Play()
		SlashDelay = tick()+0.6
	--
	if Plr.Stats.Tutorial.Value <=5 then
		game.ReplicatedStorage.Events.Others:FireServer("Dash")
	end
	--
		if Vigor.Value >= 20 and Combo == nil then
			Vigor.Value -= 20
		end
		--
	local Slash = Plr.Character.Humanoid:LoadAnimation(Animations.Slash)
	Slash:Play()
	Slash.Priority = Enum.AnimationPriority.Action4
	--
	local x = game.Workspace.CurrentCamera.CFrame:ToOrientation()
		local CF = game.Workspace.CurrentCamera.CFrame
	--
	if Plr.Character.Humanoid.FloorMaterial == Enum.Material.Air then
		x = 0
	end
	--
	Plr.Character.Humanoid.AutoRotate = false
	--
		local Cm = (CF*CFrame.Angles(-x,0,0))*CFrame.new(0,0,-50)
		Plr.Character.HumanoidRootPart.CFrame = CFrame.new(Plr.Character.HumanoidRootPart.Position,Cm.p)
	--
	local B = Instance.new("BodyVelocity",Plr.Character.HumanoidRootPart);B.Name = "Slash"
	B.MaxForce = Vector3.new("inf","inf","inf")
	B.Velocity = Plr.Character.HumanoidRootPart.CFrame.LookVector*100
	--
		if Plr.Character.Configuration.Enemy.Value and Combo == nil then
			task.spawn(function()
			task.wait(0.1)
			game.ReplicatedStorage.Events.AttackScript:FireServer("Slash")
			end)
		end
		--
	game.Debris:AddItem(B,0.6)
	--
	task.wait(0.6)
	--
		Plr.Character.Humanoid.AutoRotate = true
		--
	Slash:Stop()
	--
		end
		end
end

function module.Pisao()
	--
	local Jump = Plr.Character.Humanoid:LoadAnimation(Animations.Pisao)
	Jump:Play()
	--
end

function module.FrontFlip(Double)
	--
	local Jump = Plr.Character.Humanoid:LoadAnimation(Animations.DoubleJump)
	Jump:Play()
	Jump:AdjustSpeed(2)
	Jump.Priority = Enum.AnimationPriority.Action4
	--
	task.wait(0.15)
	--
	Jump:Stop()
	--
	if Vigor.Value >= 20 and Double then
	Vigor.Value -= 20
	end
	--
end

return module
