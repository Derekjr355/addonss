local reportCooldowns = reportCooldowns or {}
local reports = {}

---reportUpdated
---@param reportId number
---@return void
---@private
local function reportUpdated(reportId)
	local xPlayers = ESX.GetExtendedPlayers()
	for _, xTarget in pairs(xPlayers) do
		local xTargetSource = xTarget.source
		if Config.Groups[xTarget.getGroup()] and Config.Groups[xTarget.getGroup()].Access["submenu_reports_access"] and Player(xTargetSource).state["epyi_administration:onDuty"] then
			TriggerClientEvent("epyi_administration:reportUpdated", xTargetSource, reportId, reports[reportId])
		end
	end
end

---addReport
---@param xPlayer player
---@param reason string
---@return void
---@private
local function addReport(xPlayer, reason)
	local _id = #reports + 1
	local report = {
		id = _id,
		user = {
			identifier = xPlayer.identifier,
			source = xPlayer.source,
			name = xPlayer.getName(),
			ooc_name = GetPlayerName(xPlayer.source),
			group = xPlayer.getGroup(),
			job = xPlayer.getJob(),
			accounts = xPlayer.getAccounts(),
			coords = xPlayer.getCoords(),
			inventory = xPlayer.getInventory(),
			reason = reason,
		},
		staff = {
			taken = false,
			takerIdentifier = nil,
			takerSource = nil,
			takerGroup = nil,
			takerName = nil,
		},
	}
	reports[_id] = report
	reportUpdated(_id)
end

ESX.RegisterServerCallback("epyi_administration:getReports", function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	if not Config.Groups[xPlayer.getGroup()] or not Config.Groups[xPlayer.getGroup()].Access["submenu_reports_access"] then
		cb({})
		xPlayer.kick(_U("insuficient_permissions"))
		return
	end
	cb(reports or {})
end)

ESX.RegisterServerCallback("epyi_administration:setReport", function(source, cb, key, data)
	local xPlayer = ESX.GetPlayerFromId(source)
	if not Config.Groups[xPlayer.getGroup()] or not Config.Groups[xPlayer.getGroup()].Access["submenu_reports_access"] then
		cb(false)
		xPlayer.kick(_U("insuficient_permissions"))
		return
	end
	if reports[key] == nil then
		cb(false)
		return
	end
	reports[key] = data
	reportUpdated(key)
	cb(true)
end)

ESX.RegisterCommand("report", "user", function(xPlayer, args, showError)
	if reportCooldowns[xPlayer.identifier] then
		xPlayer.showNotification(_U("notif_cannot_perform_cooldown"))
		return
	end
	local reason = ""
	for _, arg in pairs(args) do
		if reason == "" then
			reason = arg
		else
			reason = reason .. " " .. arg
		end
	end
	if reason == nil or reason == "" then
		reason = _U("command_report_no_reason")
	end
	addReport(xPlayer, reason)
	xPlayer.showNotification(_U("command_report_success", reason))
	local xPlayers = ESX.GetExtendedPlayers()
	for _, xStaff in pairs(xPlayers) do
		if Config.Groups[xStaff.getGroup()].Access["submenu_reports_access"] and Player(xStaff.source).state["epyi_administration:onDuty"] then
			xStaff.showNotification(_U("command_report_success_staff", xPlayer.getName(), xPlayer.source))
		end
	end
	reportCooldowns[xPlayer.identifier] = true
	Citizen.SetTimeout(5000, function()
		reportCooldowns[xPlayer.identifier] = false
	end)
end, false)

repeat
	for _, report in pairs(reports) do
		local xStaff = ESX.GetPlayerFromIdentifier(report.staff.takerIdentifier)
		if report.staff.taken and not xStaff then
			report.staff.taken = false
			report.staff.takerIdentifier = nil
			report.staff.takerSource = nil
			report.staff.takerGroup = nil
			report.staff.takerName = nil
			reportUpdated(report.id)
		end
	end
	Citizen.Wait(1000)
until false
