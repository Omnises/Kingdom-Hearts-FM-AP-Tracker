function has(item, amount)
	local count = Tracker:ProviderCountForCode(item)
	amount = tonumber(amount)
	if not amount then
		return count > 0
	else
		return count >= amount
	end
end

-- from https://stackoverflow.com/questions/9168058/how-to-dump-a-table-to-console
-- dumps a table in a readable string
function dump_table(o, depth)
    if depth == nil then
        depth = 0
    end
    if type(o) == 'table' then
        local tabs = ('\t'):rep(depth)
        local tabs2 = ('\t'):rep(depth + 1)
        local s = '{\n'
        for k, v in pairs(o) do
            if type(k) ~= 'number' then
                k = '"' .. k .. '"'
            end
            s = s .. tabs2 .. '[' .. k .. '] = ' .. dump_table(v, depth + 1) .. ',\n'
        end
        return s .. tabs .. '}'
    else
        return tostring(o)
    end
end

function is_level_up_location(location_id)
    return location_id >= 2658002 and location_id <= 2658200
end

function is_slot_2_level(location_id)
    return location_id >= 2658102 and location_id <= 2658200
end

update_layout = true

function toggle_items()
    update_layout = true
end

function get_pad_size(base_size, conditions)
    local size = base_size
    for _, condition in ipairs(conditions) do
        if not condition then
            size = size + 1
        end
    end
    return size
end

function layout_update_worlds(show_destiny_islands, show_atlantica, show_eotw, show_100_acre_world)
    if show_destiny_islands then
        Tracker:AddLayouts("layouts/worlds/destiny_islands_show.json")
    else
        Tracker:AddLayouts("layouts/worlds/destiny_islands_hide.json")
    end
    if show_atlantica then
        Tracker:AddLayouts("layouts/worlds/atlantica_show.json")
    else
        Tracker:AddLayouts("layouts/worlds/atlantica_hide.json")
    end
    if show_eotw then
        Tracker:AddLayouts("layouts/worlds/eotw_show.json")
    else
        Tracker:AddLayouts("layouts/worlds/eotw_hide.json")
    end
    if show_100_acre_world then
        Tracker:AddLayouts("layouts/worlds/100_acre_wood_show.json")
    else
        Tracker:AddLayouts("layouts/worlds/100_acre_wood_hide.json")
    end

    if IS_HORIZONTAL then
        local max_icons = 3
        if show_destiny_islands or show_atlantica or (show_eotw and show_100_acre_world) then
            max_icons = 4
        end
        local row_1_pad_size = get_pad_size(0, {show_destiny_islands or max_icons == 3})
        Tracker:AddLayouts("layouts/padding/worlds_row_1_pad_" .. row_1_pad_size .. ".json")
        local row_2_pad_size = get_pad_size(0, {show_atlantica or max_icons == 3})
        Tracker:AddLayouts("layouts/padding/worlds_row_2_pad_" .. row_2_pad_size .. ".json")
        local row_3_pad_size = get_pad_size(-1, {show_eotw, show_100_acre_world, max_icons == 3})
        Tracker:AddLayouts("layouts/padding/worlds_row_3_pad_" .. row_3_pad_size .. ".json")
    else
        local row_1_pad_size = get_pad_size(0, {show_destiny_islands})
        Tracker:AddLayouts("layouts/padding/worlds_row_1_pad_" .. row_1_pad_size .. ".json")
        local row_2_pad_size = get_pad_size(2, {show_atlantica, show_eotw, show_100_acre_world})
        Tracker:AddLayouts("layouts/padding/worlds_row_2_pad_" .. row_2_pad_size .. ".json")
    end
end

function layout_update_world_keys(show_world_keys, show_jack_box, show_atlantica, show_cups, show_final_door_key, show_evidence_bundled, show_slides_bundled)
    local world_keys_hidden = false
    if show_world_keys then
        Tracker:AddLayouts("layouts/world_keys/group_show_all.json")
        if show_jack_box then
            Tracker:AddLayouts("layouts/world_keys/jack_box_show.json")
        else
            Tracker:AddLayouts("layouts/world_keys/jack_box_hide.json")
        end
        if show_atlantica then
            Tracker:AddLayouts("layouts/world_keys/trident_show.json")
        else
            Tracker:AddLayouts("layouts/world_keys/trident_hide.json")
        end
        if show_evidence_bundled then
            Tracker:AddLayouts("layouts/world_keys/evidence_bundled.json")
        else
            Tracker:AddLayouts("layouts/world_keys/evidence_not_bundled.json")
        end
        if show_slides_bundled then
            Tracker:AddLayouts("layouts/world_keys/slides_bundled.json")
        else
            Tracker:AddLayouts("layouts/world_keys/slides_not_bundled.json")
        end
    end
    if show_cups or show_final_door_key then
        if not show_world_keys then
            Tracker:AddLayouts("layouts/world_keys/group_show_cups_door.json")
        end
        if show_cups then
            Tracker:AddLayouts("layouts/world_keys/cups_show.json")
        else
            Tracker:AddLayouts("layouts/world_keys/cups_hide.json")
        end
        if show_final_door_key then
            Tracker:AddLayouts("layouts/world_keys/final_door_key_show.json")
        else
            Tracker:AddLayouts("layouts/world_keys/final_door_key_hide.json")
        end
    elseif show_world_keys then
        Tracker:AddLayouts("layouts/world_keys/cups_hide.json")
        Tracker:AddLayouts("layouts/world_keys/final_door_key_hide.json")
    else
        world_keys_hidden = true
        Tracker:AddLayouts("layouts/world_keys/group_hide.json")
    end

    if not world_keys_hidden then
        if IS_HORIZONTAL then
            local max_icons = 3
            if (show_jack_box and show_atlantica) or (show_cups and show_final_door_key) then
                max_icons = 4
            end
            local row_1_pad_size = get_pad_size(0, {max_icons == 3})
            Tracker:AddLayouts("layouts/padding/world_keys_row_1_pad_" .. row_1_pad_size .. ".json")
            local row_2_pad_size = get_pad_size(-1, {show_jack_box, show_atlantica, max_icons == 3})
            Tracker:AddLayouts("layouts/padding/world_keys_row_2_pad_" .. row_2_pad_size .. ".json")
            local row_cups_door_pad_size = 0
            if show_world_keys then
                row_cups_door_pad_size = get_pad_size(-1, {show_cups, show_cups, show_cups, show_final_door_key, max_icons == 3})
            elseif not show_cups then
                row_cups_door_pad_size = 1
            end
            Tracker:AddLayouts("layouts/padding/world_keys_row_cups_door_pad_" .. row_cups_door_pad_size .. ".json")
        else
            local row_1_pad_size = get_pad_size(0, {show_jack_box, show_atlantica})
            Tracker:AddLayouts("layouts/padding/world_keys_row_1_pad_" .. row_1_pad_size .. ".json")
            local row_cups_door_pad_size = get_pad_size(3, {show_cups, show_cups, show_cups, show_final_door_key})
            Tracker:AddLayouts("layouts/padding/world_keys_row_cups_door_pad_" .. row_cups_door_pad_size .. ".json")
        end
    end
end

function layout_update_keyblades(show_keyblades, show_destiny_islands, show_100_acre, show_atlantica)
    if show_keyblades then
        Tracker:AddLayouts("layouts/keyblades/group_show.json")
        if show_destiny_islands then
            Tracker:AddLayouts("layouts/keyblades/oathkeeper_show.json")
        else
            Tracker:AddLayouts("layouts/keyblades/oathkeeper_hide.json")
        end
        if show_100_acre then
            Tracker:AddLayouts("layouts/keyblades/spellbinder_show.json")
        else
            Tracker:AddLayouts("layouts/keyblades/spellbinder_hide.json")
        end
        if show_atlantica then
            Tracker:AddLayouts("layouts/keyblades/crabclaw_show.json")
        else
            Tracker:AddLayouts("layouts/keyblades/crabclaw_hide.json")
        end

        if IS_HORIZONTAL then
            local pad_size = get_pad_size(2, {show_destiny_islands, show_100_acre, show_atlantica})
            Tracker:AddLayouts("layouts/padding/keyblades_row_3_pad_" .. pad_size .. ".json")
        else
            local row_1_pad_size = get_pad_size(0, {show_destiny_islands, show_100_acre})
            Tracker:AddLayouts("layouts/padding/keyblades_row_1_pad_" .. row_1_pad_size .. ".json")
            local row_2_pad_size = get_pad_size(1, {show_atlantica})
            Tracker:AddLayouts("layouts/padding/keyblades_row_2_pad_" .. row_2_pad_size .. ".json")
        end
    else
        Tracker:AddLayouts("layouts/keyblades/group_hide.json")
    end
end

function layout_update_magic_trinities(show_accessory_augments)
    if show_accessory_augments then
        Tracker:AddLayouts("layouts/magic_trinities/augment_show.json")
    else
        Tracker:AddLayouts("layouts/magic_trinities/augment_hide.json")
    end
end

function layout_update_abilities(show_accessory_augments)
    if show_accessory_augments then
        Tracker:AddLayouts("layouts/abilities/augment_show.json")
    else
        Tracker:AddLayouts("layouts/abilities/augment_hide.json")
    end
end

function layout_update_collectibles(show_lucky_emblems, show_destiny_islands, show_100_acre, show_empty_bottle, show_summon_gems)
    if show_lucky_emblems then
        Tracker:AddLayouts("layouts/collectibles/lucky_emblems_show.json")
    else
        Tracker:AddLayouts("layouts/collectibles/lucky_emblems_hide.json")
    end
    if show_destiny_islands then
        Tracker:AddLayouts("layouts/collectibles/raft_materials_show.json")
    else
        Tracker:AddLayouts("layouts/collectibles/raft_materials_hide.json")
    end
    if show_100_acre then
        Tracker:AddLayouts("layouts/collectibles/torn_pages_show.json")
    else
        Tracker:AddLayouts("layouts/collectibles/torn_pages_hide.json")
    end
    if show_empty_bottle then
        Tracker:AddLayouts("layouts/collectibles/empty_bottle_show.json")
    else
        Tracker:AddLayouts("layouts/collectibles/empty_bottle_hide.json")
    end
    if show_summon_gems then
        Tracker:AddLayouts("layouts/collectibles/summon_gems_show.json")
    else
        Tracker:AddLayouts("layouts/collectibles/summon_gems_hide.json")
    end

    if IS_HORIZONTAL then
        local max_icons = 4
        if show_100_acre and show_empty_bottle and show_summon_gems then
            max_icons = 5
        end
        local row_1_pad_size = get_pad_size(0, {show_lucky_emblems, show_destiny_islands, max_icons == 4})
        Tracker:AddLayouts("layouts/padding/collectibles_row_1_pad_" .. row_1_pad_size .. ".json")
        local row_2_pad_size = get_pad_size(0, {max_icons == 4})
        Tracker:AddLayouts("layouts/padding/collectibles_row_2_pad_" .. row_2_pad_size .. ".json")
        local row_3_pad_size = get_pad_size(-1, {show_100_acre, show_empty_bottle, show_summon_gems, max_icons == 4})
        Tracker:AddLayouts("layouts/padding/collectibles_row_3_pad_" .. row_3_pad_size .. ".json")
    else
        local row_1_pad_size = get_pad_size(0, {show_lucky_emblems, show_destiny_islands, show_100_acre})
        Tracker:AddLayouts("layouts/padding/collectibles_row_1_pad_" .. row_1_pad_size .. ".json")
        local row_2_pad_size = get_pad_size(1, {show_empty_bottle, show_summon_gems})
        Tracker:AddLayouts("layouts/padding/collectibles_row_2_pad_" .. row_2_pad_size .. ".json")
    end
end

function tracker_layout_update()
    if update_layout then
        local show_keyblades = Tracker:FindObjectForCode("keyblade_locks").CurrentStage == 1
        local show_world_keys = Tracker:FindObjectForCode("stacking_world_items").CurrentStage == 0
        local show_jack_box = Tracker:FindObjectForCode("halloween_town_key_item_bundle").CurrentStage == 0
        local show_destiny_islands = Tracker:FindObjectForCode("destiny_islands_checks").CurrentStage == 1
        local show_100_acre = Tracker:FindObjectForCode("100_acre_checks").CurrentStage == 1
        local show_atlantica = Tracker:FindObjectForCode("atlantica_checks").CurrentStage == 1
        local show_eotw = Tracker:FindObjectForCode("eotw_unlock").CurrentStage == 0
        local goal_status = Tracker:FindObjectForCode("goal").CurrentStage
        local show_cups = Tracker:FindObjectForCode("cups").CurrentStage ~= 0 or Tracker:FindObjectForCode("superbosses").CurrentStage == 1 or goal_status == 0
        local show_lucky_emblems = goal_status == 3 or not show_eotw
        local show_final_door_key = goal_status ~= 3
        local beta_logic_stage = Tracker:FindObjectForCode("beta_logic").CurrentStage
        local show_accessory_augments = beta_logic_stage >= 1 and Tracker:FindObjectForCode("accessory_augments").CurrentStage == 1
        local show_summon_gems = beta_logic_stage >= 3
        local show_empty_bottle = beta_logic_stage >= 3 and show_destiny_islands
        local show_evidence_bundled = beta_logic_stage < 3 or Tracker:FindObjectForCode("evidence_bundle").CurrentStage == 1
        local show_slides_bundled = beta_logic_stage < 3 or Tracker:FindObjectForCode("slides_bundle").CurrentStage == 1
        local show_100_acre_world = beta_logic_stage >= 3 and show_100_acre

        layout_update_worlds(show_destiny_islands, show_atlantica, show_eotw, show_100_acre_world)
        layout_update_world_keys(show_world_keys, show_jack_box, show_atlantica, show_cups, show_final_door_key, show_evidence_bundled, show_slides_bundled)
        layout_update_keyblades(show_keyblades, show_destiny_islands, show_100_acre, show_atlantica)
        layout_update_magic_trinities(show_accessory_augments)
        layout_update_abilities(show_accessory_augments)
        layout_update_collectibles(show_lucky_emblems, show_destiny_islands, show_100_acre, show_empty_bottle, show_summon_gems)

        update_layout = false
    end
end