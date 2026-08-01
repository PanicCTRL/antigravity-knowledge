-- kill_stop_orders.lua
-- Эталонный сниппет для снятия активных стоп-заявок по инструменту (KillStop / SendKill)

-- ============================================================
-- ТРЕБУЕМЫЕ ПЕРЕМЕННЫЕ (объявляются в главном файле робота):
-- ============================================================
-- sec_code   -- код бумаги (для фильтрации заявок по инструменту)
-- class_code -- класс инструмента (для фильтрации заявок по инструменту)
-- ============================================================

pendKill = false

kill = {}
kill.ACTION   = "KILL_STOP_ORDER"
kill.TRANS_ID = "123"

function KillStop()
	local killedCount = SendKill()
	if killedCount == 0 and not pendKill then
		message("Все стоп-заявки удалены")
		pendKill = true
	end
end

function SendKill()
	local count = 0
	if not pendKill then
		for i = 0, getNumberOf("stop_orders") - 1 do
			local row = getItem("stop_orders", i)
			if row then
				if row.sec_code == sec_code and row.class_code == class_code and bit.band(row.flags, 1) > 0 then
					count = count + 1
					kill.CLASSCODE      = row.class_code
					kill.SECCODE        = row.sec_code
					kill.STOP_ORDER_KEY = tostring(row.order_num)
					message("Удаление стоп-заявки №" .. kill.STOP_ORDER_KEY)
					local res = sendTransaction(kill)
					if res ~= "" then
						message("Ошибка: " .. tostring(res), 2)
					end
				end
			end
		end
	end
	return count
end