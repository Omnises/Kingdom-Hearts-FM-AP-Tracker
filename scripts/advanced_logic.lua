-- Traverse Town 1st District Blue Trinity Balcony Chest
function tt_balcony_access()
   return ANY(
      ALL("blue_trinity", "glide"),
      ALL(AT_LEAST(LOGIC_PROUD), "glide"),
      ALL(
         AT_LEAST(LOGIC_MINIMAL),
         can_dumbo_skip(),
         "summon_anywhere",
         ANY(beta_version_at_least(VERSION_1_1_0), AccessibilityLevel.SequenceBreak)
      ),
      ALL(AccessibilityLevel.SequenceBreak, "blue_trinity")
   )
end

-- Traverse Town Mystical House Yellow Trinity Chest
function tt_mystical_house_trinity_chest_access()
   return ANY(
      "yellow_trinity",
      ALL(AT_LEAST(LOGIC_NORMAL), HAS("high_jump", 2)),
      ALL(
         AT_LEAST(LOGIC_PROUD),
         ANY(
            "high_jump",
            ALL(
               can_dumbo_skip(),
               "summon_anywhere",
               ANY(beta_version_at_least(VERSION_1_1_0), AccessibilityLevel.SequenceBreak)
            )
         )
      )
   )
end

-- Traverse Town Mystical House Glide Chest
function tt_mystical_house_glide_access()
   return ANY(
      "glide",
      ALL(
         AT_LEAST(LOGIC_PROUD),
         ANY(
            ALL(
               can_dumbo_skip(),
               "summon_anywhere",
               ANY(beta_version_at_least(VERSION_1_1_0), AccessibilityLevel.SequenceBreak)
            ),
            HAS("high_jump", 3),
            ALL(
               "combo_master",
               ANY(
                  ALL(
                     can_air_dodge(),
                     ANY(beta_version_at_least(VERSION_1_1_0), AccessibilityLevel.SequenceBreak)
                  ),
                  HAS("high_jump", 2),
                  ALL("high_jump", HAS("air_combo_plus", 2))
               )
            )
         )
      ),
      ALL(
         AT_LEAST(LOGIC_MINIMAL),
         ANY(
            "mermaid_kick",
            ALL(
               can_air_dodge(),
               ANY(beta_version_at_least(VERSION_1_1_0), AccessibilityLevel.SequenceBreak)
            ),
            ALL(
               "combo_master",
               ANY("high_jump", HAS("air_combo_plus", 2))
            )
         )
      )
   )
end

-- Traverse Town Item Workshop (Moogle Workshop)
function tt_moogle_workshop_access()
   return ANY(
      "green_trinity",
      ALL(
         AT_LEAST(LOGIC_PROUD),
         ANY(
            HAS("high_jump", 2),
            ALL(
               can_dumbo_skip(),
               "summon_anywhere",
               ANY(beta_version_at_least(VERSION_1_1_0), AccessibilityLevel.SequenceBreak)
            )
         )
      )
   )
end

-- Traverse Town Item Workshop Synth 15 Items
function tt_can_synth_15()
   local orichalcum_count = Tracker:FindObjectForCode("orichalcum").AcquiredCount
   local mythril_count = Tracker:FindObjectForCode("mythril").AcquiredCount

   return math.min(orichalcum_count, 9) + math.min(mythril_count, 9) >= 15
end

-- Wonderland Queen's Castle Hedge Left Red Chest
-- Wonderland Queen's Castle Hedge Right Blue Chest
-- Wonderland Queen's Castle Hedge Right Red Chest
function wl_queens_castle_hedge_access()
   return ANY(
      wl_after_footprints(),
      "high_jump",
      ALL(AT_LEAST(LOGIC_NORMAL), "glide"),
      ALL(
         AT_LEAST(LOGIC_PROUD),
         can_dumbo_skip(),
         "summon_anywhere",
         ANY(beta_version_at_least(VERSION_1_1_0), AccessibilityLevel.SequenceBreak)
      )
   )
end

function wl_early_tea_access()
   return ANY(
      "glide",
      ANY(
         ALL(
            AT_LEAST(LOGIC_PROUD),
            can_air_dodge(),
            ANY(beta_version_at_least(VERSION_1_1_0), AccessibilityLevel.SequenceBreak),
            HAS("high_jump", 3)
         ),
         ALL(
            AT_LEAST(LOGIC_MINIMAL),
            ANY(
               can_minimal_air_combo_jump(),
               ALL(
                  can_air_dodge(),
                  ANY(beta_version_at_least(VERSION_1_1_0), AccessibilityLevel.SequenceBreak),
                  ANY(
                     HAS("high_jump", 2),
                     ALL("combo_master", "high_jump", HAS("air_combo_plus", 2))
                  )
               )
            )
         )
      )
   )
end

-- Wonderland Lotus Forest Glide Chest
function wl_lotus_forest_southwest_access()
   return ANY(
      "glide",
      ALL(
         AT_LEAST(LOGIC_PROUD),
         ANY("high_jump", can_dumbo_skip()),
         wl_after_footprints()
      ),
      wl_early_tea_access()
   )
end

-- Wonderland Lotus Forest Corner Chest
function wl_jump_and_glide_access()
   return ANY(
      ALL("high_jump", "glide"),
      ALL(AT_LEAST(LOGIC_NORMAL), ANY("high_jump", "glide")),
      AT_LEAST(LOGIC_PROUD)
   )
end

-- Wonderland Tea Party Garden Above Lotus Forest Entrance 2nd Chest
-- Wonderland Tea Party Garden Above Lotus Forest Entrance 1st Chest
function wl_tea_party_entrance_hedge_access()
   return ANY(
      "glide",
      ALL(AT_LEAST(LOGIC_NORMAL), HAS("high_jump", 2), wl_after_footprints()),
      ALL(
         AT_LEAST(LOGIC_PROUD),
         ANY("high_jump", can_dumbo_skip()),
         wl_after_footprints()
      ),
      wl_early_tea_access()
   )
end

-- Wonderland Tea Party Garden Bear and Clock Puzzle Chest
function wl_tea_party_puzzle_access()
   return ANY(
      wl_after_footprints(),
      "glide",
      ALL(AT_LEAST(LOGIC_MINIMAL), can_minimal_air_combo_jump())
   )
end

-- Wonderland Tea Party Garden Chairs
function wl_tea_party_chair_access()
   return ANY(
      wl_after_footprints(),
      "glide",
      wl_early_tea_access()
   )
end

-- Wonderland Tea Party Garden Across From Bizarre Room Entrance Chest
function wl_tea_party_high_hedge_access()
   return ANY(
      "glide",
      ALL(AT_LEAST(LOGIC_NORMAL), HAS("high_jump", 3), wl_after_footprints()),
      ALL(
         AT_LEAST(LOGIC_PROUD),
         ANY(
            ALL("high_jump", "combo_master", wl_after_footprints()),
            ALL(HAS("high_jump", 2), wl_after_footprints())
         )
      ),
      wl_early_tea_access()
   )
end

-- Deep Jungle Hippo's Lagoon Right Chest
function dj_jump_and_glide_access()
   return ANY(
      ALL("high_jump", "glide"),
      ALL(AT_LEAST(LOGIC_NORMAL), ANY("high_jump", "glide")),
      AT_LEAST(LOGIC_PROUD)
   )
end

-- Agrabah Main Street High Above Palace Gates Entrance Chest
function ag_high_jump_access()
   return ANY(
      "high_jump",
      ALL(AT_LEAST(LOGIC_NORMAL), "glide"),
      ALL(AT_LEAST(LOGIC_PROUD), can_dumbo_skip())
   )
end

-- Agrabah Palace Gates High Close to Palace Chest
function ag_palace_access()
   return ANY(
      ALL("high_jump", "glide"),
      ALL(AT_LEAST(LOGIC_NORMAL), HAS("high_jump", 3)),
      ALL(
         AT_LEAST(LOGIC_PROUD),
         ANY(HAS("high_jump", 2), "glide", ALL("high_jump", "combo_master"))
      ),
      ALL(
         AT_LEAST(LOGIC_MINIMAL),
         ANY(
            "combo_master",
            ALL(
               can_dumbo_skip(),
               "summon_anywhere",
               ANY(beta_version_at_least(VERSION_1_1_0), AccessibilityLevel.SequenceBreak)
            )
         )
      )
   )
end

-- Agrabah Cave of Wonders Entrance Tall Tower Chest
function ag_cow_entrance_access()
   return ANY(
      "glide",
      ALL(AT_LEAST(LOGIC_NORMAL), HAS("high_jump", 2)),
      ALL(
         AT_LEAST(LOGIC_PROUD),
         ANY(
            "combo_master",
            can_dumbo_skip(),
            "high_jump",
            ALL(
               can_air_dodge(),
               ANY(beta_version_at_least(VERSION_1_1_0), AccessibilityLevel.SequenceBreak)
            )
         )
      ),
      AT_LEAST(LOGIC_MINIMAL)
   )
end

-- Agrabah Cave of Wonders Dark Chamber Near Save Chest
function ag_cow_near_save_access()
   return ANY("high_jump", "glide", AT_LEAST(LOGIC_NORMAL))
end

-- Agrabah Cave of Wonders Hidden Room Right Chest
-- Agrabah Cave of Wonders Hidden Room Left Chest
function ag_cow_hidden_room_access()
   return ANY(
      "yellow_trinity",
      ALL(AT_LEAST(LOGIC_NORMAL), "high_jump"),
      ALL(AT_LEAST(LOGIC_PROUD), "glide")
   )
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
   return ANY(
      HAS("blizzard", 3),
      ALL(
         AT_LEAST(LOGIC_NORMAL),
         ANY(HAS("blizzard", 2), HAS("fire", 3), HAS("thunder", 3), HAS("gravity", 3))
      ),
      ALL(
         AT_LEAST(LOGIC_PROUD),
         ANY("blizzard", HAS("fire", 2), HAS("thunder", 2), HAS("gravity", 2))
      ),
      ALL(AT_LEAST(LOGIC_MINIMAL), has_minimal_kurt_zisa_magic())
   )
end

-- Monstro Mouth High Platform Boat Side Chest
-- Monstro Mouth High Platform Across from Boat Chest
-- Monstro Mouth Green Trinity Top of Boat Chest
function mon_mouth_high_places_access()
   return ANY(
      "high_jump",
      ALL(AT_LEAST(LOGIC_NORMAL), "glide"),
      ALL(
         AT_LEAST(LOGIC_PROUD),
         can_dumbo_skip(),
         "summon_anywhere",
         ANY(beta_version_at_least(VERSION_1_1_0), AccessibilityLevel.SequenceBreak)
      )
   )
end

-- Monstro Chamber 6 Other Platform Chest
function mon_chamber_6_other_platform_access()
   return ANY(
      ALL("high_jump", "glide"),
      ALL(
         AT_LEAST(LOGIC_PROUD),
         ANY(
            "combo_master",
            "high_jump",
            "glide",
            ALL(
               can_air_dodge(),
               ANY(beta_version_at_least(VERSION_1_1_0), AccessibilityLevel.SequenceBreak)
            ),
            ALL(
               can_dumbo_skip(),
               ANY(beta_version_at_least(VERSION_1_1_0), AccessibilityLevel.SequenceBreak)
            )
         )
      ),
      AT_LEAST(LOGIC_MINIMAL)
   )
end

-- Monstro Chamber 6 Raised Area Near Chamber 1 Entrance Chest
function mon_chamber_6_near_chamber_1_access()
   return ANY(
      ALL("high_jump", "glide"),
      ALL(
         AT_LEAST(LOGIC_PROUD),
         ANY(
            "combo_master",
            "high_jump",
            "glide",
            ALL(
               can_air_dodge(),
               ANY(beta_version_at_least(VERSION_1_1_0), AccessibilityLevel.SequenceBreak)
            ),
            ALL(
               can_dumbo_skip(),
               "summon_anywhere",
               ANY(beta_version_at_least(VERSION_1_1_0), AccessibilityLevel.SequenceBreak)
            )
         )
      ),
      AT_LEAST(LOGIC_MINIMAL)
   )
end

-- Monstro Defeat Parasite Cage II Stop Event
function mon_parasite_ii_access()
   return ALL(
      "monstro",
      ANY(
         "high_jump",
         ALL(AT_LEAST(LOGIC_NORMAL), "glide"),
         ALL(
            AT_LEAST(LOGIC_PROUD),
            can_dumbo_skip(),
            "summon_anywhere",
            ANY(beta_version_at_least(VERSION_1_1_0), AccessibilityLevel.SequenceBreak)
         )
      )
   )
end

-- Atlantica Crystal Trident Checks Modified Beginner Logic
-- AP world verifies that beginner players with keyblade locking can
-- access the crystal trident chest before giving access to crystal
-- trident checks.
function at_beginner_require_chest()
   if beta_version_at_least(VERSION_1_1_0) then
      return access_chest_for("atlantica")
   end
   return ANY(access_chest_for("atlantica"), AT_LEAST(LOGIC_NORMAL))
end

-- Atlantica Offensive Magic Against Ursula
function at_offensive_magic()
   return ANY(
      "fire",
      "blizzard",
      ALL(AT_LEAST(LOGIC_PROUD), ANY("thunder", "gravity")),
      ALL(AT_LEAST(LOGIC_MINIMAL), "stop")
   )
end

-- Halloween Town Guillotine Square High Tower Chest
function ht_high_tower_access()
   return ANY(
      ALL("high_jump", "glide"),
      ALL(AT_LEAST(LOGIC_NORMAL), ANY("high_jump", "glide")),
      ALL(AT_LEAST(LOGIC_PROUD), can_dumbo_skip())
   )
end

-- Halloween Town Guillotine Square Pumpkin Structure Left Chest
-- Halloween Town Guillotine Square Pumpkin Structure Right Chest
function ht_pumpkin_structure_access()
   return ALL(
      ANY(
         "high_jump",
         ALL(AT_LEAST(LOGIC_NORMAL), "glide"),
         ALL(AT_LEAST(LOGIC_PROUD), can_dumbo_skip())
      ),
      ANY(
         "glide",
         ALL(AT_LEAST(LOGIC_NORMAL), HAS("high_jump", 2)),
         ALL(
            AT_LEAST(LOGIC_PROUD),
            ANY(
               "combo_master",
               ALL(
                  can_air_dodge(),
                  ANY(beta_version_at_least(VERSION_1_1_0), AccessibilityLevel.SequenceBreak)
               )
            )
         )
      )
   )
end

-- Halloween Town Bridge Right of Gate Chest
function ht_bridge_right_access()
   return ANY(
      "glide",
      HAS("high_jump", 3),
      ALL(AT_LEAST(LOGIC_NORMAL), HAS("high_jump", 2)),
      ALL(AT_LEAST(LOGIC_PROUD), "high_jump"),
      AT_LEAST(LOGIC_MINIMAL)
   )
end

-- Halloween Town Bridge Left of Gate Chest
function ht_bridge_left_access()
   return ANY("glide", "high_jump", AT_LEAST(LOGIC_PROUD))
end

-- Halloween Town Oogie's Manor
function ht_oogie_manor_access()
   return ANY(
      "fire",
      ALL(AT_LEAST(LOGIC_NORMAL), HAS("high_jump", 3)),
      ALL(
         AT_LEAST(LOGIC_PROUD),
         ANY(
            HAS("high_jump", 2),
            ALL("high_jump", "glide"),
            ALL(
               can_dumbo_skip(),
               ANY(beta_version_at_least(VERSION_1_1_0), AccessibilityLevel.SequenceBreak)
            )
         )
      ),
      ALL(AT_LEAST(LOGIC_MINIMAL), ANY("high_jump", "glide")),
      ALL(AccessibilityLevel.SequenceBreak, can_dumbo_skip())
   )
end

-- Halloween Town Oogie's Manor Lower Iron Cage
function ht_manor_lower_cage_access()
   return ANY("glide", has_basic_tools(), AT_LEAST(LOGIC_NORMAL))
end

-- Halloween Town Oogie's Manor Upper Iron Cage
function ht_manor_upper_cage_access()
   return ANY(
      "glide",
      "high_jump",
      has_basic_tools(),
      AT_LEAST(LOGIC_NORMAL)
   )
end

-- Neverland Ship Hold Beam Chests
function nl_hold_beam_access()
   return ANY(
      "green_trinity",
      "glide",
      ALL(AT_LEAST(LOGIC_NORMAL), HAS("high_jump", 3))
   )
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
function hb_falls_floating_platform_near_save_access()
   return ANY(
      "high_jump",
      "glide",
      "blizzard",
      ALL(
         AT_LEAST(LOGIC_PROUD),
         can_dumbo_skip(),
         "summon_anywhere",
         ANY(beta_version_at_least(VERSION_1_1_0), AccessibilityLevel.SequenceBreak)
      ),
      ALL(
         AT_LEAST(LOGIC_MINIMAL),
         can_air_dodge(),
         ANY(beta_version_at_least(VERSION_1_1_0), AccessibilityLevel.SequenceBreak)
      )
   )
end

-- Hollow Bastion Floating Platform Near Bubble
function hb_falls_floating_platform_near_bubble_access()
   return ANY(
      "high_jump",
      "glide",
      "blizzard",
      ALL(
         AT_LEAST(LOGIC_PROUD),
         can_dumbo_skip(),
         "summon_anywhere",
         ANY(beta_version_at_least(VERSION_1_1_0), AccessibilityLevel.SequenceBreak)
      ),
      ALL(
         AT_LEAST(LOGIC_MINIMAL),
         can_air_dodge(),
         ANY(beta_version_at_least(VERSION_1_1_0), AccessibilityLevel.SequenceBreak),
         "combo_master",
         HAS("air_combo_plus", 2)
      )
   )
end

-- Hollow Bastion Rising Falls High Platform Chest
function hb_falls_high_platform_access()
   return ANY(
      "glide",
      ALL("blizzard", has_emblems()),
      ALL(AT_LEAST(LOGIC_NORMAL), HAS("high_jump", 3)),
      ALL(
         AT_LEAST(LOGIC_PROUD),
         ANY(
            "high_jump",
            "combo_master",
            ALL(
               can_air_dodge(),
               ANY(beta_version_at_least(VERSION_1_1_0), AccessibilityLevel.SequenceBreak)
            ),
            ALL(
               can_dumbo_skip(),
               "summon_anywhere",
               ANY(beta_version_at_least(VERSION_1_1_0), AccessibilityLevel.SequenceBreak)
            )
         )
      ),
      AT_LEAST(LOGIC_MINIMAL)
   )
end

-- Hollow Bastion Base Level Platform Near Entrance
function hb_base_platform_access()
   return ANY("glide", "high_jump", AT_LEAST(LOGIC_NORMAL))
end

-- Hollow Bastion Castle Gates Gravity Chest
function hb_castle_gates_gravity_access()
   return ANY(
      has_emblems(),
      ALL(AT_LEAST(LOGIC_NORMAL), "glide", HAS("high_jump", 3)),
      ALL(AT_LEAST(LOGIC_PROUD), "glide", ANY(HAS("high_jump", 2), can_dumbo_skip())),
      ALL(AT_LEAST(LOGIC_MINIMAL), "glide", "high_jump")
   )
end

-- Hollow Bastion Castle Gates Freestanding Pillar Chest
-- Hollow Bastion Castle Gates High Pillar Chest
function hb_castle_gates_pillar_access()
   return ANY(
      has_emblems(),
      ALL(AT_LEAST(LOGIC_NORMAL), HAS("high_jump", 3)),
      ALL(AT_LEAST(LOGIC_PROUD), ANY(HAS("high_jump", 2), can_dumbo_skip())),
      ALL(AT_LEAST(LOGIC_MINIMAL), "glide", "high_jump")
   )
end

-- Hollow Bastion Lift Stop from Waterway Examine Node
function hb_lift_stop_from_waterway_access()
   return ANY(
      has_emblems(),
      ALL(AT_LEAST(LOGIC_NORMAL), "glide", HAS("high_jump", 3)),
      ALL(AT_LEAST(LOGIC_PROUD), "glide", ANY(HAS("high_jump", 2), can_dumbo_skip())),
      ALL(AT_LEAST(LOGIC_MINIMAL), "glide", "high_jump")
   )
end


-- Hollow Bastion Entrance Hall Pillar Left of Emblem Door Chest
function hb_entrance_hall_pillar_access()
   return ANY(
      "high_jump",
      ALL(
         AT_LEAST(LOGIC_PROUD),
         can_dumbo_skip(),
         ANY(
            has_emblems(),
            ALL(
               "summon_anywhere",
               ANY(beta_version_at_least(VERSION_1_1_0), AccessibilityLevel.SequenceBreak)
            )
         )
      )
   )
end

-- Hollow Bastion Entrance Hall Upper Level
function hb_entrance_hall_upper_level_access()
   return ANY(
      hb_after_theon_6(),
      has_emblems(),
      ALL(AT_LEAST(LOGIC_NORMAL), HAS("high_jump", 3)),
      ALL(AT_LEAST(LOGIC_PROUD), HAS("high_jump", 2))
   )
end

-- Hollow Bastion Entrance Hall Emblem Piece Flame
function hb_entrance_hall_flame_emblem_access()
   return ALL(
      hb_entrance_hall_upper_level_access(),
      ANY(
         "fire",
         ALL(
            has_emblems(),
            ANY(
               ALL(beta_version_at_least(VERSION_1_1_0), AT_LEAST(LOGIC_MINIMAL)),
               AccessibilityLevel.SequenceBreak
            )
         )
      ),
      ANY(
         "glide",
         "thunder",
         ALL(AT_LEAST(LOGIC_NORMAL), "high_jump"),
         AT_LEAST(LOGIC_PROUD)
      )
   )
end

-- End of the World Final Dimension Giant Crevasse - 1st Chest
function eotw_giant_crevasse_first()
   if beta_version_at_least(VERSION_1_1_0) then
      return ANY(
         "high_jump",
         "glide",
         AT_LEAST(LOGIC_PROUD)
      )
   end
   return ANY(
      "high_jump",
      "glide",
      AT_LEAST(LOGIC_NORMAL)
   )
end

-- End of the World Final Dimension Giant Crevasse - 2nd Chest
-- End of the World Final Dimension Giant Crevasse - 3rd Chest
function eotw_giant_crevasse_lower()
   return ANY("glide", "high_jump", AT_LEAST(LOGIC_NORMAL))
end

-- End of the World Final Dimension Giant Crevasse - 4th Chest
function eotw_giant_crevasse_upper()
   if beta_version_at_least(VERSION_1_1_0) then
      return ANY(
         "glide",
         ALL(
            AT_LEAST(LOGIC_PROUD),
            ANY(
               HAS("high_jump", 2),
               ALL(can_dumbo_skip(), "summon_anywhere")
            )
         ),
         ALL(AT_LEAST(LOGIC_MINIMAL), can_air_dodge())
      )
   end
   return ANY(
      "glide",
      ALL(
         AT_LEAST(LOGIC_PROUD),
         ANY(
            HAS("high_jump", 2),
            ALL("high_jump", "combo_master")
         )
      ),
      ALL(
         AccessibilityLevel.SequenceBreak,
         ANY(
            ALL(can_dumbo_skip(), "summon_anywhere"),
            can_air_dodge()
         )
      )
   )
end

-- End of the World World Terminus Agrabah Chest
function eotw_world_terminus_agrabah_access()
   return ANY(
      "high_jump",
      ALL(
         AT_LEAST(LOGIC_PROUD),
         can_dumbo_skip(),
         ANY(
            "glide",
            ALL(
               "summon_anywhere",
               ANY(beta_version_at_least(VERSION_1_1_0), AccessibilityLevel.SequenceBreak)
            )
         )
      )
   )
end

-- 100 Acre Wood Bouncing Spot Left Cliff Chest
-- 100 Acre Wood Bouncing Spot Right Tree Alcove Chest
-- 100 Acre Wood Bouncing Spot Turn in Rare Nut 2, 3, 4
function haw_bouncing_spot_access()
   return ANY(
      ALL("high_jump", "glide"),
      ALL(AT_LEAST(LOGIC_NORMAL), ANY("high_jump", "glide")),
      AT_LEAST(LOGIC_PROUD)
   )
end

-- 100 Acre Wood Bouncing Spot Turn in Rare Nut 5
function haw_final_nut_access()
   return ANY(
      ALL("high_jump", "glide"),
      ALL(AT_LEAST(LOGIC_NORMAL), ANY("glide", "high_jump")),
      ALL(
         AT_LEAST(LOGIC_MINIMAL),
         ANY(
            "combo_master",
            ALL(
               can_air_dodge(),
               ANY(beta_version_at_least(VERSION_1_1_0), AccessibilityLevel.SequenceBreak)
            )
         )
      )
   )
end

-- Locations after boss fights require basic tools on beginner difficulty
function boss_beginner_require_tools()
   return ANY(has_basic_tools(), AT_LEAST(LOGIC_NORMAL))
end