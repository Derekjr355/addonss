local spectating = {}

RegisterNetEvent("epyi_administration:spectate", function(target)
	local _source = source
	local type = "1"
	if spectating[_source] then
		type = "0"
	end
	local on = (type == "1")
	local tPed = GetPlayerPed(target)
	if DoesEntityExist(tPed) then
		if not on then
			TriggerClientEvent("epyi_administration:cancelSpectate", _source)
			spectating[_source] = false
			FreezeEntityPosition(GetPlayerPed(_source), false)
		elseif on then
			TriggerClientEvent("epyi_administration:requestSpectate", _source, NetworkGetNetworkIdFromEntity(tPed), target, GetPlayerName(target))
			spectating[_source] = true
		end
	end
end)

RegisterNetEvent("epyi_administration:spectate:teleport", function(target)
	local source = source
	local ped = GetPlayerPed(target)
	if DoesEntityExist(ped) then
		local targetCoords = GetEntityCoords(ped)
		SetEntityCoords(GetPlayerPed(source), targetCoords.x, targetCoords.y, targetCoords.z - 10)
		FreezeEntityPosition(GetPlayerPed(source), true)
	end
end)
