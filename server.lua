local autoWipeInterval = 15 * 60 * 1000 -- 15 minuuttia (millisekunteina)
local warningTime = 20 -- Varoitus aika (sekunteina)

-- Funktio, joka poistaa hylätyt autot
function wipeAbandonedVehicles()
    -- Lähetetään varoitus 20 sekuntia ennen wipeä
    TriggerClientEvent('autoWipe:warnPlayer', -1, warningTime)

    -- Odotetaan varoitusajan verran ennen wipeä
    Citizen.Wait(warningTime * 1000) -- Odotetaan 20 sekuntia

    -- Poistetaan hylätyt autot
    local vehicles = GetAllVehicles()

    for _, vehicle in ipairs(vehicles) do
        local driver = GetPedInVehicleSeat(vehicle, -1)

        -- Jos ajoneuvolla ei ole kuljettajaa, se on hylätty
        if driver == 0 then
            DeleteEntity(vehicle)
        end
    end

    -- Lähetetään ilmoitus kaikille pelaajille, että wipe on suoritettu
    TriggerClientEvent('chat:addMessage', -1, {
        color = {255, 0, 0},  -- Punainen väri
        multiline = true,
        args = {"Server", "Hylätyt autot on poistettu palvelimelta!"}
    })
end

-- Suorita wipe 15 minuutin välein
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(autoWipeInterval) -- Odota 15 minuuttia
        wipeAbandonedVehicles() -- Poista hylätyt autot
    end
end)
