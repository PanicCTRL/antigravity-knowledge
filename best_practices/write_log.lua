-- write_log.lua
-- Ёталонна€ функци€ записи сообщений в лог-файл (WriteLog)

-- ============================================================
-- “–≈Ѕ”≈ћџ≈ ѕ≈–≈ћ≈ЌЌџ≈ (объ€вл€ютс€ в главном файле робота):
-- ============================================================
-- path -- абсолютный путь к лог-файлу (строка)
--         –екомендуемый способ задани€:
--         path = getScriptPath().."\\<им€_лога>.txt"
-- ============================================================

function WriteLog(path, text, noPrefix)
	if not path or not text then return end
	local f = io.open(path, "a")
	if f then
		local tradeDate = getInfoParam("TRADEDATE")
		local serverTime = getInfoParam("SERVERTIME")
		local logTime = serverTime
		if not serverTime or serverTime == "" then
			logTime = os.date("%H:%M:%S")
		end
		if noPrefix then
			f:write(text .. "\n")
		else
			local prefix = string.format("%s;%s;", tradeDate, logTime)
			f:write(prefix .. text .. "\n")
		end
		f:close()
	end
end