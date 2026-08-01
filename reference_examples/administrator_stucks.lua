local sec_code		= "SBER"           		-- Текущий актив
local class_code 	= "QJSIM"        		-- Класс инструментов
local firm_id 		= "NC0011100000"   		-- Торговый счет
local client_code 	= "1003"		  		-- Клиентский код
local trdaccid		= "NL0011100043"		-- Торговый аккаунт

local file = getScriptPath().."\\totalpos.txt"

function getPosition(sec_code, trdaccid)
    local n = getNumberOf("depo_limits")
    local max_limit_kind = 0
    local result_currentbal = nil
    local result_wa_price = nil

    for i = 0, n-1 do
        local row = getItem("depo_limits", i)
        if row.sec_code == sec_code and row.trdaccid == trdaccid then
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

function posTRSFr(text)
    local f = io.open(file, "w") 
    if f then
        f:write(text .. "\n")
        f:close()
    end
end

function main()
	while true do
		local limit_kind, currentbal, wa_price = getPosition(sec_code, trdaccid)
		local text = ""
	
		if limit_kind ~= nil then
			text = string.format("%s %d %f", sec_code, currentbal, wa_price)
		end
	
		posTRSFr(text)
    
		sleep(500)
	end
end