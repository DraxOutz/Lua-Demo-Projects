local module = {}

local Effects = game.ReplicatedStorage.Effects
local Events = game.ReplicatedStorage:WaitForChild("Events")
local Tween = game:GetService("TweenService")
function module.Combos(Plr,vlr,Server)
	if Plr.Character.Humanoid.FloorMaterial ~= Enum.Material.Air  then
	--
	local AnimationsScript = require(Plr.PlayerScripts.MainScript.Animations)
	local CameraScript = require(Plr.PlayerScripts.MainScript.CameraScript)
	--
	local Efeito = game.ReplicatedStorage.Effects:FindFirstChild(script.Parent.Combos:FindFirstChild(vlr).Nm.Value):Clone()
	local Anim = script.Parent.Combos:FindFirstChild(vlr).AnimationPlay
	--
	Efeito:SetPrimaryPartCFrame(Plr.Character.HumanoidRootPart.CFrame)
	Efeito.Parent = game.Workspace.Effects
	Efeito.Name = "EfeitoDeAtaque"
	Efeito.PrimaryPart.Anchored = true
	--
	if vlr == "One" then
		--
			local SD = 0
			local DamageTime = 0
			local Can = false
			--
			local function Sword()
				if tick() >= SD and Server == nil and Can == true then
					--
					local Sword = game.SoundService.SFX.Sword:GetChildren()
					local SFX = Sword[math.random(1,#Sword)]:Clone()
					SFX.Parent = game.SoundService.SFX
					SFX:Play()
					game.Debris:AddItem(SFX,1)
					SD = tick()+0.05
					--
					if DamageTime <= 30 then
						Events.AttackScript:FireServer(Plr.Character:FindFirstChildOfClass("Tool"),"Combo",vlr)
						DamageTime+=1
					end
					--
				end
			end
			--
		if Server == nil then
			--
			Events.ComboEvent:FireServer(Plr,vlr)
			--
			Plr.Character.HumanoidRootPart.Anchored = true
			--
		end
		--
		local Ani=	Plr.Character.Humanoid:LoadAnimation(Anim)
		Ani:Play()
		Ani.Priority = Enum.AnimationPriority.Action4
		--
		local Ani=	Efeito.Humanoid:LoadAnimation(Anim)
		Ani:Play()
		Ani.Priority = Enum.AnimationPriority.Action4
		--
			Can = true
		--
			Ani:GetMarkerReachedSignal("SlashExplosion"):Connect(function()
				--
				for i,v in pairs( Efeito.Effect["A - Cuts [C]"] :GetChildren()) do
					v.Enabled = true
				end
				--
				local Shok = Effects.Shock:Clone()
				Shok.Parent = game.Workspace.Effects
				Shok.CFrame = Efeito.HumanoidRootPart.CFrame
				--
				task.spawn(function()
					--
					local OldSize = Shok.Size
					Shok.Size = Vector3.zero
					--
					local changes = {
						Size = OldSize;
						Transparency = 1;
					}
					--
					local tweenInfo = TweenInfo.new(
						1,									
						Enum.EasingStyle.Linear,			
						Enum.EasingDirection.In,			
						0,									
						false,								
						0									
					)
					--
					local tween = Tween:Create(Shok, tweenInfo, changes)
					--
					tween:Play()
					--
				end)
				--
				if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position-Plr.Character.Torso.Position).Magnitude <= 150 then
					--
					local SOund = game.SoundService.SFX.MuscleAugmentUltLanding:Clone()
					SOund:Play()
					SOund.Name = "Debris"
					SOund.Parent = game.SoundService
					game.Debris:AddItem(SOund,SOund.TimeLength)
					--
				end
				--
				if Server == nil then
					Events.AttackScript:FireServer(Plr.Character:FindFirstChildOfClass("Tool"),"Combo",vlr)
					CameraScript.CameraShake("Medio")
				end
				--
				
			end)
		--
		repeat game:GetService("RunService").RenderStepped:Wait() Sword() until Ani.IsPlaying == false 
		--
		Can = false
		Plr.Character.HumanoidRootPart.Anchored = false
		--
		local Efeit = Efeito.Effect["A - Cuts [C]"] 
			Efeit.Parent = game.Workspace.Effects
		game.Debris:AddItem(Efeit,2)
		Efeit.Anchored = true
		--
			for i,v in pairs(Efeit:GetChildren()) do
				v.Enabled = false
			end
		--
		Efeito:Destroy()
		--
	end
	--
	end
	end

return module
