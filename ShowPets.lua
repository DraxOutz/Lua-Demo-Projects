
local player = game:GetService("Players").LocalPlayer
local character = player.Character 
local Altura =  0
local Trava = false
game:GetService("RunService").RenderStepped:Connect(function()
	local sucess,erro = pcall(function()
	
	--
	if not Trava then
		Altura = Altura - 0.15
		if Altura <= -1 then
			Trava = true
		end
	else
		Altura = Altura + 0.15
		if Altura >= 1 then
			Trava = false
		end
	end
	--
	for i,v in pairs(game.Workspace.Pets:GetChildren()) do
		if game.Workspace:FindFirstChild(v.Name) then
			if game.Workspace:FindFirstChild(v.Name) :FindFirstChild("HumanoidRootPart") then
				
				local char = game.Workspace:FindFirstChild(v.Name) :FindFirstChild("HumanoidRootPart")
				--
					local Enemy = game.Workspace:FindFirstChild(v.Name).Animations.ShowPets.Enemy.Value
				--
				if Enemy ~= nil then
					char = Enemy.PrimaryPart
				end
				--
	local Positions = {
		[1]=char.CFrame  * CFrame.new(-8, 0,0 )  ,
					[2]=char.CFrame  * CFrame.new(8, 0,0),
					[3]=char.CFrame* CFrame.new(0,  0, -8)  ,
					[4]=char.CFrame * CFrame.new(0, 0,8),
					[5]=char.CFrame * CFrame.new(-8,  0, -8),
					[6]=char.CFrame * CFrame.new(8,  0, 8),
					[7]=char.CFrame * CFrame.new(-8,  0, 8),
					[8]=char.CFrame * CFrame.new(8,  0, -8),
					[9]=char.CFrame * CFrame.new(-10, 0, 8),
					[10]=char.CFrame * CFrame.new(10,  0, 8),
					[11]=char.CFrame * CFrame.new(10,  0, 0),
					[12]=char.CFrame * CFrame.new(10,  0, -8),
					[13]=char.CFrame * CFrame.new(0,  0, -9),
					[14]=char.CFrame * CFrame.new(-10, 0, -8),
					[15]=char.CFrame * CFrame.new(-10,  0, 0),
					[16]=char.CFrame * CFrame.new(0,  0, 9)		,
	}
	--
	local Positions2 = {
					[1]=char.CFrame  * CFrame.new(-8, Altura+1.5,0 )  ,
					[2]=char.CFrame  * CFrame.new(8, Altura+1.5,0),
					[3]=char.CFrame* CFrame.new(0,  Altura+1.5, -8)  ,
					[4]=char.CFrame * CFrame.new(0, Altura+1.5,8),
					[5]=char.CFrame * CFrame.new(-8,  Altura+1.5, -8),
					[6]=char.CFrame * CFrame.new(8,  Altura+1.5, 8),
					[7]=char.CFrame * CFrame.new(-8,  Altura+1.5, 8),
					[8]=char.CFrame * CFrame.new(8,  Altura+1.5, -8),
					[9]=char.CFrame * CFrame.new(-10,  Altura+1.5, 8),
					[10]=char.CFrame * CFrame.new(10,  Altura+1.5, 8),
					[11]=char.CFrame * CFrame.new(10,  Altura+1.5, 0),
					[12]=char.CFrame * CFrame.new(10,  Altura+1.5, -8),
					[13]=char.CFrame * CFrame.new(0,  Altura+1.5, -9),
					[14]=char.CFrame * CFrame.new(-10,  Altura+1.5, -8),
					[15]=char.CFrame * CFrame.new(-10,  Altura+1.5, 0),
					[16]=char.CFrame * CFrame.new(0,  Altura+1.5, 9)		,
	}
	
				for i,Pets in pairs(v:GetChildren()) do
					--
					local YY = 0
					local Died =  	Pets.Configuration.Died.Value 
					--
					if Pets:FindFirstChild('Animations') then
						if Pets:FindFirstChild('Animations').Anim.Value == nil then
							--
							local anim = Pets.Humanoid:LoadAnimation(Pets.Animations.IdleAnimation)
							anim:Play()
							--
							Pets:FindFirstChild('Animations').Anim.Value = anim
							Pets.Cloud.Transparency = 0
							--
						end
					end
					--
					if Died == true then
						YY = 5000
					end
					--
		if char.Velocity.Magnitude >9 then
			--
						Pets:SetPrimaryPartCFrame(Pets.PrimaryPart.CFrame:Lerp(Positions2[i]*CFrame.new(0,YY,0),0.28))
						--
					else
						--
local pos = 		CFrame.new(Vector3.new(Positions[i].X,Positions[i].Y+YY,Positions[i].Z),char.Position)
						Pets:SetPrimaryPartCFrame(Pets.PrimaryPart.CFrame:Lerp(pos,0.28))
						--
			end
			end
			end
			end
		end
	--
	end)
	if not sucess then
		
	end
	end)