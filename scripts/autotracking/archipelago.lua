ScriptHost:LoadScript("scripts/autotracking/item_mapping.lua")
ScriptHost:LoadScript("scripts/autotracking/location_mapping.lua")
ScriptHost:LoadScript("scripts/autotracking/setting_mapping.lua")
ScriptHost:LoadScript("scripts/autotracking/tab_mapping.lua")

CUR_INDEX = -1
HINT_ID = ""

if IS_ENABLE_HIGHLIGHT then
    HIGHLIGHT_FOR_STATUS = {
        [0] = Highlight.Unspecified,
        [10] = Highlight.NoPriority,
        [20] = Highlight.Avoid,
        [30] = Highlight.Priority,
        [40] = Highlight.None,
        [100] = Highlight.Unspecified, -- Filler
        [101] = Highlight.Priority,    -- Progression
        [102] = Highlight.NoPriority,  -- Useful
        [103] = Highlight.Priority,    -- Prog + Useful
        [104] = Highlight.Avoid,       -- Trap
        [105] = Highlight.Priority,    -- Prog + Trap
        [106] = Highlight.NoPriority,  -- Useful + Trap
        [107] = Highlight.Priority,    -- Prog + Useful + Trap
    }
end

function onClear(slot_data)
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
        print(string.format("called onClear, slot_data:\n%s", dump_table(slot_data)))
    end
    CUR_INDEX = -1

    -- reset locations
    for location_id, location_array in pairs(LOCATION_MAPPING) do
        for _, location_name in ipairs(location_array) do
            if location_name then
                local obj = Tracker:FindObjectForCode(location_name)
                if obj then
                    if location_name:sub(1, 1) == "@" then
                        if is_level_up_location(location_id) then
                            obj.AvailableChestCount = 0
                        else
                            obj.AvailableChestCount = obj.ChestCount
                        end
                        if IS_ENABLE_HIGHLIGHT then
                            obj.Highlight = Highlight.None
                        end
                    else
                        obj.Active = false
                    end
                elseif AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
                    print(string.format("onClear: could not find object for code %s", location_name))
                end
            end
        end
    end

    -- reset items
    for _, item_array in pairs(ITEM_MAPPING) do
        for _, item_pair in ipairs(item_array) do
            local item_name = item_pair[1]
            local item_type = item_pair[2]
            local obj = Tracker:FindObjectForCode(item_name)
            if obj then
                if item_type == "toggle" then
                    obj.Active = false
                elseif item_type == "progressive" then
                    obj.CurrentStage = 0
                    obj.Active = false
                elseif item_type == "consumable" then
                    obj.AcquiredCount = 0
                elseif AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
                    print(string.format("onClear: unknown item type %s for code %s", item_type, item_name))
                end
            elseif AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
                print(string.format("onClear: could not find object for code %s", item_name))
            end
        end
    end

    -- update settings with slot data
    IGNORE_SLOT_2_LEVELS = true
    local puppy_value = 3
    local randomize_puppies = true
    for key, value in pairs(slot_data) do
        if key == "remote_items" and value == "full" then
            IGNORE_SLOT_2_LEVELS = false
        elseif key == "level_checks" then
            MAX_LEVEL_WITH_CHECK = value + 1
        elseif key == "remote_location_ids" then
            for _, location_id in ipairs(value) do
                if is_slot_2_level(location_id) then
                    local location_name = LOCATION_MAPPING[location_id][1]
                    if location_name then
                        local obj = Tracker:FindObjectForCode(location_name)
                        if obj then
                            obj.AvailableChestCount = obj.AvailableChestCount + 1
                        end
                    end
                end
            end
        elseif key == "required_lucky_emblems_eotw" then
            Tracker:FindObjectForCode("eotw_req").AcquiredCount = value
        elseif key == "required_lucky_emblems_door" then
            Tracker:FindObjectForCode("door_req").AcquiredCount = value
        elseif key == "required_postcards" then
            Tracker:FindObjectForCode("postcards_req").AcquiredCount = value
        elseif key == "required_puppies" then
            Tracker:FindObjectForCode("puppies_req").AcquiredCount = value
        elseif key == "day_2_materials" then
            Tracker:FindObjectForCode("day_2_materials_req").AcquiredCount = value
        elseif key == "homecoming_materials" then
            Tracker:FindObjectForCode("homecoming_materials_req").AcquiredCount = value
        elseif key == "materials_in_pool" then
            Tracker:FindObjectForCode("raft_materials").MaxCount = value
        elseif key == "orichalcum_in_pool" then
            Tracker:FindObjectForCode("orichalcum").MaxCount = value
        elseif key == "mythril_in_pool" then
            Tracker:FindObjectForCode("mythril").MaxCount = value
        elseif key == "randomize_puppies" then
            randomize_puppies = value
        elseif key == "puppy_value" then
            puppy_value = value
        elseif key and SLOT_CODES[key] then
            print(string.format("INFO: updating setting for slot data with key %s", key))
            Tracker:FindObjectForCode(SLOT_CODES[key].code).CurrentStage = SLOT_CODES[key].mapping[value]
        end
    end

    -- Set the correct puppy value from slot data.
    if not randomize_puppies then
        puppy_value = 3
    end
    puppy_obj = Tracker:FindObjectForCode("puppy")
    puppy_obj.Increment = puppy_value
    puppy_obj.Decrement = puppy_value

    -- Set the correct number of available level location checks based on slot data.
    for location_id = 2658002,(2658000 + MAX_LEVEL_WITH_CHECK) do
        local location_name = LOCATION_MAPPING[location_id][1]
        if location_name then
            local obj = Tracker:FindObjectForCode(location_name)
            if obj then
                obj.AvailableChestCount = obj.AvailableChestCount + 1
            end
        end
    end

    -- Check if slot data is from beta version of AP world.
    local beta_logic_stage = 0 -- v0.10.0 or older
    if slot_data["world_version"] ~= nil then
        local world_version = slot_data["world_version"]
        if world_version[1] == 1 and world_version[2] >= 2 then
            beta_logic_stage = 3 -- v1.2.0 or newer
        elseif world_version[1] == 1 and world_version[2] == 1 then
            beta_logic_stage = 2 -- v1.1.0
        end
    elseif slot_data["accessory_augments"] ~= nil then
        beta_logic_stage = 1 -- v0.11.0
    end
    -- Clear beta only settings if not present in slot data.
    if beta_logic_stage < 3 then
        -- Following settings only available in v1.2.0+
        Tracker:FindObjectForCode("evidence_bundle").CurrentStage = 0
        Tracker:FindObjectForCode("slides_bundle").CurrentStage = 0
        Tracker:FindObjectForCode("100_acre_wood_minigames").CurrentStage = 0
    end
    if beta_logic_stage < 1 then
        -- Following setting only available in v0.11.0+
        Tracker:FindObjectForCode("accessory_augments").CurrentStage = 0
    end
    -- Default auto map tab tracking to "on" if the feature is available (requires v1.1.0+).
    if beta_logic_stage >= 2 then
        Tracker:FindObjectForCode("auto_tab_map").CurrentStage = 1
    end
    local beta_logic_obj = Tracker:FindObjectForCode("beta_logic")
    if beta_logic_obj then
        beta_logic_obj.CurrentStage = beta_logic_stage
    end

    if IS_ENABLE_HIGHLIGHT and Archipelago.PlayerNumber ~= -1 then
        HINT_ID = "_read_hints_" .. Archipelago.TeamNumber .. "_" .. Archipelago.PlayerNumber
        CLIENT_STATUS_ID = "_read_client_status_" .. Archipelago.TeamNumber .. "_" .. Archipelago.PlayerNumber
        Archipelago:Get({HINT_ID, CLIENT_STATUS_ID})
        Archipelago:SetNotify({HINT_ID, CLIENT_STATUS_ID})
    end
end

-- called when an item gets collected
function onItem(index, item_id, item_name, player_number)
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
        print(string.format("called onItem: %s, %s, %s, %s, %s", index, item_id, item_name, player_number, CUR_INDEX))
    end
    if not AUTOTRACKER_ENABLE_ITEM_TRACKING then
        return
    end
    if index <= CUR_INDEX then
        return
    end
    CUR_INDEX = index;
    local item_array = ITEM_MAPPING[item_id]
    if not item_array then
        return
    end
    for _, item_pair in ipairs(item_array) do
        local item_name = item_pair[1]
        local item_type = item_pair[2]
        local obj = Tracker:FindObjectForCode(item_name)
        if obj then
            if item_type == "toggle" then
                obj.Active = true
            elseif item_type == "progressive" then
                if obj.Active then
                    obj.CurrentStage = obj.CurrentStage + 1
                else
                    obj.Active = true
                end
            elseif item_type == "consumable" then
                obj.AcquiredCount = obj.AcquiredCount + obj.Increment
            elseif AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
                print(string.format("onItem: unknown item type %s for code %s", item_type, item_name))
            end
        elseif AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
            print(string.format("onItem: could not find object for code %s", item_name))
        end
    end
end

-- called when a location gets cleared
function onLocation(location_id, location_name)
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
        print(string.format("called onLocation: %s, %s", location_id, location_name))
    end
    if not AUTOTRACKER_ENABLE_LOCATION_TRACKING then
        return
    end
    if IGNORE_SLOT_2_LEVELS and is_slot_2_level(location_id) then
        return
    end
    local location_array = LOCATION_MAPPING[location_id]
    if not location_array and AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
        print(string.format("onLocation: could not find location mapping for id %s", location_id))
    end

    for _, location in ipairs(location_array) do
        local obj = Tracker:FindObjectForCode(location)
        if obj then
            if location_array[1]:sub(1, 1) == "@" then
                obj.AvailableChestCount = obj.AvailableChestCount - 1
            else
                obj.Active = true
            end
        elseif AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
            print(string.format("onLocation: could not find object for id %s code %s", location_id, location))
        end
    end
end

function updateMap(world_id, room_id)
    local tabs = TAB_MAPPING[tostring(world_id)]
    if tabs then
        local tab = tabs[1]
        if world_id == 8 and room_id >= 8 and room_id ~= 18 and room_id ~= 19 then
            -- Room is in Agrabah - Cave of Wonders.
            tab = tabs[2]
        end
        print(string.format('updateMap: activating tab "%s" for world_id %d and room_id %d', tab, world_id, room_id))
        Tracker:UiHint("ActivateTab", tab)
    end
end

function onBounce(json)
    if Tracker:FindObjectForCode("auto_tab_map").CurrentStage == 1 then
        if json ~= nil and json["data"] ~= nil then
            local data = json["data"]
            updateMap(data["world"], data["room"])
        end
    end
end

function updateHints(hints)
    for _, hint in ipairs(hints) do
        if hint.finding_player == Archipelago.PlayerNumber then
            local v = LOCATION_MAPPING[hint.location]
            if v[1] then
                local location_name = v[1]
                local obj = Tracker:FindObjectForCode(location_name)
                if obj then
                    obj.Highlight = HIGHLIGHT_FOR_STATUS[hint.status]
                elseif AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
                    print(string.format("updateHints: could not find object for code: %s", location_name))
                end
            elseif AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
                print(string.format("updateHints: could not find location for ID: %d", hint.location))
            end
        end
    end
end

function updateStatus(status)
    if status == Archipelago.ClientStatus.GOAL then
        print("updateStatus: goal achieved")
        onLocation(2659999, "Goal")
    end
end

function onDataStorageChanged(key, value, prev_value)
    if key == HINT_ID and IS_ENABLE_HIGHLIGHT then
        updateHints(value)
    elseif key == CLIENT_STATUS_ID then
        updateStatus(value)
    end
end

function onDataStorageRetrieved(key, value)
    if key == HINT_ID and IS_ENABLE_HIGHLIGHT then
        updateHints(value)
    elseif key == CLIENT_STATUS_ID then
        updateStatus(value)
    end
end

Archipelago:AddClearHandler("clear handler", onClear)
if AUTOTRACKER_ENABLE_ITEM_TRACKING then
    Archipelago:AddItemHandler("item handler", onItem)
end
if AUTOTRACKER_ENABLE_LOCATION_TRACKING then
    Archipelago:AddLocationHandler("location handler", onLocation)
end
Archipelago:AddBouncedHandler("bounce handler", onBounce)
Archipelago:AddSetReplyHandler("data storage notify handler", onDataStorageChanged)
Archipelago:AddRetrievedHandler("data storage get handler", onDataStorageRetrieved)