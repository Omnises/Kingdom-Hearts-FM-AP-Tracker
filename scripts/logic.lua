KEYBLADE_FOR_WORLD = {
    ["wonderland"] = "lady_luck",
    ["olympus_coliseum"] = "olympia",
    ["deep_jungle"] = "jungle_king",
    ["agrabah"] = "three_wishes",
    ["monstro"] = "wishing_star",
    ["atlantica"] = "crabclaw",
    ["halloween_town"] = "pumpkinhead",
    ["neverland"] = "fairy_harp",
    ["hollow_bastion"] = "divine_rose",
    ["end_of_the_world"] = "oblivion",
    ["destiny_islands"] = "oathkeeper",
    ["100_acre"] = "spellbinder",
    ["traverse_town"] = "lionheart"
}
WORLDS = {}
KEYBLADES = {}
for world, keyblade in pairs(KEYBLADE_FOR_WORLD) do
    table.insert(WORLDS, world)
    table.insert(KEYBLADES, keyblade)
end

MAGIC = {"fire", "blizzard", "thunder", "cure", "gravity", "stop", "aero"}

LOGIC_BEGINNER = 0
LOGIC_NORMAL = 1
LOGIC_PROUD = 2
LOGIC_MINIMAL = 3

-- settings helpers

function is_keyblade_locks()
    local lock_status = Tracker:FindObjectForCode("keyblade_locks").CurrentStage
    return lock_status == 1 -- 1 = locked, 0 = unlocked
end

function logic_difficulty_at_least(difficulty)
    local logic_difficulty_setting = Tracker:FindObjectForCode("logic_difficulty").CurrentStage
    return logic_difficulty_setting >= difficulty
end

function logic_difficulty_at_least_normal()
    return logic_difficulty_at_least(LOGIC_NORMAL)
end

function logic_difficulty_at_least_proud()
    return logic_difficulty_at_least(LOGIC_PROUD)
end

function logic_difficulty_at_least_minimal()
    return logic_difficulty_at_least(LOGIC_MINIMAL)
end

function is_stacking_worlds()
    local stacking_world_items_status = Tracker:FindObjectForCode("stacking_world_items").CurrentStage
    return stacking_world_items_status == 1
end

function is_halloween_town_bundled()
    local bundled_status = Tracker:FindObjectForCode("halloween_town_key_item_bundle").CurrentStage
    return bundled_status == 1
end

function is_cups_enabled()
    local cups_status = Tracker:FindObjectForCode("cups").CurrentStage
    return cups_status == 1 or cups_status == 2 -- 0 = off, 1 = on, 2 = hades
end

-- TODO: return value of setting instead when random accessories are fixed.
function is_random_accessory_visible()
    return false
end

-- optional rules, if not met then checks are accessible out of logic

function world_count()
    if logic_difficulty_at_least_minimal() then
        return #WORLDS
    end

    local count = 0
    for world, keyblade in pairs(KEYBLADE_FOR_WORLD) do
        if (
            has(world)
            or world == "traverse_town"
            or (world == "100_acre" and haw_access())
            or (world == "end_of_the_world" and eotw_access())
        ) then
            count = count + 0.5
            if not is_keyblade_locks() or has(keyblade) then
                count = count + 0.5
            end
        end
    end
    return count
end

function has_defenses()
    if logic_difficulty_at_least_minimal() then
        return true
    end

    return (
        has("cure", 2) and has("leaf_bracer") and has("dodge_roll")
        and (has("second_chance") or has("mp_rage") or has("aero", 2))
    )
end

--- world access

function access_chest_for(world_name)
    return not is_keyblade_locks() or has(KEYBLADE_FOR_WORLD[world_name])
end

function access_broken_chest_for(world_name)
    -- Used to show chests as out of logic for beginners if keyblade unlocking
    -- is broken for the location. Should always be optional.
    return logic_difficulty_at_least_normal() or access_chest_for(world_name)
end

function wl_after_footprints()
    if has("footprints") then
        return true
    end
    return is_stacking_worlds() and has("wonderland", 2)
end

function oc_after_entry_pass()
    if has("entry_pass") then
        return true
    end
    return is_stacking_worlds() and has("olympus_coliseum", 2)
end

function dj_after_slides()
    if has("slides") then
        return true
    end
    return is_stacking_worlds() and has("deep_jungle", 2)
end

function ht_after_forget_me_not()
    if has("forget_me_not") then
        return true
    end
    return is_stacking_worlds() and has("halloween_town", 2)
end

function ht_after_jack_in_the_box()
    if has("forget_me_not") and (has("jack_box") or is_halloween_town_bundled()) then
        return true
    end
    return is_stacking_worlds() and has("halloween_town", 2)
end

function at_after_crystal_trident()
    if has("trident") then
        return true
    end
    return is_stacking_worlds() and has("atlantica", 2)
end

function hb_after_theon_6()
    if has("theon_6") then
        return true
    end
    return is_stacking_worlds() and has("hollow_bastion", 2)
end

function haw_access()
    local haw_checks = Tracker:FindObjectForCode("100_acre_checks").CurrentStage
    return haw_checks == 1 and has("fire") -- 1 = 100 Acre Wood checks enabled
end

function eotw_access()
    local eotw_unlock_status = Tracker:FindObjectForCode("eotw_unlock").CurrentStage -- 0 = world item, 1 = lucky emblems
    local lucky_emblems_required = Tracker:FindObjectForCode("eotw_req").AcquiredCount

    if eotw_unlock_status == 0 and has("end_of_the_world") then
        return true
    elseif eotw_unlock_status == 1 and has("lucky_emblem", lucky_emblems_required) then
        return true
    end

    return false
end

function di_day_2_access()
    local materials_required = Tracker:FindObjectForCode("day_2_materials_req").AcquiredCount
    return has("destiny_islands") and has("raft_materials", materials_required)
end

--- item access

function has_all_cups()
    return has("phil_cup") and has("pegasus_cup") and has("hercules_cup")
end

function has_lv_magic(level)
    for _, spell in ipairs(MAGIC) do
        if not has(spell, level) then
            return false
        end
    end
    return true
end

function has_any_magic()
    for _, spell in ipairs(MAGIC) do
        if has(spell) then
            return true
        end
    end
    return false
end

function has_all_arts()
    return has("fire_arts") and has("blizzard_arts") and has("thunder_arts") and has("cure_arts") and has("gravity_arts") and has("stop_arts") and has("aero_arts")
end

function has_all_summons()
    return has("simba") and has("bambi") and has("genie") and has("dumbo") and has("mushu") and has("tinkerbell")
end

function has_emblems()
    return has("emblem_flame") and has("emblem_chest") and has("emblem_statue") and has("emblem_fountain")
end

function has_offensive_magic()
    if has("fire") or has("blizzard") then
        return true
    elseif logic_difficulty_at_least_proud() and (has("thunder") or has("gravity")) then
        return true
    elseif logic_difficulty_at_least_minimal() and has("stop") then
        return true
    end
    return false
end

function has_basic_tools()
    return (
        has("dodge_roll") and has("cure")
        and (has("combo_master") or has("strike_raid") or has("sonic_blade") or has("counterattack"))
        and (has("leaf_bracer") or has("second_chance") or has("guard"))
        and has_offensive_magic()
    )
end

function can_dumbo_skip()
    return has("dumbo") and has_any_magic()
end

function can_minimal_air_combo_jump()
   return has("combo_master") and has("high_jump", 3) and has("air_combo_plus", 2)
end