---timeExpression
---@param expression string
---@return number|boolean
---@public
function timeExpression(expression)
	local timestamp = 0
	local current_number = ""
	for i = 1, #expression do
		local char = expression:sub(i, i)
		if tonumber(char) then
			current_number = current_number .. char
		elseif char == "d" then
			if current_number == "" then
				return false
			end
			timestamp = timestamp + tonumber(current_number) * 86400
			current_number = ""
		elseif char == "h" then
			if current_number == "" then
				return false
			end
			timestamp = timestamp + tonumber(current_number) * 3600
			current_number = ""
		elseif char == "m" then
			if current_number == "" then
				return false
			end
			timestamp = timestamp + tonumber(current_number) * 60
			current_number = ""
		else
			return false
		end
	end
	if current_number ~= "" then
		timestamp = timestamp + tonumber(current_number)
	end
	return timestamp
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
