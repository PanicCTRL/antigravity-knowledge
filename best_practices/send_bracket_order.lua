-- send_bracket_order.lua
-- Эталонный сниппет: отправка связанной стоп-заявки Тейк-профит + Стоп-лосс (SendBracket)

-- ============================================================
-- ТРЕБУЕМЫЕ ПЕРЕМЕННЫЕ (объявляются в главном файле робота):
-- ============================================================
-- firm_id      -- торговый счет
-- client_code  -- код клиента
-- class_code   -- класс инструмента
-- sec_code     -- код бумаги
-- operation    -- направление открытой позиции: "B" или "S"
-- quantity     -- количество (строка или число)
-- tpPrice      -- цена срабатывания тейк-профита
-- slPrice      -- цена срабатывания стоп-лосса
-- tpOffset     -- отступ от экстремума для тейка
-- tpSpread     -- защитный спред для тейка
-- slLimitPrice -- цена лимитного ордера при срабатывании стопа
-- path         -- путь к лог-файлу
-- ============================================================

pendBrkt = false -- Флаг-переключатель ожидания брекет-заявки. Переключение (сброс/взвод) происходит в другом месте алгоритма — вне этого файла.

brkt = {}
brkt.ACCOUNT          = firm_id       -- Торговый счет
brkt.CLIENT_CODE      = client_code   -- Код клиента
brkt.CLASSCODE        = class_code    -- Класс инструмента
brkt.SECCODE          = sec_code      -- Код бумаги
brkt.ACTION           = "NEW_STOP_ORDER"
brkt.STOP_ORDER_TYPE  = "TAKE_PROFIT_AND_STOP_LIMIT"
brkt.TRANS_ID         = "3344"

function SendBracket(sec_code, class_code)
	brkt.OPERATION        = (operation == "B") and "S" or "B"
	brkt.QUANTITY         = quantity
	brkt.STOPPRICE        = tostring(tpPrice)       -- Цена срабатывания тейк-профита
	brkt.STOPPRICE2       = tostring(slPrice)       -- Цена срабатывания стоп-лосса
	brkt.OFFSET           = tostring(tpOffset)      -- Отступ от экстремума для тейка
	brkt.SPREAD           = tostring(tpSpread)      -- Защитный спред для тейка
	brkt.PRICE            = "0"                     -- Цена исполнения тейка ("0" = по рынку)
	brkt.PRICE2           = tostring(slLimitPrice)  -- Цена лимитного ордера при срабатывании стопа
	brkt.MARKET_TAKE_PROFIT = "YES"
	brkt.MARKET_STOP_LIMIT  = "NO"
	local res = sendTransaction(brkt)
	if res == "" then
		pendBrkt = true
		WriteLog(path, ("Выставлен брекет (ТП: %s, СЛ: %s) на %s шт %s"):format(
			brkt.STOPPRICE, brkt.STOPPRICE2, brkt.QUANTITY, brkt.SECCODE))
	else
		message(res, 2)
	end
end