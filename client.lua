RegisterNetEvent('autoWipe:warnPlayer')
AddEventHandler('autoWipe:warnPlayer', function(warningTime)
    -- L‰hetet‰‰n pelaajalle varoitus chattiin
    TriggerEvent('chat:addMessage', {
        color = {255, 255, 0},  -- Keltainen v‰ri
        multiline = true,
        args = {"Server", "Hyl‰tyt autot tullaan poistamaan " .. warningTime .. " sekunnin kuluttua!"}
    })
end)
