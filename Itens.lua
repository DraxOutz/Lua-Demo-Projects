local module = {}
--
local MainGui = game.Players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("UI")
--
local Plr = game.Players.LocalPlayer
local IconsModule = require(script.Parent.Icons)
local ClickDelay = 0
local UIS = game:GetService("UserInputService")
--
local I=0
--
local function EQ(D)
	if tick() >= ClickDelay and MainGui.Meio.Frame.Bag.Visible == true then 
		--
		ClickDelay = tick()+0.5
		--
		game.ReplicatedStorage.Events.ItemEvent:FireServer(D)
		--
	end
end
--
Plr.Backpack.ChildAdded:Connect(function(D)
	if not MainGui.Meio.Frame.Bag:FindFirstChild(D.Name) and not D:FindFirstChild("NoList") then
		--
		local X = game.ReplicatedStorage.Hud.ItemLayout:Clone()
		X.Parent = MainGui.Meio.Frame.Bag
		X.TextLabel.Text = I+1
		X.Name = D.Name
		X.Icon.Image = IconsModule.Icon(D.Name)
		--
		
		--
		UIS.InputBegan:Connect(function(key,chat)
			if chat then return end
		if X and X:FindFirstChild("TextLabel") and X.TextLabel and key.KeyCode.Value == 48+tonumber(X.TextLabel.Text) then
			EQ(D.Name)
		elseif X == nil or not X:FindFirstChild("TextLabel") then
			X = nil
		end
		end)
		--
		X.TextButton.MouseButton1Click:Connect(function()
			EQ(D.Name)
		end)
		--
		X.CloseButton.MouseButton1Click:Connect(function()
			--
			game.ReplicatedStorage.Events.ItemEvent:FireServer(D.Name,"Deletar")
			--
		end)
		--
		I+=1
		--
	elseif MainGui.Meio.Frame.Bag:FindFirstChild(D.Name) then
		--
		MainGui.Meio.Frame.Bag:FindFirstChild(D.Name):TweenSize(UDim2.new(0.9,0,0.9,0),Enum.EasingDirection.In,Enum.EasingStyle.Linear,0.1)
		MainGui.Meio.Frame.Bag:FindFirstChild(D.Name).CloseButton.Visible = false
		--
	end
end)
--
Plr.Backpack.ChildRemoved:Connect(function(D)
	if not Plr.Character:FindFirstChild(D.Name) then
	--
	local Vlr = 999
	--
	if  MainGui.Meio.Frame.Bag:FindFirstChild(D.Name) then
--	
			Vlr =  tonumber(MainGui.Meio.Frame.Bag:FindFirstChild(D.Name).TextLabel.Text)
			--
	MainGui.Meio.Frame.Bag:FindFirstChild(D.Name):Destroy()
			--
	end
	--
	for i,v in pairs(MainGui.Meio.Frame.Bag:GetChildren()) do
		--
			if v:IsA("Frame") and  tonumber(v.TextLabel.Text) >= Vlr  then
				--
				v.TextLabel.Text = tonumber(v.TextLabel.Text-1)
				--
			end
	end
	--
	I-=1
	--
	end
end)
--
function module.GetItens()
	--
	local function Item(It)
	--
	local TileFrame = game.ReplicatedStorage.Hud.CarTileFrame:Clone()
	TileFrame.Parent = MainGui.Uis.Mochila.Frame.ResponsiveGrid
		TileFrame.Name = It.Name
		TileFrame.Title.Text = It.Name
		TileFrame.ItemButton.Image = IconsModule.Icon(It.Name)
	--
	if game.ReplicatedStorage.Itens:FindFirstChild(It.Name) then
			game.ReplicatedStorage.Itens:FindFirstChild(It.Name).TextureId = IconsModule.Icon(It.Name)
	end
	--
		TileFrame.LayoutOrder = 2
	TileFrame.Star.ImageColor3 = Color3.fromRGB(0,0,0)
	--
	TileFrame.Star.MouseButton1Click:Connect(function()
			if tick() >= ClickDelay then 
				--
				ClickDelay = tick()+1
				--
		--
		game.ReplicatedStorage.Events.FavoriteItens:FireServer(It.Name)
		--
			if TileFrame.Star.ImageColor3 == Color3.fromRGB(0,0,0) then
				TileFrame.Star.ImageColor3 = Color3.fromRGB(255, 255, 255)
			else
				TileFrame.Star.ImageColor3 = Color3.fromRGB(0,0,0)
			end
		--
		end
	end)
	--
		if  It:FindFirstChild("Pass") then
			--
			TileFrame.Pass.Visible = true
			TileFrame.LayoutOrder = 15
			--
			TileFrame.Pass.Image = IconsModule.Icon(It.Pass.Value)
			--
		end
		--
		if string.find(Plr.Status.FavoriteItens.Value, It.Name) then
			TileFrame.LayoutOrder = 1
			TileFrame.Star.ImageColor3 = Color3.fromRGB(255, 255, 255)
		end
		--
		TileFrame.ItemButton.MouseButton1Click:Connect(function()
			if tick() >= ClickDelay and #MainGui.Meio.Frame.Bag:GetChildren() < 4 and  MainGui.Meio.Frame.Bag.Visible == true then 
			--
			ClickDelay = tick()+0.5
			--
			game.ReplicatedStorage.Events.ItemEvent:FireServer(It.Name)
			--
			elseif  #MainGui.Meio.Frame.Bag:GetChildren() >= 4 then
				--
				local Mdl = require(script.Parent)
				Mdl.Aviso('Não é possível equipar outro item com o inventário cheio. Tente desequipar alguns itens.')
				--
			end
		end)
	--
	end
	--
	for i,It in pairs(game.ReplicatedStorage.Itens:GetChildren()) do
		if not It:FindFirstChild("NoList") then
		--
		Item(It)
		--
		end
	end
	--
	local Tipo = "Todos"
	local SearchBox = MainGui.Uis.Mochila.Frame.TopBar.SearchFrame
	--
	MainGui.Uis.Mochila.Frame.TopBar.Menu.MouseButton1Click:Connect(function()
		--
		if MainGui.Uis.Mochila.Frame.TopBar.Menu.DropdownFrame.Visible == false then
			--
			MainGui.Uis.Mochila.Frame.TopBar.Menu.DropdownFrame.Visible = true
			--
		else
			--
			MainGui.Uis.Mochila.Frame.TopBar.Menu.DropdownFrame.Visible = false
			--
		end
		--
	end)
	--
	local function TextGet(Text)
		
		for i,v in pairs( MainGui.Uis.Mochila.Frame.ResponsiveGrid:GetChildren()) do
			--
			if v:IsA("Frame") then
				--
				if Text == "" and Text == "Todos" then
					--
					v.Visible = true
					--
				else
					--
					if Text then
					Text=Text:lower()
					end
					--
					v.Visible = false
					--
					local Can = true
					--
					if Tipo ~= "Todos" then
						--
						Can = false
						--
						if game.ReplicatedStorage.Itens:FindFirstChild(v.Name) and  game.ReplicatedStorage.Itens:FindFirstChild(v.Name):GetAttribute("TipoDeTec") == Tipo then
							--
							Can = true
							--
						end
						--
					end
					--
					if  (Text and (string.match(v.Name:lower(), "^" .. Text) or string.match(v.Title.Text:lower(), "^" .. Text)) and Can == true) or (Text == nil and Can == true) then 
						--
						v.Visible = true
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
		for i,v in pairs(MainGui.Uis.Mochila.Frame.TopBar.Menu.DropdownFrame:GetChildren()) do
		if v:IsA("Frame") then
			---
			v.TextButton.MouseButton1Click:Connect(function()
				--
				MainGui.Uis.Mochila.Frame.TopBar.Menu.DropdownFrame.Visible = false
				--
				Tipo = v.Name
				--
				TextGet()
				--
			end)
			---
		end
	end
	--
	SearchBox.SearchBox.Changed:Connect(function()
		--
		local Text = 	SearchBox.SearchBox.Text
		--
		TextGet(Text)
		--
	end)
	--
	MainGui.Uis.Mochila.Frame.TopBar.CloseButton.MouseButton1Click:Connect(function()
		--
		MainGui.Direita.Visible = true
		local m = require(script.Parent.Parent.UIS)
		m.OpenUi("Mochila")
		--
		--
	end)
	--
end
--
return module
