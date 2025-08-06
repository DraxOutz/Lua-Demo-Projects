local module = {}

function module.Run(amount)
if tonumber(amount) then
	amount = math.floor(amount)
	
	while true do
		amount, k = string.gsub(amount, "^(-?%d+)(%d%d%d)", '%1,%2')
		if (k == 0) then
			break
		end
	end
	
	return amount
	else
		return "NIL"
	end
	end

return module