-- send_stop_order.lua
-- Эталонный сниппет: формирование и отправка стоп-заявки / стоплосса (SendStop)

-- ============================================================
-- ТРЕБУЕМЫЕ ПЕРЕМЕННЫЕ (объявляются в главном файле робота):
-- ============================================================
-- firm_id     -- торговый счет
-- client_code -- код клиента
-- class_code  -- класс инструмента
-- sec_code    -- код бумаги
-- operation   -- направление открытой позиции: "B" или "S"
-- quantity    -- количество (строка или число)
-- startPrice  -- цена входа / уровень, от которого считается стоп
-- slOffset    -- отступ стоп-лосса от цены входа (в единицах инструмента)
-- price_limit -- лимитная цена исполнения стопа ("0" = рыночный)
-- path        -- путь к лог-файлу
-- ============================================================

pendStop = false -- Флаг-переключатель ожидания стоп-заявки. Переключение (сброс/взвод) происходит в другом месте алгоритма — вне этого файла.

sl = {}
sl.ACCOUNT     = firm_id      -- Торговый счет
sl.CLIENT_CODE = client_code  -- Код клиента
sl.CLASSCODE   = class_code   -- Класс инструмента
sl.SECCODE     = sec_code     -- Код бумаги
sl.ACTION      = "NEW_STOP_ORDER"
sl.TRANS_ID    = "1112"

function SendStop(sec_code, class_code)
	sl.OPERATION = (operation == "B") and "S" or "B"
	sl.QUANTITY  = quantity
	sl.STOPPRICE = tostring(startPrice + ((operation == "B") and -slOffset or slOffset))
	sl.PRICE     = tostring(price_limit)
	stop_price   = tonumber(sl.STOPPRICE)
	local text1 = (sl.PRICE == "0") and "рыночный" or "лимитированный"
	local text2 = (sl.OPERATION == "B") and "покупку" or "продажу"
	local res = sendTransaction(sl)
	if res == "" then
		pendStop = true
		WriteLog(path, ("Выставлен %s стоплосс на %s %s шт %s. Цена срабатывания: %s; планка: %s"):format(
			text1, text2, sl.QUANTITY, sl.SECCODE, sl.STOPPRICE, sl.PRICE))
	else
		message(res, 2)
	end
end