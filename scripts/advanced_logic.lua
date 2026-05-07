-- Traverse Town 1st District Blue Trinity Balcony Chest
function tt_balcony_access()
   if has("blue_trinity") and has("glide") then
      return AccessibilityLevel.Normal
   elseif logic_difficulty_at_least_proud() and has("glide") then
      return AccessibilityLevel.Normal
   elseif has("blue_trinity") or has("glide") then
      return AccessibilityLevel.SequenceBreak
   end

   return AccessibilityLevel.None
end

-- Traverse Town Mystical House Yellow Trinity Chest
function tt_mystical_house_trinity_chest_access()
   if has("yellow_trinity") then
      return AccessibilityLevel.Normal
   elseif logic_difficulty_at_least_normal() and has("high_jump", 2) then
      return AccessibilityLevel.Normal
   elseif logic_difficulty_at_least_proud() and has("high_jump") then
      return AccessibilityLevel.Normal
   elseif has("high_jump") then
      return AccessibilityLevel.SequenceBreak
   end

   return AccessibilityLevel.None
end

-- Traverse Town Mystical House Glide Chest
function tt_mystical_house_glide_access()
   if has("glide") then
      return AccessibilityLevel.Normal
   elseif logic_difficulty_at_least_proud() then
      if has("high_jump", 3) then
         return AccessibilityLevel.Normal
      elseif (
         has("combo_master")
         and (
            has("high_jump", 2) 
            or (has("high_jump") and has("air_combo_plus", 2))
         )
      ) then
         return AccessibilityLevel.Normal
      end
   elseif logic_difficulty_at_least_minimal() then
      if has("mermaid_kick") then
         return AccessibilityLevel.Normal
      elseif (
         has("combo_master")
         and (has("high_jump") or has("air_combo_plus", 2))
      ) then
         return AccessibilityLevel.Normal
      end
   else
      if has("high_jump", 3) or has("mermaid_kick") then
         return AccessibilityLevel.SequenceBreak
      elseif (
         has("combo_master")
         and (has("high_jump") or has("air_combo_plus", 2))
      ) then
         return AccessibilityLevel.SequenceBreak
      end
   end

   return AccessibilityLevel.None
end

-- Traverse Town Item Workshop Synth 15 Items
function tt_can_synth_15()
   local orichalcum_count = Tracker:FindObjectForCode("orichalcum").AcquiredCount
   local mythril_count = Tracker:FindObjectForCode("mythril").AcquiredCount

   return math.min(orichalcum_count, 9) + math.min(mythril_count, 9) >= 15
end

-- Wonderland Queen's Castle Hedge Chests
function wl_queens_castle_hedge_access()
   if wl_after_footprints() or has("high_jump") then
      return AccessibilityLevel.Normal
   elseif logic_difficulty_at_least_normal() and has("glide") then
      return AccessibilityLevel.Normal
   elseif has("glide") then
      return AccessibilityLevel.SequenceBreak
   end

   return AccessibilityLevel.None
end

-- Wonderland Lotus Forest Glide Chest
function wl_lotus_forest_southwest_access()
   if has("glide") then
      return AccessibilityLevel.Normal
   elseif (
      logic_difficulty_at_least_proud()
      and has("footprints") and (has("high_jump") or can_dumbo_skip())
   ) then
      return AccessibilityLevel.Normal
   elseif logic_difficulty_at_least_minimal() and can_minimal_air_combo_jump() then
      return AccessibilityLevel.Normal
   elseif has("footprints") and (has("high_jump") or can_dumbo_skip()) then
      return AccessibilityLevel.SequenceBreak
   elseif can_minimal_air_combo_jump() then
      return AccessibilityLevel.SequenceBreak
   end

   return AccessibilityLevel.None
end

-- Wonderland Lotus Forest Corner Chest
function wl_jump_and_glide_access()
   if has("high_jump") and has("glide") then
      return AccessibilityLevel.Normal
   elseif logic_difficulty_at_least_normal() and (has("high_jump") or has("glide")) then
      return AccessibilityLevel.Normal
   elseif logic_difficulty_at_least_proud() then
      return AccessibilityLevel.Normal
   end

   return AccessibilityLevel.SequenceBreak
end

-- Wonderland Tea Party Garden Above Lotus Forest Entrance 2nd Chest
-- Wonderland Tea Party Garden Above Lotus Forest Entrance 1st Chest
function wl_tea_party_entrance_hedge_access()
   if has("glide") then
      return AccessibilityLevel.Normal
   elseif wl_after_footprints() then
      if logic_difficulty_at_least_normal() and has("high_jump", 2) then
         return AccessibilityLevel.Normal
      elseif logic_difficulty_at_least_proud() and (has("high_jump", 1) or can_dumbo_skip()) then
         return AccessibilityLevel.Normal
      end
   elseif logic_difficulty_at_least_minimal() and can_minimal_air_combo_jump() then
      return AccessibilityLevel.Normal
   elseif wl_after_footprints() and (has("high_jump", 1) or can_dumbo_skip()) then
      return AccessibilityLevel.SequenceBreak
   elseif can_minimal_air_combo_jump() then
      return AccessibilityLevel.SequenceBreak
   end

   return AccessibilityLevel.None
end

-- Wonderland Tea Party Garden Bear and Clock Puzzle Chest
-- Wonderland Tea Party Garden Chairs
function wl_tea_party_access()
   if wl_after_footprints() or has("glide") then
      return AccessibilityLevel.Normal
   elseif logic_difficulty_at_least_minimal() and can_minimal_air_combo_jump() then
      return AccessibilityLevel.Normal
   elseif can_minimal_air_combo_jump() then
      return AccessibilityLevel.SequenceBreak
   end

   return AccessibilityLevel.None
end

-- Wonderland Tea Party Garden Across From Bizarre Room Entrance Chest
function wl_tea_party_high_hedge_access()
   if has("glide") then
      return AccessibilityLevel.Normal
   elseif wl_after_footprints() then
      if logic_difficulty_at_least_normal() and has("high_jump", 3) then
         return AccessibilityLevel.Normal
      elseif (
         logic_difficulty_at_least_proud()
         and (has("high_jump", 2) or (has("high_jump", 1) and has("combo_master")))
      ) then
         return AccessibilityLevel.Normal
      end
   elseif logic_difficulty_at_least_minimal() and can_minimal_air_combo_jump() then
      return AccessibilityLevel.Normal
   elseif (
      wl_after_footprints()
      and (has("high_jump", 2) or (has("high_jump", 1) and has("combo_master")))
   ) then
      return AccessibilityLevel.SequenceBreak
   elseif can_minimal_air_combo_jump() then
      return AccessibilityLevel.SequenceBreak
   end

   return AccessibilityLevel.None
end

-- Deep Jungle Hippo's Lagoon Right Chest
function dj_jump_and_glide_access()
   if has("high_jump") and has("glide") then
      return AccessibilityLevel.Normal
   elseif logic_difficulty_at_least_normal() and (has("high_jump") or has("glide")) then
      return AccessibilityLevel.Normal
   elseif logic_difficulty_at_least_proud() then
      return AccessibilityLevel.Normal
   end

   return AccessibilityLevel.SequenceBreak
end

-- Agrabah Main Street High Above Palace Gates Entrance Chest
-- Agrabah Palace Gates Low Chest
function ag_high_jump_access()
   if has("high_jump") then
      return AccessibilityLevel.Normal
   elseif logic_difficulty_at_least_normal() and has("glide") then
      return AccessibilityLevel.Normal
   elseif logic_difficulty_at_least_proud() and can_dumbo_skip() then
      return AccessibilityLevel.Normal
   elseif has("glide") or can_dumbo_skip() then
      return AccessibilityLevel.SequenceBreak
   end

   return AccessibilityLevel.None
end

-- Agrabah Palace Gates High Close to Palace Chest
function ag_palace_access()
   if has("high_jump") and has("glide") then
      return AccessibilityLevel.Normal
   elseif logic_difficulty_at_least_normal() and has("high_jump", 3) then
      return AccessibilityLevel.Normal
   elseif (
      logic_difficulty_at_least_proud()
      and (has("high_jump", 2) or has("glide") or (has("high_jump") and has("combo_master")))
   ) then
      return AccessibilityLevel.Normal
   elseif logic_difficulty_at_least_minimal() and has("combo_master") then
      return AccessibilityLevel.Normal
   elseif has("high_jump", 2) or has("glide") or has("combo_master") then
      return AccessibilityLevel.SequenceBreak
   end

   return AccessibilityLevel.None
end

-- Agrabah Cave of Wonders Entrance Tall Tower Chest
function ag_cow_entrance_access()
   if has("glide") then
      return AccessibilityLevel.Normal
   elseif logic_difficulty_at_least_normal() and has("high_jump", 2) then
      return AccessibilityLevel.Normal
   elseif (
      logic_difficulty_at_least_proud()
      and (has("high_jump") or has("combo_master") or can_dumbo_skip())
   ) then
      return AccessibilityLevel.Normal
   elseif logic_difficulty_at_least_minimal() then
      return AccessibilityLevel.Normal
   end

   return AccessibilityLevel.SequenceBreak
end

-- Agrabah Cave of Wonders Hidden Room Right Chest
-- Agrabah Cave of Wonders Hidden Room Left Chest
function ag_cow_hidden_room_access()
   if has("yellow_trinity") then
      return AccessibilityLevel.Normal
   elseif logic_difficulty_at_least_normal() and has("high_jump") then
      return AccessibilityLevel.Normal
   elseif logic_difficulty_at_least_proud() and has("glide") then
      return AccessibilityLevel.Normal
   elseif has("high_jump") or has("glide") then
      return AccessibilityLevel.SequenceBreak
   end

   return AccessibilityLevel.None
end

function has_minimal_kurt_zisa_magic()
   if has("blizzard") or has("fire") or has("thunder") or has("gravity") then
      return true
   elseif has_any_magic() and has("mushu") and has("genie") and has("dumbo") then
      return true
   end
   return false
end

-- Agrabah Desert Defeat Kurt Zisa
function ag_kurt_zisa_magic_access()
   if has("blizzard", 3) then
      return AccessibilityLevel.Normal
   elseif (
      logic_difficulty_at_least_normal()
      and (has("blizzard", 2) or has("fire", 3) or has("thunder", 3) or has("gravity", 3))
   ) then
      return AccessibilityLevel.Normal
   elseif (
      logic_difficulty_at_least_proud()
      and (has("blizzard", 1) or has("fire", 2) or has("thunder", 2) or has("gravity", 2))
   ) then
      return AccessibilityLevel.Normal
   elseif logic_difficulty_at_least_minimal() and has_minimal_kurt_zisa_magic() then
      return AccessibilityLevel.Normal
   elseif has_minimal_kurt_zisa_magic() then
      return AccessibilityLevel.SequenceBreak
   end

   return AccessibilityLevel.None
end

-- Monstro Chamber 6 Other Platform Chest
-- Monstro Chamber 6 Raised Area Near Chamber 1 Entrance Chest
function mon_chamber_6_access()
   if has("high_jump") and has("glide") then
      return AccessibilityLevel.Normal
   elseif (
      logic_difficulty_at_least_proud()
      and (has("high_jump") or has("glide") or has("combo_master"))
   ) then
      return AccessibilityLevel.Normal
   elseif logic_difficulty_at_least_minimal() then
      return AccessibilityLevel.Normal
   end

   return AccessibilityLevel.SequenceBreak
end

-- Monstro Defeat Parasite Cage II Stop Event
function mon_parasite_ii_access()
   if not has("monstro") then
      return AccessibilityLevel.None
   end
   if (
      has("high_jump")
      or (logic_difficulty_at_least_normal() and has("glide"))
   ) then
      return AccessibilityLevel.Normal
   elseif has("glide") then
      return AccessibilityLevel.SequenceBreak
   end

   return AccessibilityLevel.None
end

-- Atlantica Crystal Trident Checks Modified Beginner Logic
-- AP world verifies that beginner players with keyblade locking can
-- access the crystal trident chest before giving access to crystal
-- trident checks.
function at_beginner_require_chest()
   if access_chest_for("atlantica") then
      return AccessibilityLevel.Normal
   elseif logic_difficulty_at_least_normal() then
      return AccessibilityLevel.Normal
   end

   return AccessibilityLevel.SequenceBreak
end

-- Atlantica Offensive Magic Against Ursula
function at_offensive_magic()
   if has("fire") or has("blizzard") then
      return AccessibilityLevel.Normal
   elseif logic_difficulty_at_least_proud() and (has("thunder") or has("gravity")) then
      return AccessibilityLevel.Normal
   elseif logic_difficulty_at_least_minimal() and has("stop") then
      return AccessibilityLevel.Normal
   elseif has("thunder") or has("gravity") or has("stop") then
      return AccessibilityLevel.SequenceBreak
   end

   return AccessibilityLevel.None
end

-- Halloween Town Guillotine Square High Tower Chest
function ht_high_tower_access()
   if has("high_jump") and has("glide") then
      return AccessibilityLevel.Normal
   elseif logic_difficulty_at_least_normal() and (has("high_jump") or has("glide")) then
      return AccessibilityLevel.Normal
   elseif logic_difficulty_at_least_proud() and can_dumbo_skip() then
      return AccessibilityLevel.Normal
   elseif has("high_jump") or has("glide") or can_dumbo_skip() then
      return AccessibilityLevel.SequenceBreak
   end

   return AccessibilityLevel.None
end

-- Halloween Town Guillotine Square Pumpkin Structure Left Chest
-- Halloween Town Guillotine Square Pumpkin Structure Right Chest
function ht_pumpkin_structure_access()
   if has("high_jump") and has("glide") then
      return AccessibilityLevel.Normal
   elseif logic_difficulty_at_least_normal() and (has("high_jump", 2) or has("glide")) then
      return AccessibilityLevel.Normal
   elseif (
      logic_difficulty_at_least_proud()
      and has("combo_master") and (has("high_jump") or can_dumbo_skip())
   ) then
      return AccessibilityLevel.Normal
   elseif (
      has("high_jump", 2) or has("glide")
      or (has("combo_master") and (has("high_jump") or can_dumbo_skip()))
   ) then
      return AccessibilityLevel.SequenceBreak
   end

   return AccessibilityLevel.None
end

-- Halloween Town Bridge Right of Gate Chest
function ht_bridge_right_access()
   if has("glide") or has("high_jump", 3) then
      return AccessibilityLevel.Normal
   elseif logic_difficulty_at_least_normal() and has("high_jump", 2) then
      return AccessibilityLevel.Normal
   elseif logic_difficulty_at_least_proud() and has("high_jump") then
      return AccessibilityLevel.Normal
   elseif logic_difficulty_at_least_minimal() then
      return AccessibilityLevel.Normal
   end

   return AccessibilityLevel.SequenceBreak
end

-- Halloween Town Bridge Left of Gate Chest
function ht_bridge_left_access()
   if has("glide") or has("high_jump") then
      return AccessibilityLevel.Normal
   elseif logic_difficulty_at_least_proud() then
      return AccessibilityLevel.Normal
   end

   return AccessibilityLevel.SequenceBreak
end

-- Halloween Town Oogie's Manor
function ht_oogie_manor_access()
   if has("fire") then
      return AccessibilityLevel.Normal
   elseif logic_difficulty_at_least_normal() and has("high_jump", 3) then
      return AccessibilityLevel.Normal
   elseif logic_difficulty_at_least_proud() and (has("high_jump", 2) or (has("high_jump") and has("glide"))) then
      return AccessibilityLevel.Normal
   elseif logic_difficulty_at_least_minimal() and (has("high_jump") or has("glide")) then
      return AccessibilityLevel.Normal
   elseif has("high_jump") or has("glide") then
      return AccessibilityLevel.SequenceBreak
   end

   return false
end

-- Halloween Town Oogie's Manor Lower Iron Cage
function ht_manor_lower_cage_access()
   if has("glide") or has_basic_tools() then
      return AccessibilityLevel.Normal
   elseif logic_difficulty_at_least_normal() then
      return AccessibilityLevel.Normal
   end

   return AccessibilityLevel.SequenceBreak
end

-- Halloween Town Oogie's Manor Upper Iron Cage
function ht_manor_upper_cage_access()
   if has("glide") and has("high_jump") then
      return AccessibilityLevel.Normal
   elseif has_basic_tools() then
      return AccessibilityLevel.Normal
   elseif logic_difficulty_at_least_normal() then
      return AccessibilityLevel.Normal
   end

   return AccessibilityLevel.SequenceBreak
end

-- Neverland Ship Hold Beam Chests
function nl_hold_beam_access()
   if has("green_trinity") or has("glide") then
      return AccessibilityLevel.Normal
   elseif logic_difficulty_at_least_normal() and has("high_jump", 3) then
      return AccessibilityLevel.Normal
   elseif has("high_jump", 3) then
      return AccessibilityLevel.SequenceBreak
   end

   return AccessibilityLevel.None
end

-- Neverland Defeat Phantom
function nl_phantom_magic_access()
   if has_lv_magic(3) then
      return AccessibilityLevel.Normal
   elseif logic_difficulty_at_least_normal() and has_lv_magic(2) then
      return AccessibilityLevel.Normal
   end

   local elemental_magic_count = 0
   local elemental_spells = {"fire", "blizzard", "thunder"}
   for _, spell in ipairs(elemental_spells) do
      if has(spell) then
         elemental_magic_count = elemental_magic_count + 1
      end
   end

   if logic_difficulty_at_least_proud() and elemental_magic_count == 3 and has("stop") then
      return AccessibilityLevel.Normal
   elseif logic_difficulty_at_least_minimal() and elemental_magic_count >= 2 and has("stop") then
      return AccessibilityLevel.Normal
   elseif elemental_magic_count >= 2 and has("stop") then
      return AccessibilityLevel.SequenceBreak
   end

   return AccessibilityLevel.None
end

-- Neverland Defeat Phantom
function nl_phantom_defense_access()
   if has("leaf_bracer") or logic_difficulty_at_least_proud() then
      return AccessibilityLevel.Normal
   end

   return AccessibilityLevel.SequenceBreak
end

-- Hollow Bastion Floating Platform Near Save Point
-- Hollow Bastion Floating Platform Near Bubble
function hb_falls_floating_platform_access()
   if has("high_jump") or has("glide") or has("blizzard") then
      return AccessibilityLevel.Normal
   end

   return AccessibilityLevel.None
end

-- Hollow Bastion Rising Falls High Platform Chest
function hb_falls_high_platform_access()
   if has("glide") then
      return AccessibilityLevel.Normal
   elseif has("blizzard") and has_emblems() then
      return AccessibilityLevel.Normal
   elseif logic_difficulty_at_least_normal() and has("high_jump", 3) then
      return AccessibilityLevel.Normal
   elseif logic_difficulty_at_least_proud() and (has("high_jump") or has("combo_master")) then
      return AccessibilityLevel.Normal
   elseif logic_difficulty_at_least_minimal() then
      return AccessibilityLevel.Normal
   end

   return AccessibilityLevel.SequenceBreak
end

-- Hollow Bastion Base Level Platform Near Entrance
function hb_base_platform_access()
   if has("glide") or has("high_jump") or logic_difficulty_at_least_normal() then
      return AccessibilityLevel.Normal
   end

   return AccessibilityLevel.SequenceBreak
end

-- Hollow Bastion Castle Gates Gravity Chest
function hb_castle_gates_gravity_access()
   if has_emblems() then
      return AccessibilityLevel.Normal
   elseif logic_difficulty_at_least_normal() and has("glide") and has("high_jump", 3) then
      return AccessibilityLevel.Normal
   elseif logic_difficulty_at_least_proud() and has("glide") and (has("high_jump", 2) or can_dumbo_skip()) then
      return AccessibilityLevel.Normal
   elseif logic_difficulty_at_least_minimal() and has("glide") and has("high_jump") then
      return AccessibilityLevel.Normal
   elseif has("glide") and (has("high_jump") or can_dumbo_skip()) then
      return AccessibilityLevel.SequenceBreak
   end

   return AccessibilityLevel.None
end

-- Hollow Bastion Castle Gates Freestanding Pillar Chest
-- Hollow Bastion Castle Gates High Pillar Chest
function hb_castle_gates_pillar_access()
   if has_emblems() then
      return AccessibilityLevel.Normal
   elseif logic_difficulty_at_least_normal() and has("high_jump", 3) then
      return AccessibilityLevel.Normal
   elseif logic_difficulty_at_least_proud() and (has("high_jump", 2) or can_dumbo_skip()) then
      return AccessibilityLevel.Normal
   elseif logic_difficulty_at_least_minimal() and has("glide") and has("high_jump") then
      return AccessibilityLevel.Normal
   elseif can_dumbo_skip() or (has("glide") and has("high_jump")) then
      return AccessibilityLevel.SequenceBreak
   end

   return AccessibilityLevel.None
end

-- Hollow Bastion Lift Stop from Waterway Examine Node
function hb_lift_stop_from_waterway_access()
   if has_emblems() then
      return AccessibilityLevel.Normal
   elseif logic_difficulty_at_least_normal() and has("glide") and has("high_jump", 3) then
      return AccessibilityLevel.Normal
   elseif logic_difficulty_at_least_proud() and has("glide") and (has("high_jump", 2) or can_dumbo_skip()) then
      return AccessibilityLevel.Normal
   elseif logic_difficulty_at_least_minimal() and has("glide") and has("high_jump") then
      return AccessibilityLevel.Normal
   elseif has("glide") and (has("high_jump") or can_dumbo_skip()) then
      return AccessibilityLevel.SequenceBreak
   end

   return AccessibilityLevel.None
end


-- Hollow Bastion Entrance Hall Pillar Left of Emblem Door Chest
function hb_entrance_hall_pillar_access()
   if has("high_jump") then
      return AccessibilityLevel.Normal
   elseif logic_difficulty_at_least_normal() and has_emblems() and can_dumbo_skip() then
      return AccessibilityLevel.Normal
   elseif has_emblems() and can_dumbo_skip() then
      return AccessibilityLevel.SequenceBreak
   end

   return AccessibilityLevel.None
end

-- Hollow Bastion Entrance Hall Upper Level
function hb_entrance_hall_upper_level_access()
   if hb_after_theon_6() or has_emblems() then
      return AccessibilityLevel.Normal
   elseif logic_difficulty_at_least_normal() and has("high_jump", 3) then
      return AccessibilityLevel.Normal
   elseif logic_difficulty_at_least_proud() and has("high_jump", 2) then
      return AccessibilityLevel.Normal
   elseif has("high_jump", 2) then
      return AccessibilityLevel.SequenceBreak
   end

   return AccessibilityLevel.None
end

-- Hollow Bastion Entrance Hall Emblem Piece Flame
function hb_entrance_hall_flame_emblem_access()
   if has("glide") or has("thunder") then
      return AccessibilityLevel.Normal
   elseif logic_difficulty_at_least_normal() and has("high_jump") then
      return AccessibilityLevel.Normal
   elseif logic_difficulty_at_least_proud() then
      return AccessibilityLevel.Normal
   elseif has("high_jump") then
      return AccessibilityLevel.SequenceBreak
   end

   return AccessibilityLevel.None
end

-- End of the World World Terminus Agrabah Chest
function eotw_world_terminus_agrabah_access()
   if has("high_jump") then
      return AccessibilityLevel.Normal
   elseif logic_difficulty_at_least_proud() and can_dumbo_skip() and has("glide") then
      return AccessibilityLevel.Normal
   elseif can_dumbo_skip() and has("glide") then
      return AccessibilityLevel.SequenceBreak
   end

   return AccessibilityLevel.None
end

-- 100 Acre Wood Bouncing Spot Left Cliff Chest
-- 100 Acre Wood Bouncing Spot Right Tree Alcove Chest
-- 100 Acre Wood Bouncing Spot Right Turn in Rare Nut 2, 3, 4, 5
function haw_bouncing_spot_access()
   if has("high_jump") and has("glide") then
      return AccessibilityLevel.Normal
   elseif logic_difficulty_at_least_normal() and (has("high_jump") or has("glide")) then
      return AccessibilityLevel.Normal
   elseif logic_difficulty_at_least_proud() then
      return AccessibilityLevel.Normal
   end

   return AccessibilityLevel.SequenceBreak
end