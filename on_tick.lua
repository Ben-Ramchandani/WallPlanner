function register(state)
    if not global.WB_states then
        global.WB_states = {state}
    else
        table.insert(global.WB_states, state)
    end
    if #global.WB_states == 1 then
        script.on_event(defines.events.on_tick, on_tick)
    end
end

function on_tick(event)
    if #global.WB_states == 0 then
        script.on_event(defines.events.on_tick, nil)
    else
        -- Manually loop because we're removing items.
        local i = 1
        while i <= #global.WB_states do
            local state = global.WB_states[i]
            if state.stage <= #state.stages then
                tick(state)
                i = i + 1
            else
                table.remove(global.WB_states, i)
            end
        end
    end
end

function on_load()
    if global.WB_states and #global.WB_states > 0 then
        script.on_event(defines.events.on_tick, on_tick)
    end
end

script.on_load(on_load)