local MarketplaceService = game:GetService("MarketplaceService")
local productId = 1117512497 
local players = game:GetService("Players")

local Cash = {
	[1503801169]=500;
	[1503801171]=10000;
	[1503801174]=50000;
	[1503801176]=100000;
	[1503801177]=500000;
	[1503801178]=1000000;
	
}


local function  ProcessReceipt (receiptInfo)
	local player =players:GetPlayerByUserId(receiptInfo.PlayerId)
	if not player then
		warn(" Unsuccessful Buying Process")
		return Enum.ProductPurchaseDecision.NotProcessedYet
	 end

	 if player then
		warn(player.Name.." Successful Buying Process")
		local ProductId = receiptInfo.ProductId
		--
		if Cash[ProductId] then
			player.DataStore.leaderstats.Money.Yens.Value+=Cash[ProductId]
		end
		--

			end
			
	return Enum.ProductPurchaseDecision.PurchaseGranted
end

MarketplaceService.PromptGamePassPurchaseFinished:Connect(function(player,id,vlr)
	if vlr == true then
	--
	local Mdl = require(script.Parent.LoadData.Functions.LoadFunctions)
	--
	Mdl.Passes(player)
		--
		end
end)

MarketplaceService.ProcessReceipt = ProcessReceipt