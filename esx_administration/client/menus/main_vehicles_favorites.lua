---main_vehicles_favorites_showContentThisFrame → Function to show the main/vehicles/favorites menu content
---@param playerGroup string
---@return void
function main_vehicles_favorites_showContentThisFrame(playerGroup)
	_var.client.playerData = ESX.GetPlayerData()

	RageUI.ButtonWithStyle(_U("main_vehicles_favorites_add"), _U("main_vehicles_favorites_add_desc"), { RightLabel = "→" }, not _var.menus.admin.cooldowns.items, function(_h, _a, Selected)
		if Selected and not _var.menus.admin.cooldowns.items then
			_var.menus.admin.cooldowns.items = true
			Citizen.CreateThread(function()
				local ped = PlayerPedId()
				local pedVehicle = GetVehiclePedIsIn(ped, false)
				local vehicleData = ESX.Game.GetVehicleProperties(pedVehicle)
				if not pedVehicle or GetPedInVehicleSeat(pedVehicle, -1) ~= ped then
					ESX.ShowNotification(_U("self_not_in_vehicle"))
					_var.menus.admin.cooldowns.items = false
					return
				end
				local vehicleName = textEntry(_U("textentry_add_to_favorites_name"), "", 30)
				if vehicleName == nil or vehicleName == "" then
					ESX.ShowNotification(_U("textentry_string_invalid"))
					_var.menus.admin.cooldowns.items = false
					return
				end
				vehicleData["vehicleName"] = vehicleName
				ESX.TriggerServerCallback("epyi_administration:saveFavoriteVehicle", function(vehicles)
					_var.menu.favoritesVehicles = vehicles
					_var.menus.admin.cooldowns.items = false
				end, vehicleData)
			end)
		end
	end)
	RageUI.Separator("↓ Your ~r~favorites vehicles~s~ ↓")
	local count = 0
	for __, content in pairs(_var.menu.favoritesVehicles) do
		count = count + 1
		local _datas = json.decode(content.data)
		RageUI.List(
			_datas.vehicleName .. " (" .. GetDisplayNameFromVehicleModel(_datas.model) .. ")",
			_var.menu.favritesActionsArray,
			_var.menu.favritesActionsArrayIndex,
			_U("main_vehicles_favorites_interact_desc", _datas.vehicleName),
			{},
			not _var.menus.admin.cooldowns.items,
			function(_h, _a, Selected, Index)
				_var.menu.favritesActionsArrayIndex = Index
				if Selected and not _var.menus.admin.cooldowns.items then
					_var.menus.admin.cooldowns.items = true
					Citizen.CreateThread(function()
						if _var.menu.favritesActionsArray[_var.menu.favritesActionsArrayIndex] == _("main_vehicles_favorites_interact_spawn") then
							local ped = PlayerPedId()
							local pedCoords = GetEntityCoords(ped)
							local pedHeading = GetEntityHeading(ped)
							local pedVehicle = GetVehiclePedIsIn(ped, false)
							if pedVehicle then
								ESX.Game.DeleteVehicle(pedVehicle)
							end
							ESX.Game.SpawnVehicle(_datas.model, pedCoords, pedHeading, function(callback_vehicle)
								ESX.Game.SetVehicleProperties(callback_vehicle, _datas)
								TaskWarpPedIntoVehicle(ped, callback_vehicle, -1)
								SetVehicleEngineOn(callback_vehicle, true, true, false)
							end)
							_var.menus.admin.cooldowns.items = false
						elseif _var.menu.favritesActionsArray[_var.menu.favritesActionsArrayIndex] == _("main_vehicles_favorites_interact_delete") then
							ESX.TriggerServerCallback("epyi_administration:deleteFavoriteVehicle", function(vehicles)
								_var.menu.favoritesVehicles = vehicles
								_var.menus.admin.cooldowns.items = false
							end, content.id)
						end
					end)
				end
			end
		)
	end
	if count == 0 then
		RageUI.Separator("")
		RageUI.Separator(_U("no_result"))
		RageUI.Separator("")
	end
end
