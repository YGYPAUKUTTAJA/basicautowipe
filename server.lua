local autoWipeInterval = 15 * 60 * 1000 -- 15 minuuttia (millisekunteina)
local warningTime = 20 -- Varoitus aika (sekunteina)

-- Funktio, joka poistaa hyl‰tyt autot
function wipeAbandonedVehicles()
    -- L‰hetet‰‰n varoitus 20 sekuntia ennen wipe‰
    TriggerClientEvent('autoWipe:warnPlayer', -1, warningTime)

    -- Odotetaan varoitusajan verran ennen wipe‰
    Citizen.Wait(warningTime * 10) -- Odotetaan 20 sekuntia

    -- Poistetaan hyl‰tyt autot
    local vehicles = GetAllVehicles()

    for _, vehicle in ipairs(vehicles) do
        local driver = GetPedInVehicleSeat(vehicle, -1)

        -- Jos ajoneuvolla ei ole kuljettajaa, se on hyl‰tty
        if driver == 0 then
            DeleteEntity(vehicle)
        end
    end

    -- L‰hetet‰‰n ilmoitus kaikille pelaajille, ett‰ wipe on suoritettu
    TriggerClientEvent('chat:addMessage', -1, {
        color = {255, 0, 0},  -- Punainen v‰ri
        multiline = true,
        args = {"Server", "Hyl‰tyt autot on poistettu palvelimelta!"}
    })
end

-- Suorita wipe 15 minuutin v‰lein
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(autoWipeInterval) -- Odota 15 minuuttia
        wipeAbandonedVehicles() -- Poista hyl‰tyt autot
    end
end)
