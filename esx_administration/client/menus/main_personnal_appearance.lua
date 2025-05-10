---main_personnal_appearance_showContentThisFrame → Function to show the main/personnal/appearanceance menu content
---@param playerGroup string
---@return void
function main_personnal_appearance_showContentThisFrame(playerGroup)
	RageUI.ButtonWithStyle(_U("main_personnal_appearance_back"), _U("main_personnal_appearance_back_desc"), {}, true, function(_, _, s)
		if s then
			ESX.TriggerServerCallback("esx_skin:getPlayerSkin", function(skin)
				TriggerEvent("skinchanger:loadDefaultModel", skin.sex, function()
					TriggerEvent("skinchanger:loadSkin", skin)
				end)
				ESX.ShowNotification(_U("notif_appearance_back_success"))
			end)
		end
	end)
	RageUI.List(_U("main_personnal_appearance_peds_filter"), _var.menu.pedsCategoryFilterArray, _var.menu.pedsCategoryFilterArrayIndex, _U("main_personnal_appearance_peds_filter_desc"), {}, true, function(_, _, _, i)
		_var.menu.pedsCategoryFilterArrayIndex = i
	end)
	RageUI.Separator(_U("main_personnal_appearance_peds"))
	for _k, category in pairs(_var.peds.list) do
		if _var.menu.pedsCategoryFilterArray[_var.menu.pedsCategoryFilterArrayIndex] == category.category or _var.menu.pedsCategoryFilterArray[_var.menu.pedsCategoryFilterArrayIndex] == _U("main_personnal_appearance_pedscategory0") then
			for _k, model in pairs(category.models) do
				RageUI.ButtonWithStyle(model.label .. " ~m~→ ~c~" .. model.model, _U("main_personnal_appearance_peds_desc", model.label, model.model), { RightBadge = RageUI.BadgeStyle.Clothes }, not _var.menus.admin.cooldowns.items, function(_, _, s)
					if s then
						_var.menus.admin.cooldowns.items = true
						Citizen.CreateThread(function()
							local pedHash = joaat(model.model)
							RequestModel(pedHash)
							repeat
								Citizen.Wait(1)
							until HasModelLoaded(pedHash)
							_var.menus.admin.cooldowns.items = false
							SetPlayerModel(PlayerId(), pedHash)
							SetModelAsNoLongerNeeded(pedHash)
							SetPedDefaultComponentVariation(PlayerPedId())
						end)
					end
				end)
			end
		end
	end
end
