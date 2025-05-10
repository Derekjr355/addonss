---revivePed → Revive a ped
---@param ped ped
---@return void
function revivePed(ped)
	local _ped = ped
	local coords = GetEntityCoords(_ped)
	local heading = GetEntityHeading(_ped)
	TriggerServerEvent("epyi_administration:setDeathStatus", false)

	DoScreenFadeOut(800)

	while not IsScreenFadedOut() do
		Wait(50)
	end

	local formattedCoords = {
		x = ESX.Math.Round(coords.x, 1),
		y = ESX.Math.Round(coords.y, 1),
		z = ESX.Math.Round(coords.z, 1),
	}

	SetEntityCoordsNoOffset(_ped, formattedCoords.x, formattedCoords.y, formattedCoords.z, false, false, false)
	NetworkResurrectLocalPlayer(formattedCoords.x, formattedCoords.y, formattedCoords.z, heading, true, false)
	SetPlayerInvincible(_ped, false)
	ClearPedBloodDamage(_ped)
	TriggerEvent("esx_basicneeds:resetStatus")
	TriggerServerEvent("esx:onPlayerSpawn")
	TriggerEvent("esx:onPlayerSpawn")
	TriggerEvent("playerSpawned") -- compatibility with old scripts, will be removed soon
	ClearTimecycleModifier()
	SetPedMotionBlur(_ped, false)
	ClearExtraTimecycleModifier()
	DoScreenFadeIn(800)
end

---stopAllThreads → Set all threads to disable mode
---@return void
function stopAllThreads()
	for k, _ in pairs(_threads) do
		_threads[k].disable()
	end
end

---leaveAllReports → Leave all reports taken by client
---@return void
function leaveAllReports()
	ESX.TriggerServerCallback("epyi_administration:getReports", function(reports)
		_var.reports.list = reports
		for key, report in pairs(_var.reports.list) do
			if report.staff.takerIdentifier == ESX.GetPlayerData().identifier then
				report.staff.taken = false
				report.staff.takerIdentifier = nil
				report.staff.takerSource = nil
				report.staff.takerGroup = nil
				ESX.TriggerServerCallback("epyi_administration:setReport", function(result)
					if not result then
						ESX.ShowNotification(_U("notif_report_editing_error"))
					end
				end, key, _var.reports.list[key])
			end
		end
	end)
end

---timeFormat
---@param format string
---@param params table
---@return string
---@public
function timeFormat(format, params)
	local day = params.day or os.date("%d")
	local month = params.month or os.date("%m")
	local year = params.year or os.date("%Y")
	local hour = params.hour or os.date("%H")
	local minute = params.minute or os.date("%M")

	local formatted = format:gsub("_d", string.format("%02d", day))
	formatted = formatted:gsub("_m", string.format("%02d", month))
	formatted = formatted:gsub("_Y", year)
	formatted = formatted:gsub("_H", string.format("%02d", hour))
	formatted = formatted:gsub("_M", string.format("%02d", minute))

	return formatted
end

---textEntry → Open a popup to write some text
---@param textEntry string
---@param inputText string
---@param maxLength integer
---@return string
function textEntry(textEntry, inputText, maxLength)
	AddTextEntry("FMMC_KEY_TIP1", textEntry)
	DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", inputText, "", "", "", maxLength)
	while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
		Citizen.Wait(1.0)
	end
	if UpdateOnscreenKeyboard() ~= 2 then
		local result = GetOnscreenKeyboardResult()
		Citizen.Wait(500)
		return result
	else
		Citizen.Wait(500)
		return nil
	end
end

---syncWeather → Set weather (used by the server to sync weather)
---@param weather string
---@param blackout boolean
---@return void
RegisterNetEvent("epyi_administration:syncWeather")
AddEventHandler("epyi_administration:syncWeather", function(weather, blackout, time)
	_var.menu.blackoutCheckbox = blackout
	SetArtificialLightsState(blackout)
	SetArtificialLightsStateAffectsVehicles(false)
	for key, weather in pairs(_var.menu.weatherArray) do
		if _var.menu.weatherArray[_var.menu.weatherArrayIndex] == weather then
			_var.menu.weatherArrayIndex = key
		end
	end
	SetWeatherTypeOverTime(weather, 0.0)
	ClearOverrideWeather()
	ClearWeatherTypePersist()
	SetWeatherTypePersist(weather)
	SetWeatherTypeNow(weather)
	SetWeatherTypeNowPersist(weather)
	NetworkOverrideClockTime(time, 0, 0)
end)

local oldPos = nil
local spectateInfo = { toggled = false, target = 0, targetPed = 0 }

RegisterNetEvent("epyi_administration:requestSpectate", function(targetPed, target, name)
	oldPos = GetEntityCoords(PlayerPedId())
	spectateInfo = {
		toggled = true,
		target = target,
		targetPed = targetPed,
	}
end)

RegisterNetEvent("epyi_administration:cancelSpectate", function()
	if NetworkIsInSpectatorMode() then
		NetworkSetInSpectatorMode(false, spectateInfo["targetPed"])
	end
	if not Cloack and not yayeetActive then
		SetEntityVisible(PlayerPedId(), true, 0)
	end
	spectateInfo = { toggled = false, target = 0, targetPed = 0 }
	RequestCollisionAtCoord(oldPos)
	SetEntityCoords(PlayerPedId(), oldPos)
	oldPos = nil
end)

CreateThread(function()
	while true do
		Wait(0)
		if spectateInfo["toggled"] then
			local text = {}
			local targetPed = NetworkGetEntityFromNetworkId(spectateInfo.targetPed)
			if DoesEntityExist(targetPed) then
				SetEntityVisible(PlayerPedId(), false, 0)
				if not NetworkIsInSpectatorMode() then
					RequestCollisionAtCoord(GetEntityCoords(targetPed))
					NetworkSetInSpectatorMode(true, targetPed)
				end
			else
				TriggerServerEvent("epyi_administration:spectate:teleport", spectateInfo["target"])
				while not DoesEntityExist(NetworkGetEntityFromNetworkId(spectateInfo.targetPed)) do
					Wait(100)
				end
			end
		else
			Wait(500)
		end
	end
end)

RegisterNetEvent("epyi_administration:playerUpdated", function(playerId, player)
	_var.players.list[playerId] = player
end)

RegisterNetEvent("epyi_administration:reportUpdated", function(reportId, report)
	_var.reports.list[reportId] = report
end)

RegisterNetEvent("epyi_administration:updateBans", function(bans)
	_var.bans.list = bans
	if _var.bans.selectedBan and _var.bans.selectedBan.id then
		_var.bans.selectedBan = bans[_var.bans.selectedBan.id]
	end
end)
