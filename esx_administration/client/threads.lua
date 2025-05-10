-- Threads pre init
_threads = {
	godmode = {},
	invisibility = {},
	fastwalk = {},
	fastswim = {},
	superjump = {},
	stayinvehicle = {},
	seethrough = {},
	shownames = { showed = {} },
	vehicleboost = {},
	noclip = {},
}

-- Thread initialization
-- Thread → God mode
_threads.godmode.isActivated = false
_threads.godmode.enable = function()
	Citizen.CreateThread(function()
		if _threads.godmode.isActivated then
			return
		end
		_threads.godmode.isActivated = true
		while _threads.godmode.isActivated do
			SetEntityInvincible(PlayerPedId(), true)
			Citizen.Wait(1000)
		end
	end)
end
_threads.godmode.disable = function()
	_threads.godmode.isActivated = false
	SetEntityInvincible(PlayerPedId(), false)
end

-- Thread initialization
-- Thread → Invisibility
_threads.invisibility.isActivated = false
_threads.invisibility.enable = function()
	Citizen.CreateThread(function()
		if _threads.invisibility.isActivated then
			return
		end
		_threads.invisibility.isActivated = true
		while _threads.invisibility.isActivated do
			SetEntityVisible(PlayerPedId(), false, 0)
			Citizen.Wait(1)
		end
	end)
end
_threads.invisibility.disable = function()
	_threads.invisibility.isActivated = false
	SetEntityVisible(PlayerPedId(), true, 0)
end

-- Thread initialization
-- Thread → Fast walk
_threads.fastwalk.isActivated = false
_threads.fastwalk.enable = function()
	Citizen.CreateThread(function()
		if _threads.fastwalk.isActivated then
			return
		end
		_threads.fastwalk.isActivated = true
		while _threads.fastwalk.isActivated do
			SetPedMoveRateOverride(PlayerPedId(), 2.20)
			Citizen.Wait(1)
		end
	end)
end
_threads.fastwalk.disable = function()
	_threads.fastwalk.isActivated = false
	SetPedMoveRateOverride(PlayerPedId(), 0.0)
end

-- Thread initialization
-- Thread → Fast swim
_threads.fastswim.isActivated = false
_threads.fastswim.enable = function()
	Citizen.CreateThread(function()
		if _threads.fastswim.isActivated then
			return
		end
		_threads.fastswim.isActivated = true
		while _threads.fastswim.isActivated do
			SetSwimMultiplierForPlayer(PlayerId(), 1.49)
			Citizen.Wait(1000)
		end
	end)
end
_threads.fastswim.disable = function()
	_threads.fastswim.isActivated = false
	SetSwimMultiplierForPlayer(PlayerId(), 0.0)
end

-- Thread initialization
-- Thread → Super jump
_threads.superjump.isActivated = false
_threads.superjump.enable = function()
	Citizen.CreateThread(function()
		if _threads.superjump.isActivated then
			return
		end
		_threads.superjump.isActivated = true
		while _threads.superjump.isActivated do
			SetSuperJumpThisFrame(PlayerId())
			Citizen.Wait(1)
		end
	end)
end
_threads.superjump.disable = function()
	_threads.superjump.isActivated = false
end

-- Thread initialization
-- Thread → Stay in vehicle
_threads.stayinvehicle.isActivated = false
_threads.stayinvehicle.enable = function()
	Citizen.CreateThread(function()
		if _threads.stayinvehicle.isActivated then
			return
		end
		_threads.stayinvehicle.isActivated = true
		while _threads.stayinvehicle.isActivated do
			local player = PlayerPedId()
			SetPedCanRagdoll(player, false)
			SetPedCanRagdollFromPlayerImpact(player, false)
			SetPedCanBeKnockedOffVehicle(player, 1)
			SetPedRagdollOnCollision(player, false)
			SetPedCanBeDraggedOut(player, false)
			Citizen.Wait(1000)
		end
	end)
end
_threads.stayinvehicle.disable = function()
	_threads.stayinvehicle.isActivated = false
	local player = PlayerPedId()
	SetPedCanRagdoll(player, true)
	SetPedCanRagdollFromPlayerImpact(player, true)
	SetPedCanBeKnockedOffVehicle(player, 0)
	SetPedRagdollOnCollision(player, true)
	SetPedCanBeDraggedOut(player, true)
end

-- Thread initialization
-- Thread → See through
_threads.seethrough.isActivated = false
_threads.seethrough.enable = function()
	Citizen.CreateThread(function()
		if _threads.seethrough.isActivated then
			return
		end
		_threads.seethrough.isActivated = true
		while _threads.seethrough.isActivated do
			SetSeethrough(true)
			Citizen.Wait(1000)
		end
	end)
end
_threads.seethrough.disable = function()
	_threads.seethrough.isActivated = false
	SetSeethrough(false)
end

-- Thread initialization
-- Thread → Show names
_threads.shownames.isActivated = false
_threads.shownames.enable = function()
	Citizen.CreateThread(function()
		if _threads.shownames.isActivated then
			return
		end
		_threads.shownames.isActivated = true
		while _threads.shownames.isActivated do
			for k, v in pairs(ESX.Game.GetPlayers()) do
				local targetPed = GetPlayerPed(v)
				local selfPed = PlayerPedId()
				local targetPedCoords = GetEntityCoords(targetPed)
				local selfPedCoords = GetEntityCoords(selfPed)
				local dist = #(selfPedCoords - targetPedCoords)
				if dist < 400.0 then
					local targetState = Player(GetPlayerServerId(v)).state
					DrawText3Ds(targetPedCoords.x, targetPedCoords.y, targetPedCoords.z + 1.2, ("[ID: ~r~#%s~s~] \nHRP NAME: ~r~%s~s~\nRP NAME: ~r~%s"):format(GetPlayerServerId(v), string.upper(GetPlayerName(v)), targetState["name"]), 0.8)
				else
					RemoveMpGamerTag(_threads.shownames.showed[v])
					_threads.shownames.showed[v] = nil
				end
			end
			Citizen.Wait(1)
		end
	end)
end
_threads.shownames.disable = function()
	_threads.shownames.isActivated = false
	for _, v in pairs(_threads.shownames.showed) do
		RemoveMpGamerTag(v)
		_threads.shownames.showed = {}
	end
end

-- Thread initialization
-- Thread → Vehicle boost
_threads.vehicleboost.boostedVehicle = nil
_threads.vehicleboost.boostValue = nil
_threads.vehicleboost.isActivated = false
_threads.vehicleboost.enable = function(pedVehicle, value)
	Citizen.CreateThread(function()
		if pedVehicle ~= _threads.vehicleboost.boostedVehicle or value ~= _threads.vehicleboost.boostValue then
			_threads.vehicleboost.disable()
		end
		if _threads.vehicleboost.isActivated then
			return
		end
		if value == 1 then
			_threads.vehicleboost.disable()
			return
		end
		_threads.vehicleboost.boostedVehicle = pedVehicle
		_threads.vehicleboost.boostValue = value
		_threads.vehicleboost.isActivated = true
		while _threads.vehicleboost.isActivated do
			SetVehicleCheatPowerIncrease(pedVehicle, value / 1.5)
			Citizen.Wait(1)
		end
	end)
end
_threads.vehicleboost.disable = function()
	_threads.vehicleboost.isActivated = false
end

-- Thread initialization
-- Thread → Noclip
_threads.noclip.isActivated = false
_threads.noclip.enable = function()
	Citizen.CreateThread(function()
		if _threads.noclip.isActivated then
			return
		end
		_threads.noclip.isActivated = true
		local ped = PlayerPedId()
		if IsPedInAnyVehicle(ped, false) then
			_var.noclip.entity = GetVehiclePedIsIn(ped, false)
		else
			_var.noclip.entity = ped
		end
		SetEntityAlpha(_var.noclip.entity, 51, 0)
		if _var.noclip.entity ~= ped then
			SetEntityAlpha(ped, 51, 0)
			SetEntityVisible(_var.noclip.entity, false, 0)
		end
		SetEntityVisible(ped, false, 0)
		SetEntityCollision(_var.noclip.entity, false, false)
		FreezeEntityPosition(_var.noclip.entity, true)
		SetEntityInvincible(_var.noclip.entity, true)
		SetEntityVisible(_var.noclip.entity, false, true)
		SetEveryoneIgnorePlayer(ped, true)
		SetPoliceIgnorePlayer(ped, true)
		while _threads.noclip.isActivated do
			local yOffset = 0.0
			local zOffset = 0.0
			setInstructionnalButtons({
				{
					GetControlInstructionalButton(1, _var.keys[Config.Keys.NoClip.forward], 0),
					_U("noclip_go_forward"),
				},
				{
					GetControlInstructionalButton(1, _var.keys[Config.Keys.NoClip.backward], 0),
					_U("noclip_go_backward"),
				},
				{
					GetControlInstructionalButton(1, _var.keys[Config.Keys.NoClip.left], 0),
					_U("noclip_go_left"),
				},
				{
					GetControlInstructionalButton(1, _var.keys[Config.Keys.NoClip.right], 0),
					_U("noclip_go_right"),
				},
				{
					GetControlInstructionalButton(1, _var.keys[Config.Keys.NoClip.up], 0),
					_U("noclip_go_up"),
				},
				{
					GetControlInstructionalButton(1, _var.keys[Config.Keys.NoClip.down], 0),
					_U("noclip_go_down"),
				},
				{
					261,
					"Changer vitesse (Actuelle: x" .. round(_var.noclip.currentSpeed, 1) .. ")",
				},
			}, 0)
			drawInstructionnalButtons()
			DisableAllControlActions()
			EnableControlAction(0, 1, true)
			EnableControlAction(0, 2, true)
			EnableControlAction(0, 176, true)
			EnableControlAction(0, 69, true)
			EnableControlAction(0, 92, true)
			EnableControlAction(0, 106, true)
			EnableControlAction(0, 122, true)
			EnableControlAction(0, 135, true)
			EnableControlAction(0, 142, true)
			EnableControlAction(0, 144, true)
			EnableControlAction(0, 223, true)
			EnableControlAction(0, 229, true)
			EnableControlAction(0, 237, true)
			EnableControlAction(0, 257, true)
			EnableControlAction(0, 329, true)
			EnableControlAction(0, 346, true)
			EnableControlAction(0, 156, true)
			EnableControlAction(0, 191, true)
			EnableControlAction(0, 201, true)
			EnableControlAction(0, 215, true)
			EnableControlAction(0, 249, true) -- PUSH TO TALK
			EnableControlAction(0, 23, true)
			EnableControlAction(0, 200, true)
			if IsDisabledControlPressed(0, _var.keys[Config.Keys.NoClip.forward]) then
				yOffset = _var.noclip.offsets.y
			end
			if IsDisabledControlPressed(0, _var.keys[Config.Keys.NoClip.backward]) then
				yOffset = -_var.noclip.offsets.y
			end
			if IsDisabledControlPressed(0, _var.keys[Config.Keys.NoClip.left]) then
				SetEntityHeading(ped, GetEntityHeading(ped) + _var.noclip.offsets.h)
			end
			if IsDisabledControlPressed(0, _var.keys[Config.Keys.NoClip.right]) then
				SetEntityHeading(ped, GetEntityHeading(ped) - _var.noclip.offsets.h)
			end
			if IsDisabledControlPressed(0, _var.keys[Config.Keys.NoClip.up]) then
				zOffset = _var.noclip.offsets.z
			end
			if IsDisabledControlPressed(0, _var.keys[Config.Keys.NoClip.down]) then
				zOffset = -_var.noclip.offsets.z
			end
			if IsDisabledControlPressed(0, 261) then
				if _var.noclip.currentSpeed == 0 then
					_var.noclip.currentSpeed = 0.1
				end
				_var.noclip.currentSpeed = _var.noclip.currentSpeed * 1.2
			end
			if IsDisabledControlPressed(0, 262) then
				if _var.noclip.currentSpeed >= 0.1 then
					_var.noclip.currentSpeed = _var.noclip.currentSpeed / 1.2
				end
			end
			local newPos = GetOffsetFromEntityInWorldCoords(_var.noclip.entity, 0.0, yOffset * (_var.noclip.currentSpeed + 0.3), zOffset * (_var.noclip.currentSpeed + 0.3))
			SetEntityVelocity(_var.noclip.entity, 0.0, 0.0, 0.0)
			SetEntityRotation(_var.noclip.entity, 0.0, 0.0, 0.0, 0, false)
			SetEntityHeading(_var.noclip.entity, GetGameplayCamRelativeHeading())
			SetEntityCoordsNoOffset(_var.noclip.entity, newPos.x, newPos.y, newPos.z, true, true, true)
			SetEntityVisible(ped, false, 0)
			SetLocalPlayerVisibleLocally(true)
			Citizen.Wait(0)
		end
	end)
end
_threads.noclip.disable = function()
	local ped = PlayerPedId()
	ResetEntityAlpha(_var.noclip.entity)
	if _var.noclip.entity ~= ped then
		ResetEntityAlpha(ped)
		SetEntityVisible(_var.noclip.entity, true, 0)
	end
	SetEntityVisible(ped, true, 0)
	SetEntityCollision(_var.noclip.entity, true, true)
	FreezeEntityPosition(_var.noclip.entity, false)
	SetEntityInvincible(_var.noclip.entity, false)
	SetEntityVisible(_var.noclip.entity, true, false)
	SetEveryoneIgnorePlayer(ped, false)
	SetPoliceIgnorePlayer(ped, false)
	_threads.noclip.isActivated = false
end

function DrawText3Ds(x, y, z, text, size)
	local vector = vector3(x, y, z)
	local camCoords = GetFinalRenderedCamCoord()
	local distance = #(vector - camCoords)

	local scale = (size / distance) * 2
	local fov = (1 / GetGameplayCamFov()) * 100
	scale = scale * fov

	local onScreen, _x, _y = World3dToScreen2d(x, y, z)
	local px, py, pz = table.unpack(GetGameplayCamCoords())

	SetTextScale(0.0, 0.55 * scale)
	SetTextFont(0)
	SetTextProportional(1)
	SetTextColour(255, 255, 255, 255)
	BeginTextCommandDisplayText("STRING")
	SetTextCentre(true)
	AddTextComponentSubstringPlayerName(text)
	SetDrawOrigin(x, y, z, 0)
	SetTextDropshadow(0.15, 0, 0, 0, 0)
	EndTextCommandDisplayText(0.0, 0.0)
	ClearDrawOrigin()
	-- local factor = (string.len(text)) / 500
	-- DrawRect(_x,_y+0.048, 0.015+ factor, 0.1, 0, 0, 0, 80)
end

function round(num, numDecimalPlaces)
	local mult = 10 ^ (numDecimalPlaces or 0)
	return math.floor(num * mult + 0.5) / mult
end
