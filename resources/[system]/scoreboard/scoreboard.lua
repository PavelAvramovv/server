local listOn = false

Citizen.CreateThread(function()
    listOn = false
    while true do
        Wait(0)

        if IsControlPressed(0, 27)--[[ INPUT_PHONE ]] then
            if not listOn then
                local players = {}
                ptable = GetPlayers()
                for _, i in ipairs(ptable) do
                    local wantedLevel = GetPlayerWantedLevel(i)
                    local wantedString = ''
                    if wantedLevel > 0 then
                        for i=1, wantedLevel, 1 do
                            wantedString = wantedString .. '⭐'
                        end
                    else
                        wantedString = '✅'
                    end
                    r, g, b = GetPlayerRgbColour(i)
                    table.insert(players, 
                        '<tr style=\"color: rgb(' .. r .. ', ' .. g .. ', ' .. b .. ')\"><td>' .. GetPlayerServerId(i) .. '</td><td>' .. GetPlayerName(i) .. '</td><td>' .. wantedString .. '</td></tr>'
                    )
                end
                
                SendNUIMessage({ text = table.concat(players) })

                listOn = true
                while listOn do
                    Wait(0)
                    if(IsControlPressed(0, 27) == false) then
                        listOn = false
                        SendNUIMessage({
                            meta = 'close'
                        })
                        break
                    end
                end
            end
        end
    end
end)

function GetPlayers()
    local players = {}

    for i = 0, 31 do
        if NetworkIsPlayerActive(i) then
            table.insert(players, i)
        end
    end

    return players
end