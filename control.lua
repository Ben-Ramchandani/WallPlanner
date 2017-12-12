require("on_init")
require("util")
require("config")
require("gui")

--[[  Main funtion  ]]

function on_selected_area(event, deconstruct_friendly)
    
    local player = game.players[event.player_index]
    local conf = get_config(player)

    remote.call("PlannerCoreInvoke", "WallBuilder", event.entities, player, conf)
end

--[[  Register events  ]]

script.on_event(
    defines.events.on_player_selected_area,
    function(event)
        if event.item == "wall-builder" then
            on_selected_area(event, false)
        end
    end
)

script.on_event(
    defines.events.on_player_alt_selected_area,
    function(event)
        if event.item == "wall-builder" then
            on_selected_area(event, true)
        end
    end
)
