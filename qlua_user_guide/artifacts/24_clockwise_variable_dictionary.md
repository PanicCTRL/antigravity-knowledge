# Реестр переменных и функций проекта Clockwise (Variable Dictionary)

Этот документ является **главным справочником именования** (dictionary) для робота `Clockwise`. 
Все переменные сгруппированы по категориям согласно правилам проекта.

---

## 1. Переменные QUIK (Правило 8.5)
Имена берутся строго из документации QUIK.

| Название переменной | Тип | Описание | Основной файл |
| :--- | :--- | :--- | :--- |
| `sec_code` | `string` | Код ценной бумаги / фьючерса (например, `"NGJ6"`, `"SBER"`) | `clockwise_variable_time.lua` |
| `class_code` | `string` | Код класса инструментов (например, `"SPBFUT"`, `"QJSIM"`) | `clockwise_variable_time.lua` |
| `firm_id` | `string` | Идентификатор фирмы / Торговый счет (например, `"SPBFUT"`, `"NC0011100000"`) | `clockwise_variable_time.lua` |
| `client_code` | `string` | Клиентский код в терминале QUIK (например, `"762157N"`) | `clockwise_variable_time.lua` |
| `trdaccid` | `string` | Торговый счет (для фондового рынка / акций QJSIM) | `clockwise_variable_time.lua` |

---

## 2. Переменные времени / Интервалов (Правило 8.4)
Именуются в стиле `snake_case` из двух слов, где второе слово — `time` или `length`.

| Название переменной | Тип | Описание | Основной файл |
| :--- | :--- | :--- | :--- |
| `period_length` | `number` | Длительность торгового периода в секундах (по умолчанию `60`) | `clockwise_variable_time.lua` |
| `reset_before` | `number` | Секунд до конца периода для фазы сброса/ожидания (по умолчанию `20`) | `clockwise_variable_time.lua` |
| `all_end_period` | `number` | Метка времени (`os.time()`) окончания текущего периода | `clockwise_variable_time.lua` |
| `first_period_end` | `number` | Метка времени (`os.time()`) окончания 1-й фазы торгового периода | `clockwise_variable_time.lua` |
| `trade_hour` | `number` | Час торгов (из старой логики `ClearTime`) | `clockwise_variable_time.lua` |
| `trd_min_befor` | `number` | Минута граница сброса в часовом периоде (по умолчанию `45`) | `clockwise_variable_time.lua` |

---

## 3. Пользовательские переменные (Правило 8.6)
Определяются в стиле `camelCase` (или из списка именований `snake_case`).

| Название переменной | Тип | Описание | Основной файл |
| :--- | :--- | :--- | :--- |
| `trade_type` | `string` | Тип счета (`"M"` для фьючерсов SPBFUT, `"L"` для акций QJSIM) | `clockwise_variable_time.lua` |
| `operation` | `string` | Направление сделки (`"B"` — Buy/Покупка, `"S"` — Sell/Продажа) | `clockwise_variable_time.lua` |
| `quantity` | `string` | Количество лотов в заявке (строка, например `"1"`, `"10"`) | `clockwise_variable_time.lua` |
| `step` | `number` | Минимальный шаг цены инструмента (`SEC_PRICE_STEP`) | `clockwise_variable_time.lua` |
| `dec` | `number` | Количество знаков после запятой у цены (точность шага) | `clockwise_variable_time.lua` |
| `currentPrice` | `number` | Последняя цена сделки из коллбека `OnAllTrade` | `clockwise_variable_time.lua` |
| `price_limit` | `number` | Верхняя или нижняя планка цены (`PRICEMAX` / `PRICEMIN`) | `clockwise_variable_time.lua` |
| `startPrice` | `number` | Базовая цена входа / точка отсчета стопа и рестарта | `clockwise_variable_time.lua` |
| `initPrice` | `number` | Инициализирующая цена из `OnTrade` (максимум или минимум сделки) | `clockwise_variable_time.lua` |
| `max_price` | `number` | Максимальная цена сделки в текущей сессии (из `OnTrade`) | `clockwise_variable_time.lua` |
| `min_price` | `number` | Минимальная цена сделки в текущей сессии (из `OnTrade`) | `clockwise_variable_time.lua` |
| `stop_price` | `number` | Текущий уровень стоп-цены выставленного стоп-лосса | `clockwise_variable_time.lua` |
| `STOP_PRICE` | `number` | Расчетная новая стоп-цена при переносе стоп-лосса | `clockwise_variable_time.lua` |
| `slippage` | `number` | Величина проскальзывания при покупке/продаже | `clockwise_variable_time.lua` |
| `slSlippage` | `number` | Проскальзывание в цене стоп-лосса | `clockwise_variable_time.lua` |
| `slOffset` | `number` | Отступ стоп-лосса от цены входа `startPrice` | `clockwise_variable_time.lua` |
| `count_trades` | `number` | Максимально допустимое число повторных входов (по умолчанию `1`) | `clockwise_variable_time.lua` |
| `count_t` | `number` | Текущий остаток попыток повторного входа | `clockwise_variable_time.lua` |
| `distUpLim` | `number` | Допустимый процент расстояния до верхней планки | `clockwise_variable_time.lua` |
| `distDownLim` | `number` | Допустимый процент расстояния до нижней планки | `clockwise_variable_time.lua` |
| `path` | `string` | Путь к основному файлу лога (`fl_clockwise.txt`) | `clockwise_variable_time.lua` |
| `transaction` | `string` | Путь к файлу транзакций (`fl_cl_trnstn.txt`) | `clockwise_variable_time.lua` |

### Флаги состояния (Boolean)
| Название переменной | Тип | Описание | Основной файл |
| :--- | :--- | :--- | :--- |
| `opn` | `boolean` | `true` если позиция сейчас открыта | `clockwise_variable_time.lua` |
| `stopRpcd` | `boolean` | `true` если стоп-лосс в текущем периоде уже перенесен | `clockwise_variable_time.lua` |
| `pendOpen` | `boolean` | `true` пока отправлена заявка на вход, но ещё не исполнена | `clockwise_sendtransaction_spbfut.lua` |
| `pendStop` | `boolean` | `true` пока отправлен стоп-лосс, но подтверждения нет | `clockwise_sendtransaction_spbfut.lua` |
| `pendBrkt` | `boolean` | `true` резервный флаг для брекет-заявки | `clockwise_sendtransaction_spbfut.lua` |
| `pendKillOrder` | `boolean` | `true` флаг процесса снимка/снятия стоп-заявок | `killStopOrdersByNumber.lua` |

---

## 4. Таблицы транзакций (QUIK Structures)

| Название таблицы | Поля / Назначение | Файл |
| :--- | :--- | :--- |
| `tx` | Таблица лимитной/рыночной транзакции (`NEW_ORDER`). Поля: `ACCOUNT`, `CLIENT_CODE`, `TYPE`, `TRANS_ID`, `CLASSCODE`, `SECCODE`, `ACTION`, `OPERATION`, `QUANTITY`, `PRICE` | `clockwise_sendtransaction_spbfut.lua` |
| `sl` | Таблица стоп-заявки (`NEW_STOP_ORDER`). Поля: `ACCOUNT`, `CLIENT_CODE`, `TRANS_ID`, `CLASSCODE`, `SECCODE`, `ACTION`, `OPERATION`, `QUANTITY`, `STOPPRICE`, `PRICE` | `clockwise_sendtransaction_spbfut.lua` |
| `kill` | Таблица снятия стопа (`KILL_STOP_ORDER`). Поля: `ACTION`, `TRANS_ID`, `CLASSCODE`, `SECCODE`, `STOP_ORDER_KEY` | `killStopOrdersByNumber.lua` |

---

## 5. Функции проекта

### 5.1. Локальные функции основного скрипта (Правило 8.7 — PascalCase)
| Функция | Аргументы | Назначение |
| :--- | :--- | :--- |
| `Clockwise()` | `()` | Возвращает стейдж периода (1 — активность/вход, 2 — сброс/ожидание, 0 — сброс периода) |
| `countDecimals(n)` | `(n)` | Вычисляет количество знаков после запятой у числа |

### 5.2. Функции во внешних файлах (Правило 8.8 — snake_case из 2–3 слов)
| Функция | Файл | Назначение |
| :--- | :--- | :--- |
| `ClearTime()` | `clockwise_cleartime.lua` | Парсит `SERVERTIME` из QUIK и возвращает `hour, minute, second` |
| `CanIOpenTrade()` | `dll_CanIOpenTrade.lua` | Выполняет комплексную проверку разрешения торговли |
| `CheckConnection()` | `dll_CanIOpenTrade.lua` | Проверка флага соединения с сервером QUIK |
| `CheckTradingStatus()` | `dll_CanIOpenTrade.lua` | Проверка статуса инструмента (`"торгуется"`) |
| `CheckTradingDay()` | `dll_CanIOpenTrade.lua` | Проверка на выходные дни |
| `CheckPriceLimits()` | `dll_CanIOpenTrade.lua` | Проверка расстояния до верхних/нижних планок |
| `KillStop()` | `killStopOrdersByNumber.lua` | Снимает все активные стоп-заявки по инструменту |
| `SendKill()` | `killStopOrdersByNumber.lua` | Ищет в `stop_orders` и отправляет транзакции снятия |
| `WriteLog(path, text, noPrefix)` | `clockwise_writelog.lua` | Записывает строку в текстовый лог |
| `Entry(sec_code, class_code)` | `clockwise_sendtransaction_spbfut.lua` | Отправляет рыночную/лимитную заявку на вход |
| `SendStop(sec_code, class_code)` | `clockwise_sendtransaction_spbfut.lua` | Выставляет стоп-лосс по `startPrice` и `price_limit` |
