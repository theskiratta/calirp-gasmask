-- ==================================--
--           GASMASK v2.5           --
--           by JellyJam            --
-- Forked and edited by theskiratta --
--       License: GNU GPL 3.0.      --
-- ==================================--
-- FUNCTIONS
GasMaskOn, WearingMask = false, false

function notify(string)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(string)
    DrawNotification(true, false)
end

-- Plays putting on mask emote
local function PlayEmote()
    local playerped = GetPlayerPed(-1)
    RequestAnimDict('mp_masks@standard_car@ds@')
    TaskPlayAnim(playerped, 'mp_masks@standard_car@ds@', 'put_on_mask', 8.0, 8.0, 800, 16, 0, false, false, false)
end

function Draw2DText(x, y, text, scale, r, g, b, a)
    SetTextFont(4)
    SetTextProportional(7)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextEdge(4, 0, 0, 0, 255)
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x, y)
end

-- Checks if given value is in table from config
function IsValidMask(val)
    for _, value in ipairs(Config.masklist) do
        if value == val then
            return true
        end
    end
    return false
end

-- WEARING MASK 

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        -- Checks if mask is worn
        CurrentMaskID = GetPedDrawableVariation(PlayerPedId(), 1)
        WearingMask = IsValidMask(CurrentMaskID)

        -- If Mask is worn, makes invincible to gas and prints notification
        if WearingMask then
            GasMaskOn = true
            local playerped = GetPlayerPed(-1)
            SetEntityProofs(playerped, false, false, false, false, false, false, true, true, false)
            if Config.showhud then
                Draw2DText(Config.hudx, Config.hudy, "~w~Gasmask: ~g~Equipped", Config.hudscale, 255, 255, 255, 255);
            else
                GasMaskOn = false
                SetPedComponentVariation(PlayerPedId(), 1, 0, 0, 1)
                notify("You are not ~b~certified ~w~to wear this!")
            end
        elseif not WearingMask then
            GasMaskOn = false
            local playerped = GetPlayerPed(-1)
            SetEntityProofs(playerped, false, false, false, false, false, false, false, false, false)
            -- if isAllowed ~= false and isAllowed == true then
            if Config.showhud then
                Draw2DText(Config.hudx, Config.hudy, "~w~Gasmask: ~r~Unequipped", Config.hudscale, 255, 255, 255, 255);
            end
        end
    end
end)

-- COMMAND

RegisterCommand("gasmask", function(Source, args, rawCommand)
    if args[1] == "on" then
        if not GasMaskOn then
            GasMaskOn = true
            local playerped = GetPlayerPed(-1)
            SetEntityProofs(playerped, false, false, false, false, false, false, true, true, false)
            PlayEmote()
            SetPedComponentVariation(PlayerPedId(), 1, Config.defaultmask, 0, 1)
            notify("Gasmask ~g~equipped")
        else
            notify("Your mask ~w~is already ~g~on")
        end
    elseif args[1] == "off" then
        if GasMaskOn then
            GasMaskOn = false
            local playerped = GetPlayerPed(-1)
            SetEntityProofs(playerped, false, false, false, false, false, false, false, false, false)
            PlayEmote()
            SetPedComponentVariation(PlayerPedId(), 1, 0, 0, 1)
            notify("Gasmask ~r~unequipped")
        else
            notify("Your mask ~w~is already ~r~off")
        end
    elseif args[1] == nil then
        if not GasMaskOn then
            GasMaskOn = true
            local playerped = GetPlayerPed(-1)
            SetEntityProofs(playerped, false, false, false, false, false, false, true, true, false)
            PlayEmote()
            SetPedComponentVariation(PlayerPedId(), 1, Config.defaultmask, 0, 1)
            notify("Gasmask ~g~equipped")
        else
            GasMaskOn = false
            local playerped = GetPlayerPed(-1)
            SetEntityProofs(playerped, false, false, false, false, false, false, false, false, false)
            PlayEmote()
            SetPedComponentVariation(PlayerPedId(), 1, 0, 0, 1)
            notify("Gasmask ~r~unequipped")
        end
    else
        notify("This command is not recognized")
    end
end)

TriggerEvent('chat:addSuggestion', '/gasmask', 'Take a gasmask on/off')
