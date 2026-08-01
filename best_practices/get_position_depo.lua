-- ============================================================================
-- Модуль получения позиции по фондовому рынку (акции / depo_limits)
-- Файл: get_position_depo.lua
-- Назначение: Запрашивает лимиты по бумаге из таблицы "depo_limits" QUIK.
-- Возвращает: limit_kind (тип лимита), currentbal (остаток), wa_price (средняя цена)
-- ============================================================================

function getPosition(sec_code, trdaccid)
    local n = getNumberOf("depo_limits")
    local max_limit_kind = 0
    local result_currentbal = nil
    local result_wa_price = nil

    for i = 0, n - 1 do
        local row = getItem("depo_limits", i)
        if row and row.sec_code == sec_code and row.trdaccid == trdaccid then
            if row.limit_kind > 0 then
                if row.limit_kind > max_limit_kind then
                    max_limit_kind = row.limit_kind
                    result_currentbal = row.currentbal
                    result_wa_price = row.wa_position_price
                end
            end
        end
    end

    if max_limit_kind > 0 then
        return max_limit_kind, result_currentbal, result_wa_price
    else
        return nil, nil, nil
    end
end