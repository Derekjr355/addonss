_datastore = _datastore or {}

---getBans
---@return table
---@private
local function getBans()
	local bans = {}
	for _, content in pairs(_datastore) do
		if content.type == "BAN" or content.type == "D_BAN" then
			bans[content.id] = content
		end
	end
	return bans
end

---updateBans
---@return void
---@private
local function updateBans()
	local bans = getBans()
	local xPlayers = ESX.GetExtendedPlayers()
	for _, xTarget in pairs(xPlayers) do
		local xTargetSource = xTarget.source
		if Config.Groups[xTarget.getGroup()] and Config.Groups[xTarget.getGroup()].Access["submenu_server_bans"] and Player(xTargetSource).state["epyi_administration:onDuty"] then
			TriggerClientEvent("epyi_administration:updateBans", xTargetSource, bans or {})
		end
	end
end

ESX.RegisterServerCallback("epyi_administration:getBans", function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	if not Config.Groups[xPlayer.getGroup()] or not Config.Groups[xPlayer.getGroup()].Access["submenu_server_bans"] then
		xPlayer.kick(_U("insuficient_permissions"))
		cb({})
		return
	end
	cb(getBans() or {})
end)

AddEventHandler("playerConnecting", function(name, setCallback, deferrals)
	local license = GetPlayerIdentifierByType(source, "license")
	local identifier = string.gsub(license, "license:", "")
	deferrals.defer()

	local deffer_str = _U("deffer_ban_checker")

	Wait(50)
	deferrals.update(deffer_str)
	Wait(1000)

	for id, content in pairs(_datastore) do
		if content.type == "BAN" then
			if string.find(content.owner, identifier) then
				local time = os.time()
				local _data = json.decode(content.data)
				local expiration = _data.expiration
				if tonumber(expiration) <= tonumber(time) then
					TriggerEvent("epyi_administration:deleteData", id)
					deferrals.done()
					log("Player with identifier " .. identifier .. " is currently logging in for the first time since his last ban.")
				else
					local reason = _U("notif_ban_target", _data.reason, _data.duration, timeFormat(_U("date_format_long"), os.date("*t", expiration)))
					deferrals.done(reason)
					log("Player with identifier " .. identifier .. " tried to connect but he is banned")
				end
			end
		end
	end
	deferrals.done()
end)

RegisterNetEvent("epyi_administration:banPlayer", function(target, reason, duration)
	local xPlayer = ESX.GetPlayerFromId(source)
	if not Config.Groups[xPlayer.getGroup()] or not Config.Groups[xPlayer.getGroup()].Access["submenu_players_interact_ban"] then
		xPlayer.kick(_U("insuficient_permissions"))
		return
	end
	local xTarget = ESX.GetPlayerFromId(target)
	if not xTarget or not reason or not duration then
		xPlayer.showNotification(_U("notif_error"))
		return
	end
	local unixDuration = timeExpression(duration)
	print(duration)
	if not unixDuration then
		xPlayer.showNotification(_U("textentry_timestamp_invalid"))
		return
	end
	unixDuration = tonumber(unixDuration)
	local expiration = os.time() + unixDuration
	TriggerEvent("epyi_administration:saveData", "BAN", {
		unixDuration = unixDuration,
		duration = duration,
		expiration = expiration,
		expirationDetails = {
			day = os.date("%d", expiration),
			month = os.date("%m", expiration),
			year = os.date("%Y", expiration),
			hour = os.date("%H", expiration),
			minute = os.date("%M", expiration),
		},
		writeDetails = {
			day = os.date("%d"),
			month = os.date("%m"),
			year = os.date("%Y"),
			hour = os.date("%H"),
			minute = os.date("%M"),
		},
		reason = reason,
		target = xTarget.identifier,
		staff = xPlayer.identifier,
		targetName = xTarget.getName(),
		staffName = xPlayer.getName(),
	}, xTarget.identifier)
	xPlayer.showNotification(_U("notif_ban_success", xTarget.getName()))
	log("Player " .. xPlayer.getName() .. " (Identifier: " .. xPlayer.identifier .. ") has banned " .. xTarget.getName() .. " (Identifier: " .. xTarget.identifier .. ") for the reason '" .. reason .. "' with duration '" .. duration .. "'")
	local formatExpiration = timeFormat(_U("date_format_long"), os.date("*t", expiration))
	xTarget.kick(_U("notif_ban_target", reason, duration, formatExpiration))
	updateBans()
end)

RegisterNetEvent("epyi_administration:editBan", function(id, action, data)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	if not Config.Groups[xPlayer.getGroup()] or not Config.Groups[xPlayer.getGroup()].Access["submenu_server_bans_edit"] then
		xPlayer.kick(_U("insuficient_permissions"))
		return
	end
	if not id or not action or not data or type(id) ~= "number" or type(action) ~= "string" or type(data) ~= "table" then
		return
	end
	if action == "editReason" then
		local newReason = data.reason
		local _datas = json.decode(_datastore[id].data)
		_datas.reason = newReason
		TriggerEvent("epyi_administration:editData", id, _datastore[id].type, _datastore[id].date_unix, json.encode(_datas), _datastore[id].owner)
	elseif action == "revoke" then
		TriggerEvent("epyi_administration:deleteData", id)
	end
	updateBans()
end)
