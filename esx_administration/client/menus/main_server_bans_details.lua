---main_server_bans_details_showContentThisFrame → Function to show the main/server/bans/details menu content
---@param playerGroup string
---@return void
function main_server_bans_details_showContentThisFrame(playerGroup)
	local datas = json.decode(_var.bans.selectedBan.data)
	RageUI.Separator(_U("main_server_bans_details_target", datas.targetName))
	RageUI.Separator(_U("main_server_bans_details_author", datas.staffName))
	RageUI.Separator(_U("main_server_bans_details_validity", _var.bans.selectedBan.type == "BAN" and _U("main_server_bans_unit_valid") or _U("main_server_bans_unit_finished")))
	RageUI.Separator(_U("main_server_bans_details_id", _var.bans.selectedBan.id))
	RageUI.Separator(_U("main_server_bans_details_date", timeFormat(_U("date_format_long"), datas.writeDetails)))
	RageUI.Separator(_U("main_server_bans_details_time", datas.duration))
	RageUI.Separator(_U("main_server_bans_details_expiration", timeFormat(_U("date_format_long"), datas.expirationDetails)))
	RageUI.ButtonWithStyle(_U("main_server_bans_details_reason"), _U("main_server_bans_details_actual", datas.reason), { RightLabel = _U("main_server_bans_details_edit") }, Config.Groups[playerGroup].Access["submenu_server_bans_edit"] and not _var.menus.admin.cooldowns.items, function(_h, _a, s)
		if s then
			Citizen.CreateThread(function()
				_var.menus.admin.cooldowns.items = true
				local _reason = textEntry(_U("textentry_reason"), "", 50)
				if _reason == nil or _reason == "" then
					ESX.ShowNotification(_U("textentry_string_invalid"))
					_var.menus.admin.cooldowns.items = false
					return
				end
				TriggerServerEvent("epyi_administration:editBan", _var.bans.selectedBan.id, "editReason", { reason = _reason })
				_var.menus.admin.cooldowns.items = false
			end)
		end
	end)
	RageUI.ButtonWithStyle(
		_U("main_server_bans_details_delete"),
		_U("main_server_bans_details_delete_desc"),
		{ Color = { BackgroundColor = { 150, 50, 50, 20 } } },
		_var.bans.selectedBan.type == "BAN" and Config.Groups[playerGroup].Access["submenu_server_bans_edit"] and not _var.menus.admin.cooldowns.items,
		function(_h, _a, s)
			if s then
				Citizen.CreateThread(function()
					_var.menus.admin.cooldowns.items = true
					Citizen.Wait(500)
					TriggerServerEvent("epyi_administration:editBan", datas.id, "revoke", {})
					_var.menus.admin.cooldowns.items = false
				end)
			end
		end
	)
end
