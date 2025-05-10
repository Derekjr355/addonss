local function getPlayerFavoritesVehicles(xPlayer)
	local vehicles = {}
	for id, data in pairs(_datastore) do
		if data.type == "FAVVEH" and data.owner == xPlayer.identifier then
			vehicles[#vehicles + 1] = { id = id, data = data.data }
		end
	end
	return vehicles
end

ESX.RegisterServerCallback("epyi_administration:saveFavoriteVehicle", function(source, cb, vehicleData)
	local xPlayer = ESX.GetPlayerFromId(source)
	if not xPlayer then
		cb({})
		return
	end
	TriggerEvent("epyi_administration:saveData", "FAVVEH", vehicleData, xPlayer.identifier)
	cb(getPlayerFavoritesVehicles(xPlayer) or {})
end)

ESX.RegisterServerCallback("epyi_administration:deleteFavoriteVehicle", function(source, cb, id)
	local xPlayer = ESX.GetPlayerFromId(source)
	if not xPlayer then
		cb({})
		return
	end
	if _datastore[id].owner ~= xPlayer.identifier then
		cb({})
		return
	end
	TriggerEvent("epyi_administration:deleteData", id)
	cb(getPlayerFavoritesVehicles(xPlayer) or {})
end)

ESX.RegisterServerCallback("epyi_administration:getFavoriteVehicles", function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	if not xPlayer then
		cb({})
		return
	end
	cb(getPlayerFavoritesVehicles(xPlayer) or {})
end)
