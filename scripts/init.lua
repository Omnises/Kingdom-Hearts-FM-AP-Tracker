-- entry point for all lua code of the pack
-- more info on the lua API: https://github.com/black-sliver/PopTracker/blob/master/doc/PACKS.md#lua-interface
ENABLE_DEBUG_LOG = true
-- get current variant
local variant = Tracker.ActiveVariantUID
-- check variant info
IS_ITEMS_ONLY = variant:find("itemsonly")
IS_HORIZONTAL = variant:find("horizontal")

print("Loaded variant: ", variant)
if ENABLE_DEBUG_LOG then
    print("Debug logging is enabled!")
end

-- check for supported PopTracker features
IS_ENABLE_HIGHLIGHT = Highlight ~= nil

-- Utility Script for helper functions etc.
ScriptHost:LoadScript("scripts/utils.lua")

-- Logic
ScriptHost:LoadScript("scripts/logic.lua")
ScriptHost:LoadScript("scripts/advanced_logic.lua")

-- Items
ScriptHost:LoadScript("scripts/items.lua")

if not IS_ITEMS_ONLY then -- <--- use variant info to optimize loading
    -- Maps
    Tracker:AddMaps("maps/maps.json")    
    -- Locations
    ScriptHost:LoadScript("scripts/locations.lua")
end

-- Layout
Tracker:AddLayouts("layouts/broadcast.json")
Tracker:AddLayouts("layouts/tracker.json")
Tracker:AddLayouts("layouts/settings.json")
Tracker:AddLayouts("layouts/items.json")
Tracker:AddLayouts("layouts/tabs.json")

-- AutoTracking for Poptracker
if PopVersion and PopVersion >= "0.18.0" then
    ScriptHost:LoadScript("scripts/autotracking.lua")
end

-- Code watches for settings to show/hide portions of the item tracker layout
ScriptHost:AddWatchForCode("keyblade_locks", "keyblade_locks", toggle_items)
ScriptHost:AddWatchForCode("stacking_world_items", "stacking_world_items", toggle_items)
ScriptHost:AddWatchForCode("halloween_town_key_item_bundle", "halloween_town_key_item_bundle", toggle_items)
ScriptHost:AddWatchForCode("destiny_islands_checks", "destiny_islands_checks", toggle_items)
ScriptHost:AddWatchForCode("100_acre_checks", "100_acre_checks", toggle_items)
ScriptHost:AddWatchForCode("atlantica_checks", "atlantica_checks", toggle_items)
ScriptHost:AddWatchForCode("cups", "cups", toggle_items)
ScriptHost:AddWatchForCode("superbosses", "superbosses", toggle_items)
ScriptHost:AddWatchForCode("eotw_unlock", "eotw_unlock", toggle_items)
ScriptHost:AddWatchForCode("goal", "goal", toggle_items)
ScriptHost:AddWatchForCode("beta_logic", "beta_logic", toggle_items)
ScriptHost:AddWatchForCode("accessory_augments", "accessory_augments", toggle_items)
ScriptHost:AddWatchForCode("evidence_bundle", "evidence_bundle", toggle_items)
ScriptHost:AddWatchForCode("slides_bundle", "slides_bundle", toggle_items)

ScriptHost:AddOnFrameHandler("tracker_layout_update", tracker_layout_update)