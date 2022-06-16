--==================================--
--           GASMASK v2.5           --
--           by JellyJam            --
-- Forked and edited by theskiratta --
--       License: GNU GPL 3.0.      --
--==================================--

Config = {}

Config.defaultmask = 46 -- (46 by default) Change this to whichever mask you want to be equipped when using the command

Config.masklist = {
    46,
    47
}

Config.showhud = true -- Change to false if you do not want the status of the gasmask to be shown on the HUD

-- If above is set to false, ignore everything below this line

Config.hudx = .225 -- X value of hud (used for positioning across X axis)
Config.hudy = .952 -- Y value of hud (used for positioning across Y axis)
Config.hudscale = 0.4 -- Scale of hud