local players = game:GetService("Players")
local chatService = require(game.ServerScriptService:WaitForChild("ChatServiceRunner"):WaitForChild("ChatService"))

local tags = {
	[254] = {TagText = "DEV", TagColor = Color3.fromRGB(255, 0, 0)},
	[55] = {TagText = "DEV", TagColor = Color3.fromRGB(255, 0, 0)},
	[2] = {TagText = "TESTER", TagColor = Color3.fromRGB(255, 85, 0)},
	[4] = {TagText = "STAFF", TagColor = Color3.fromRGB(255, 0, 0)},
	[3] = {TagText = "YOUTUBER", TagColor = Color3.fromRGB(255, 0, 0)},
	[999] = {TagText = "VIP", TagColor = Color3.fromRGB(255, 170, 0)},
}

chatService.SpeakerAdded:Connect(function(playerName)
	local speaker = chatService:GetSpeaker(playerName)
	local player = game.Players[playerName]

	if tags[player:GetRankInGroup(8023198)] then
		--
		player:WaitForChild("DataStore"):WaitForChild("Admin")
		--
		if player:GetRankInGroup(8023198) == 3 then
			--
			if player.DataStore.Admin.Youtuber.Value == false then
				player.DataStore.leaderstats.Money.Value+=50000
			end
			--
			player.DataStore.Admin.Youtuber.Value = true
			--
		end
		--
		if player:GetRankInGroup(8023198) >=4 then
			player.DataStore.Admin.Admin.Value = true
		else
			player.DataStore.Admin.Admin.Value = false
		end
		--
		speaker:SetExtraData("Tags",{tags[player:GetRankInGroup(8023198)]})
	end
	
end)
