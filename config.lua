-- WB_CONF = table.combine({
--     dummy_spacing_entitiy = "wooden-chest",
--     iterations_per_tick = 100,
--     water_tiles = {"water", "deepwater", "water-green", "deepwater-green", "out-of-map"},
--     clearance_tiles = 3,
--     run_over_multiple_ticks = true,
-- }, wall_blueprints.default_settings)

-- WB_CONF = remote.call("PlannerCoreInvoke", "WB_default_config")

-- if not WB_CONF then
--     crash()
-- end

function get_config(player)
    return table.combine(
        table.combine(table.clone(remote.call("PlannerCoreInvoke", "WB_default_config")), global.WB_CONF_global),
        global.WB_CONF_player[player.index]
    )
end

function set_config(player, new_conf) -- Override the configuration file on a per save basis.
    if new_conf and type(new_conf) == "table" then
        global.WB_CONF_player[player.index] = table.combine(global.WB_CONF_player[player.index], new_conf)
    else
        game.print("DEBUG: Bad config set")
    end
end

function set_config_global(new_conf) -- Override the configuration file on a per save basis.
    if new_conf and type(new_conf) == "table" then
        global.WB_CONF_global = table.combine(global.WB_CONF_global, new_conf)
    else
        game.print("DEBUG: Bad config set")
    end
end

function reset_all()
    global.WB_CONF_global = {}
    global.WB_CONF_player = {}
end

function config_init()
    global.WB_CONF_player = global.WB_CONF_player or {}
end

-- TODO Validate config (check entities exist)

table.insert(ON_INIT, config_init)

remote.add_interface("WallBuilder", {set_config = set_config_global, reset = reset_all, get_config = get_config})
