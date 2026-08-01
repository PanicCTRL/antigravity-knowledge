-- send_limit_order.lua
-- Эталонный сниппет: формирование и отправка рыночной / лимитной заявки (SendOrder)

-- ============================================================
-- ТРЕБУЕМЫЕ ПЕРЕМЕННЫЕ (объявляются в главном файле робота):
-- ============================================================
-- firm_id     -- торговый счет (для срочного рынка SPBFUT)
-- client_code -- код клиента
-- class_code  -- класс инструмента
-- sec_code    -- код бумаги
-- trade_type  -- тип сделки: "M" (по рынку) или "L" (лимитная)
-- operation   -- направление: "B" (покупка) или "S" (продажа)
-- quantity    -- количество (строка или число)
-- path        -- путь к лог-файлу
-- ============================================================

pendOrder = false -- Флаг-переключатель ожидания заявки. Переключение (сброс/взвод) происходит в другом месте алгоритма — вне этого файла.

tx = {}
tx.ACCOUNT     = firm_id      -- Торговый счет (для срочного рынка SPBFUT)
tx.CLIENT_CODE = client_code  -- Код клиента
tx.TYPE        = trade_type   -- Тип сделки ("M" - по рыночной цене, "L" - лимитная)
tx.TRANS_ID    = "5678"
tx.CLASSCODE   = class_code   -- Класс инструмента
tx.SECCODE     = sec_code     -- Код бумаги
tx.ACTION      = "NEW_ORDER"

function SendOrder(sec_code, class_code)
	tx.OPERATION = operation
	tx.QUANTITY  = quantity
	tx.PRICE     = "0" -- "0" для рыночной заявки или точная цена для лимитной
	local res = sendTransaction(tx)
	if res == "" then
		pendOrder = true
		WriteLog(path, ("Заявка на %s %s %s в кол-ве %s шт."):format(
			(tx.OPERATION == "B") and "покупку" or "продажу", sec_code,
			(tx.PRICE == "0") and "по рыночной цене" or ("по цене "..tx.PRICE), tx.QUANTITY))
	else
		message(res, 2)
	end
end