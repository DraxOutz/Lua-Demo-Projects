local module = {}

local ShotDelay = 0
local Can = false
local TomandoAnim 
local Plr = game.Players.LocalPlayer
local SoundFlareDelay = 0

local function AnimacaoDeAtirar(Arma,Arma2,Hit,Pos,Vec)
	local sc,er = pcall(function()
		--
		if Arma == nil and Arma2 and typeof(Arma2) ~= "Vector3" then
			Arma = Arma2
		end
		--
		warn(Arma.Name)
		--
		local Can = true
		--
		if Arma.Flare:FindFirstChild("Pump") and Arma.Flare:FindFirstChild("Pump").IsPlaying == true then
			Can = false
		end
		--
		if  Arma.Configuration.Pente.Value > 0 and Arma.Flare.reload.IsPlaying == false and Can == true then
			--]]
			Arma.Configuration.Pente.Value-=1
			--
			local Flare = Arma:FindFirstChild("Flare")
			--
			local mouse = game.Players.LocalPlayer:GetMouse().Hit
			---
			if  game.ReplicatedStorage:FindFirstChild("Mira") then
				mouse = game.ReplicatedStorage:FindFirstChild("Mira").CFrame
			end
			--
			if Flare then 
				--
				if game.Workspace:FindFirstChild("Arms") and Arma.Parent.Name == game.Players.LocalPlayer.Name then
					Flare = game.Workspace:FindFirstChild("Arms"):FindFirstChild(Arma.Name):FindFirstChild("Flare")
				end
				--
				local Shot = Flare.Shot:Clone()
				Shot.Parent = Flare
				game.Debris:AddItem(Shot,Shot.TimeLength)
				Shot:Play()
				Shot.Pitch = math.random(95, 105) / 100
				--
				local Light = Instance.new("PointLight",Flare)
				Light.Color = Color3.fromRGB(255, 255, 0)
				Light.Range = 5
				Light.Brightness = 2
				game.Debris:AddItem(Light,0.1)
				--
				task.spawn(function()
					if Arma.Parent.Name == game.Players.LocalPlayer.Name then
						--
						task.spawn(function()
							--
							if script.Parent.GamePad.Value == true then
								--
								task.spawn(function()
									--
									game:GetService("HapticService"):SetMotor(Enum.UserInputType.Gamepad1, Enum.VibrationMotor.Small, 1)
									--
									task.wait(0.4)
									--
									game:GetService("HapticService"):SetMotor(Enum.UserInputType.Gamepad1, Enum.VibrationMotor.Small, 0)
									--
								end)
								--
							end
						end)
						--
						local F = 1
						--
						if Arma.Configuration:FindFirstChild("Shotgun") then
							F = 2
						end
						--
					end	
				end)
				--
				task.spawn(function()
					if Arma.Parent.Name == game.Players.LocalPlayer.Name then
					local sc,er = pcall(function()
						--
						for i=1,4 do
						script.Y.Value -= 0.1
							game:GetService("RunService").RenderStepped:Wait()
						end
						--
						for i=1,4 do

							script.Y.Value += 0.1
							game:GetService("RunService").RenderStepped:Wait()
						end
						--
					end)
					end
				end)
				--
				if Arma:FindFirstChild("Meshes/Corpo3")  then
					if Arma.Parent.Name == game.Players.LocalPlayer.Name then
					--
					task.spawn(function()
						for i=1,4 do
							game:GetService("RunService").RenderStepped:Wait()
							Arma:FindFirstChild("Meshes/Corpo3").Weld.C0*=CFrame.new(0,0,0.1)
						end
						for i=1,4 do
							game:GetService("RunService").RenderStepped:Wait()
							Arma:FindFirstChild("Meshes/Corpo3").Weld.C0*=CFrame.new(0,0,-0.1)
						end
					end)
					--
					end
				end
				--
				local X = 1
				--
				if Arma.Configuration:FindFirstChild("Shotgun") then
					if Arma.Parent.Name == game.Players.LocalPlayer.Name then
						--
						X = 9
						--
					end
				end
				--
				for i=1,X do
					--
					mouse = game.Players.LocalPlayer:GetMouse().Hit
					---
					if  game.ReplicatedStorage:FindFirstChild("Mira") then
						mouse = game.ReplicatedStorage:FindFirstChild("Mira").CFrame
					end
					--
					local hit, position, vector
					--
					if not game.ReplicatedStorage:FindFirstChild("Mira") then
						local obj = Instance.new("Part",game.ReplicatedStorage)  
						obj.Anchored = true 
						obj.CanCollide = false
						obj.Name = "Mira"
						obj.Transparency = 1
						obj.Size = Vector3.new(0.01,0.01,0.01) 
					end
					--
					local Lista = {
						game.Players.LocalPlayer.Character;
						game.Workspace.Efeitos;
						game.ReplicatedStorage.Mira;
					}
					--
					if game.Workspace:FindFirstChild("Arms") then
						table.insert(Lista,game.Workspace.Arms)
					end
					--
					if Plr.Character.Humanoid.SeatPart then
						table.insert(Lista,Plr.Character.Humanoid.SeatPart.Parent.Parent)
					end
					--
					if Arma2 == nil then
						--
						local D = (mouse.p-Flare.CFrame.p).Magnitude/15
						--
						if D <0.15 then
							D = 0.15
						elseif D > 10 then
							D = 10
						end
						--
						if not Arma.Configuration:FindFirstChild("Shotgun") then
							D/=2
						end
						--
						local Espalhados = {
							[1]=CFrame.new(0,0,0);
							[2]=CFrame.new(0,1*D,0);
							[3]=CFrame.new(0,-1*D,0);
							[4]=CFrame.new(1*D,0,0);
							[5]=CFrame.new(-1*D,0,0);
							--
							[6]=CFrame.new(1*D,1*D,0);
							[7]=CFrame.new(-1*D,-1*D,0);
							[8]=CFrame.new(-1*D,1*D,0);
							[9]=CFrame.new(1*D,-1*D,0);
						}
						--
						if Arma.Configuration:FindFirstChild("Shotgun") then
							--
							mouse*=Espalhados[i]
							--
							task.spawn(function()
								task.wait(0.3)
								--
								if game.Workspace:FindFirstChild("Arms") then
									game.Workspace:FindFirstChild("Arms") .Humanoid:LoadAnimation(Arma.Configuration.Pump):Play()
								end
								--
								Plr.Character.Humanoid:LoadAnimation(Arma.Configuration.Pump):Play()
								--
								Flare.Pump:Play()
								--
							end)
							--
						elseif math.random(1,3) == 1 then
							--
							local i = math.random(1,9)
							--
							mouse*=Espalhados[i]
							--
						end
						--
						local ray = Ray.new(Flare.CFrame.p, (mouse.p -Flare.CFrame.p).unit*(500))
						hit, position,vector = game.Workspace:FindPartOnRayWithIgnoreList(ray, Lista)
						--
						if script.Parent.PhantasyAntiCheat.AimBot.Value == true then
							if hit.Name == "Head" or hit.Name == "Handle" then
								--
								if hit.Name == "Head" then
									hit = hit.Parent.Torso
								else
									hit = hit.Parent.Parent.Torso
								end
								--
							end
						end
						--
						task.spawn(function()
						--
						local X = game.ReplicatedStorage.Events.ItensEvents:InvokeServer("CuspidoraDeFogo",Arma,hit,position,vector,script.Parent.AntiCheat.AimBot.Value)
						--
						if X then
							if X == "Abatido" then
								--
								game.Players.LocalPlayer.PlayerGui.MainGui.Meio.Mirar.ImageColor3 = Color3.fromRGB(255, 0, 0)
								--
								for i=1,5 do
									game.Lighting.ColorCorrection.Brightness+=0.04
									game:GetService("RunService").RenderStepped:Wait()
								end
								--
								game.Players.LocalPlayer.PlayerGui.MainGui.Meio.Mirar.ImageColor3 = Color3.fromRGB(255, 255, 255)
								--
								for i=1,5 do
									game.Lighting.ColorCorrection.Brightness-=0.04
									game:GetService("RunService").RenderStepped:Wait()
								end
								--
							elseif X == "Dano" then
								--
								game.Players.LocalPlayer.PlayerGui.MainGui.Meio.Mirar.ImageColor3 = Color3.fromRGB(255, 0, 0)
								--
								task.wait(0.05)
								--
								--
								game.Players.LocalPlayer.PlayerGui.MainGui.Meio.Mirar.ImageColor3 = Color3.fromRGB(255, 255, 255)
								--
							end
						end
						--
						end)
						--
					else
						--
						hit = Hit
						position = Pos
						vector = Vec
						--
					end
					--
					if Plr.Name == "DraxOutz" then
						warn("Arma Pedido")
					end
					--
					local function Flares()
						--
						if Plr.Name == "DraxOutz" then
							warn("Efeito Pedido")
						end
						--
						local function Bullets()
							--
							local bullet = game.ReplicatedStorage.BulletE:Clone()
							bullet.Parent = game.Workspace.Efeitos
							bullet.Anchored = true
							bullet.CanCollide = false
							bullet.CFrame = Flare.CFrame
							bullet.CFrame = CFrame.new(Flare.Position,position)
							--
							bullet.Beam0.Enabled = false
							bullet.Beam1.Enabled = false
							--
							bullet.Attachment0.TrailParticles.Enabled = true
							--
							task.spawn(function()
								task.wait(0.1)
								bullet.Beam0.Enabled = true
								bullet.Beam1.Enabled = true
							end)
							--
							task.spawn(function()
								--
								local TweenService = game:GetService("TweenService")

								local part = bullet

								local timer = (bullet.Position-position).Magnitude/50*0.1

								local Info = TweenInfo.new(

									timer, 

									Enum.EasingStyle.Linear, 

									Enum.EasingDirection.In, 

									0,

									false, 
									0 

								)



								local Goals =

									{

										Position = position

									}

								--
								task.spawn(function()
									--
									task.wait(timer)
									--
									bullet.Beam0.Enabled = false
									bullet.Beam1.Enabled = false
									bullet.Attachment0:Destroy()
									bullet.Attachment1:Destroy()
									--	
								end)
								--
								if tick() >= SoundFlareDelay then
									if (position-Plr.Character.HumanoidRootPart.Position).Magnitude <= 10 then
										local Sounds = game.SoundService.Bullet:GetChildren()
										Sounds[math.random(1,#Sounds)]:Play()
										SoundFlareDelay = tick()+0.2
									end
								end
								--
								game.Debris:AddItem(bullet,timer+3)
								local tween = TweenService:Create(bullet,Info,Goals)
								tween:Play()
								--
								game.Debris:AddItem(tween,timer)
								--
							end)
							--
						end
						--
						Bullets()
						--
						if Arma.Parent.Name == game.Players.LocalPlayer.Name or (Flare.Position-Plr.Character.Torso.Position).Magnitude <= 50 then
							--
							local TT = Flare["FlashFX3[Front]"]:Clone()
							TT.Enabled = true
							TT.Parent = Flare
							game.Debris:AddItem(TT,2)
							--
							local TT2 = Flare["FlashFX3[Burst]"]:Clone()
							TT2.Enabled = true
							TT2.Parent = Flare
							game.Debris:AddItem(TT2,2)
							--
							local TT3 = Flare["FlashFX[Flash]"]:Clone()
							TT3.Enabled = true
							TT3.Parent = Flare
							game.Debris:AddItem(TT3,2)
							--

							local TT4 = script["FlashFX[Flash]"]:Clone()
							TT4.Enabled = true
							TT4.Parent = Flare
							game.Debris:AddItem(TT4,0.2)
							--
							task.spawn(function()
								task.wait(0.1)
								TT.Enabled = false
								TT2.Enabled = false
								TT3.Enabled = false
							end)
							--
						end
						--
						local imgs = {192664810,872910628,156580465}
						--
						local Cframes = {
							[1]=CFrame.new(1.90734863e-06, 0.549622297, 9.53674316e-07, -2.04606386e-06, -2.98027231e-07, 1, 1.25820543e-06, -1, -2.98024645e-07, 1, 1.25820486e-06, 2.04606431e-06) ;
							[2]=CFrame.new(9.53674316e-07, -2.38418579e-07, 0.549623489, -4.19043573e-07, 1.8690555e-06, 1, -1, -1.25820532e-06, -4.19041214e-07, 1.25820452e-06, -1, 1.86905606e-06 );
							[3]=CFrame.new(9.53674316e-07, -0.388642192, 0.388643265, 8.76301442e-07, 1.5899343e-06, 1, -0.707107544, 0.707105994, -5.04612728e-07, -0.707105994, -0.707107544, 1.74389243e-06)
						}
						--
						local Cframes2 = {
							[1]=CFrame.new(1.90734863e-06, -0.54962194, 9.53674316e-07, 9.97052254e-08, -2.98023224e-07, 1, 7.81368783e-07, -1, -2.98023309e-07, 1, 7.81368897e-07, -9.97049909e-08 ) ;
							[2]=CFrame.new(3.81469727e-06, -4.76837158e-07, -0.549621582, 1.72672844e-06, 1.86905891e-06, 1, -1, -7.8137009e-07, 1.72672992e-06, 7.8137333e-07, -1, 1.86905754e-06);
							[3]=CFrame.new(3.81469727e-06, 0.388640881, -0.388641357, 3.02207445e-06, 1.58993635e-06, 1, -0.707107246, 0.707106352, 1.01267642e-06, -0.707106411, -0.707107186, 3.26118356e-06);
						}
						--
						local r =math.random(1,#Cframes)
						--
						Flare.MuzzleFlash0.CFrame =  Cframes[r]
						Flare.MuzzleFlash1.CFrame = Cframes2[r]
						--
						local Flash = Flare.MuzzleFlash:Clone()
						Flash.Parent = Flare
						Flash.Enabled = true
						Flash.Texture = "rbxassetid://"..imgs[math.random(1,#imgs)]
						game.Debris:AddItem(Flash,0.1)
						--
						local function Hole()
							--
							local Tiro = game.ReplicatedStorage.Tiro:Clone()
							Tiro.Position = position
							Tiro.CFrame = CFrame.new(Tiro.Position,Tiro.Position+vector)
							game.Debris:AddItem(Tiro,15)
							--
							Tiro.BulletHit:Play()
							--

							--
							local Impact = Tiro.ImpactBillboard:Clone()
							Impact.Parent = Tiro
							Impact.Enabled = true
							game.Debris:AddItem(Impact,0.05)
							--
							for i,v in pairs(Tiro.Attachment:GetChildren()) do
								task.spawn(function()
									--
									local X = v:Clone()
									X.Parent = Tiro.Attachment
									X.Enabled = true
									--
									game.Debris:AddItem(X,1)
									--
									task.wait(0.2)
									--
									X.Enabled = false
									--
								end)
							end


							--
							if hit then
								if hit.Anchored == true and hit.CanCollide == true then
									Tiro.Parent = game.Workspace.Efeitos
								end
							end
							--
						end
						--
						task.spawn(function()
							if Arma.Parent.Name == game.Players.LocalPlayer.Name then
								Hole()
							end
						end)
						---
					end
					--
					if UserSettings().GameSettings.SavedQualityLevel.Value >= 5 or UserSettings().GameSettings.SavedQualityLevel.Value  == 0 or Arma.Parent.Name == game.Players.LocalPlayer.Name then
						if Plr.Stats.Config.Value:split(";")[2] == "Sim" then
						Flares() 
						end
					end
					--
					if Arma.Parent.Name == game.Players.LocalPlayer.Name then
					local c = require(script.Parent.Camera)
					c.ShotRange()
					end
					--
				end
				--
			end
		else
			--
			module.Reload(Arma)
			--
		end
		--
	end)
	if not sc then
		warn(er)
	end
end

game.ReplicatedStorage.Events.ItensEvents.OnClientInvoke =function(Arma,Hit,Position,Vector)
	--
		AnimacaoDeAtirar(nil,Arma,Hit,Position,Vector)
	
	--
end

function module.ItemRemovido()
	if TomandoAnim then
		TomandoAnim:Stop()
		TomandoAnim = nil
	end
end

function module.Reload(Arma)
	if Arma then
	else
		Arma = Plr.Character:FindFirstChildOfClass("Tool")
	end
	--
	if Arma and (Arma.Parent.Name == Plr.Name) and Plr.Inventario:FindFirstChild("Munição de "..Arma.Tipo.Value).Value>0 and Arma.Configuration.Pente.Value ~= Arma.Configuration.Cut.Value and Arma.Flare.reload.IsPlaying == false then
		--
		local X = 1
		--
		local OldX = Arma.Configuration.Pente.Value
		--
		Arma.Configuration.Pente.Value += game.ReplicatedStorage.Events.Reload:InvokeServer(Arma,Arma.Configuration.Pente.Value)
		--
		if Arma.Configuration:FindFirstChild("Shotgun") then
			X = Arma.Configuration.Pente.Value-OldX
		end
		--
		for i=1,X do
			--
			Arma.Flare.reload:Play()
			local Anim = Plr.Character.Humanoid:LoadAnimation(Arma.Configuration.Reload)
			Anim:Play()
			Anim.Priority = Enum.AnimationPriority.Action4
			--
			if game.Workspace:FindFirstChild("Arms") then
				game.Workspace:FindFirstChild("Arms") .Humanoid:LoadAnimation(Arma.Configuration.Reload):Play()
			end
			--
			task.wait(Arma.Flare.reload.TimeLength+0.2)
			--
		end
		--
		if Arma.Configuration:FindFirstChild("Shotgun") then
			--
			task.wait(0.3)
			--
			Plr.Character.Humanoid:LoadAnimation(Arma.Configuration.Pump):Play()
			--
			if game.Workspace:FindFirstChild("Arms") then
				game.Workspace:FindFirstChild("Arms") .Humanoid:LoadAnimation(Arma.Configuration.Pump):Play()
			end
			--
			Arma.Flare.Pump:Play()
			--
		end
		--
	end
end

function module.Atirar(OldTool)
if tick() >= ShotDelay and TomandoAnim == nil then
	--
	local Can = true
	--
	if OldTool.Name == "Galão" then
			if Plr.PersonalCar.Value and (Plr.PersonalCar.Value.PrimaryPart.Position-Plr.Character.Torso.Position).Magnitude <= 20 then
		else
			Can = false
		end
	end
	--]
	if OldTool:FindFirstChild("Tomando")  then
		--
		ShotDelay = tick()+1.5
		--
			TomandoAnim = Plr.Character.Humanoid:LoadAnimation(OldTool:FindFirstChild("Tomando"))
		TomandoAnim:Play()
		TomandoAnim.Priority = Enum.AnimationPriority.Action4
		--
		game.ReplicatedStorage.Events.SocarEsfaquear:FireServer("Faca",OldTool)
		--
		task.spawn(function()
			task.wait(1.4)
			TomandoAnim:Stop()
			TomandoAnim = nil
		end)
		--
	end
	--
	if OldTool.Configuration:FindFirstChild("Tomando") and Can == true then
		--
		ShotDelay = tick()+2
		--
		if OldTool.Name == "Energético" or OldTool.Name == "Verdonha" or OldTool.Name == "Cocada" then
				script.Parent.Vigor.Value += 40
		end
		--
			TomandoAnim = Plr.Character.Humanoid:LoadAnimation(OldTool.Configuration:FindFirstChild("Tomando"))
		TomandoAnim:Play()
		TomandoAnim.Priority = Enum.AnimationPriority.Action4
		--
		game.ReplicatedStorage.Events.ItensEvents:InvokeServer("Consumivel",OldTool)
		--
	end
	--
	if Plr.Character.Configuration.SafeZone.Value == false then
		if OldTool:FindFirstChild("Flare") then
			--
			ShotDelay = tick()+OldTool.Configuration.Configuration.Delay.Value
			--
			AnimacaoDeAtirar(OldTool)
			--
		end
	end
	--
end
end

return module
