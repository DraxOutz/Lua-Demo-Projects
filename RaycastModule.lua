local module = {}

function module.new(startPosition, startDirection,Car)
	local maxDistance = startDirection.magnitude
	local direction = startDirection.unit
	local lastPosition = startPosition
	local distance = 0
	local ignore = {game.Workspace.Vehicles;
		game.Workspace.SpawnsCar;
		game.Workspace.Touchs;
		game.Workspace.SafeZones;
		game.Workspace.Tween;
		Car;
		game.Workspace.Radar;
	}
	
	local hit, position, normal, material
	
	repeat
		local ray = Ray.new(lastPosition, direction * (maxDistance - distance))
		--
		hit, position, normal ,material = game.Workspace:FindPartOnRayWithIgnoreList(ray, ignore, false, false)
		if hit then
			--
			if not Car:FindFirstChild("Boat")  then
					if material == Enum.Material.Water then
						Car:Destroy()
					end
			end
			--
			--
			if not hit.CanCollide then
				table.insert(ignore, hit)
			end
--
		end
		distance = (startPosition - position).magnitude
		lastPosition = position
	until distance >= maxDistance - 0.1 or (hit and hit.CanCollide)
	return hit, position, normal
end

return module
