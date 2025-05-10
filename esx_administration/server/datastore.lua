_datastore = _datastore or {}

Citizen.CreateThread(function()
	local response = MySQL.query.await("SELECT * FROM `epyi_administration`", {})

	if response then
		for i = 1, #response do
			local row = response[i]
			_datastore[row.id] = {
				id = row.id or 0,
				type = row.type or "invalid",
				date_unix = row.date_unix or 1,
				data = row.data or {},
				owner = row.owner or "server",
			}
		end
	end
end)

local function saveDatastoreToDB()
	for id, content in pairs(_datastore) do
		local check = MySQL.single.await("SELECT * FROM `epyi_administration` WHERE `id` = ? LIMIT 1", {
			id,
		})
		if check and (check.type ~= content.type or check.date_unix ~= content.date_unix or check.data ~= content.data or check.owner ~= content.owner) then
			MySQL.update.await("UPDATE epyi_administration SET type = ?, date_unix = ?, data = ?, owner = ? WHERE id = ?", {
				content.type,
				content.date_unix,
				content.data,
				content.owner,
				id,
			})
		end

		if not check then
			MySQL.insert.await("INSERT INTO `epyi_administration` (id, type, date_unix, data, owner) VALUES (?, ?, ?, ?, ?)", {
				id,
				content.type,
				content.date_unix,
				content.data,
				content.owner,
			})
		end
	end
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10 * 60 * 1000)
		saveDatastoreToDB()
	end
end)

AddEventHandler("onResourceStop", function(resourceName)
	if GetCurrentResourceName() ~= resourceName then
		return
	end
	saveDatastoreToDB()
end)

AddEventHandler("epyi_administration:saveData", function(type, data, owner)
	local _id = #_datastore + 1
	data.id = _id
	_datastore[_id] = {
		id = _id,
		type = type,
		date_unix = os.time(),
		data = json.encode(data),
		owner = owner,
	}
end)

AddEventHandler("epyi_administration:editData", function(id, type, date_unix, data, owner)
	if not _datastore[id] then
		return
	end
	_datastore[id] = {
		id = id,
		type = type,
		date_unix = date_unix,
		data = data,
		owner = owner,
	}
end)

AddEventHandler("epyi_administration:deleteData", function(id)
	if not _datastore[id] then
		log("Attempt to delete a non-existent data, id: " .. id)
		return
	end
	_datastore[id].type = "D_" .. _datastore[id].type
end)
