---main_server_bans_showContentThisFrame → Function to show the main/server/bans menu content
---@param playerGroup string
---@return void
function main_server_bans_showContentThisFrame(playerGroup)
	_var.client.playerData = ESX.GetPlayerData()
	RageUI.ButtonWithStyle(
		_U("search"),
		_U("main_server_bans_filter_desc"),
		{
			RightLabel = (_var.menu.bansFilter ~= "" and _var.menu.bansFilter or _U("no_filter")),
		},
		true,
		function(_h, _a, Selected)
			if Selected then
				local search = textEntry(_U("textentry_search"), _var.menu.bansFilter, 30)
				if search == nil or search == "" then
					_var.menu.bansFilter = ""
					return
				end
				_var.menu.bansFilter = search
			end
		end
	)
	RageUI.Separator(_U("filter_result"))
	local count = 0
	for _, content in pairs(_var.bans.list) do
		local datas = json.decode(content.data)
		if _var.menu.bansFilter == "" or string.find(string.lower(datas.id .. datas.targetName .. datas.staffName .. datas.reason .. content.type .. (content.type == "BAN" and _U("main_server_bans_unit_valid") or _U("main_server_bans_unit_finished"))), string.lower(_var.menu.bansFilter)) ~= nil then
			count = count + 1
			RageUI.ButtonWithStyle(
				"~c~[#" .. content.id .. "] ~s~" .. datas.targetName,
				_U("main_server_bans_unit_desc"),
				{
					RightLabel = content.type == "BAN" and _U("main_server_bans_unit_valid") or _U("main_server_bans_unit_finished"),
				},
				true,
				function(_h, _a, s)
					if s then
						_var.bans.selectedBan = content
					end
				end,
				_var.menus.admin.objects.mainServerBansDetails
			)
		end
	end
	if count == 0 then
		RageUI.Separator("")
		RageUI.Separator(_U("no_result"))
		RageUI.Separator("")
	end
end
