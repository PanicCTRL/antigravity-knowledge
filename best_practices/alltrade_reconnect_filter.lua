-- alltrade_reconnect_filter.lua
-- Модуль фильтрации старых сделок и защиты от ложных входов при реконнекте QUIK

max_trade_lag_sec   = 8       -- Порог возраста сделки в секундах
min_stable_sec      = 5       -- Сколько секунд поток должен быть свежим для разрешения торговли
online_start        = nil     -- Момент начала стабильного онлайн-потока (os.time)
stream_is_stable    = false   -- Флаг: поток сейчас полностью стабилизирован
stream_warn_sent    = false   -- Защита от спама сообщением об обрыве

function CheckTradeFreshness(alltrade)
    if not alltrade or not alltrade.datetime then return false end

    local tr_sec  = os.time(alltrade.datetime)
    local pc_sec  = os.time()
    local lag_sec = pc_sec - tr_sec

    -- Тик считается свежим, если лаг не превышает порог (с допуском -2 сек на рассинхрон часов)
    local is_fresh = (lag_sec <= max_trade_lag_sec) and (lag_sec >= -2)

    if is_fresh then
        if not online_start then
            online_start = pc_sec  -- Фиксируем момент начала свежего потока
            stream_warn_sent = false
            message("Поток сделок восстановлен, синхронизация " .. tostring(min_stable_sec) .. " сек.", 1)
        end
    else
        online_start = nil  -- Сброс: обнаружен старый тик
        if not stream_warn_sent then
            stream_warn_sent = true
            stream_is_stable = false
            message("Обрыв соединения по потоку сделок.", 2)
        end
    end

    local ready = is_fresh and online_start ~= nil and (pc_sec - online_start) >= min_stable_sec

    if ready and not stream_is_stable then
        stream_is_stable = true
        message("Синхронизация потока завершена. Робот активен.", 1)
    end

    return ready
end