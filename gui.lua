local function add_button(gui)
    gui.add({type = "button", name = "WallBuilderBlueprintRead", caption = "WB", style = "blueprint_button_style"})
end

local function createBlueprintButton(player)
    local topGui = player.gui.top
    if not topGui.WallBuilderBlueprintRead then
        add_button(topGui)
    end
end

local function init_gui()
    for k, player in pairs(game.players) do
        if player.gui.top.WallBuilderBlueprintRead then
            player.gui.top.WallBuilderBlueprintRead.destroy()
        end
        createBlueprintButton(player)
    end
end

table.insert(ON_INIT, init_gui)

script.on_event(
    defines.events.on_gui_click,
    function(event)
        if event.element.name == "WallBuilderBlueprintRead" then
            local player = game.players[event.element.player_index]
            local conf = get_config(player)
            local new_conf = remote.call("PlannerCoreInvoke", "WB_on_button_press", event, conf)
            if new_conf then


                set_config(player, new_conf)
            end
        end
    end
)

script.on_event(
    defines.events.on_player_joined_game,
    function(event)
        createBlueprintButton(game.players[event.player_index])
    end
)
