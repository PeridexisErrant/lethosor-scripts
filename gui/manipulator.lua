-- manipulator

gui = require 'gui'
widgets = require 'gui.widgets'
utils = require 'utils'
enabler = df.global.enabler
gps = df.global.gps

SKILL_COLUMNS = {
    {group = 0, color = 7, profession = 'MINER', labor = 'MINE', skill = 'MINING', label = "Mi", special = true},
-- Woodworking
    {group = 1, color = 14, profession = 'CARPENTER', labor = 'CARPENTER', skill = 'CARPENTRY', label = "Ca"},
    {group = 1, color = 14, profession = 'BOWYER', labor = 'BOWYER', skill = 'BOWYER', label = "Bw"},
    {group = 1, color = 14, profession = 'WOODCUTTER', labor = 'CUTWOOD', skill = 'WOODCUTTING', label = "WC", special = true},
-- Stoneworking
    {group = 2, color = 15, profession = 'MASON', labor = 'MASON', skill = 'MASONRY', label = "Ma"},
    {group = 2, color = 15, profession = 'ENGRAVER', labor = 'DETAIL', skill = 'DETAILSTONE', label = "En"},
-- Hunting/Related
    {group = 3, color = 2, profession = 'ANIMAL_TRAINER', labor = 'ANIMALTRAIN', skill = 'ANIMALTRAIN', label = "Tn"},
    {group = 3, color = 2, profession = 'ANIMAL_CARETAKER', labor = 'ANIMALCARE', skill = 'ANIMALCARE', label = "Ca"},
    {group = 3, color = 2, profession = 'HUNTER', labor = 'HUNT', skill = 'SNEAK', label = "Hu", special = true},
    {group = 3, color = 2, profession = 'TRAPPER', labor = 'TRAPPER', skill = 'TRAPPING', label = "Tr"},
    {group = 3, color = 2, profession = 'ANIMAL_DISSECTOR', labor = 'DISSECT_VERMIN', skill = 'DISSECT_VERMIN', label = "Di"},
-- Healthcare
    {group = 4, color = 5, profession = 'DIAGNOSER', labor = 'DIAGNOSE', skill = 'DIAGNOSE', label = "Di"},
    {group = 4, color = 5, profession = 'SURGEON', labor = 'SURGERY', skill = 'SURGERY', label = "Su"},
    {group = 4, color = 5, profession = 'BONE_SETTER', labor = 'BONE_SETTING', skill = 'SET_BONE', label = "Bo"},
    {group = 4, color = 5, profession = 'SUTURER', labor = 'SUTURING', skill = 'SUTURE', label = "St"},
    {group = 4, color = 5, profession = 'DOCTOR', labor = 'DRESSING_WOUNDS', skill = 'DRESS_WOUNDS', label = "Dr"},
    {group = 4, color = 5, profession = 'NONE', labor = 'FEED_WATER_CIVILIANS', skill = 'NONE', label = "Fd"},
    {group = 4, color = 5, profession = 'NONE', labor = 'RECOVER_WOUNDED', skill = 'NONE', label = "Re"},
-- Farming/Related
    {group = 5, color = 6, profession = 'BUTCHER', labor = 'BUTCHER', skill = 'BUTCHER', label = "Bu"},
    {group = 5, color = 6, profession = 'TANNER', labor = 'TANNER', skill = 'TANNER', label = "Ta"},
    {group = 5, color = 6, profession = 'PLANTER', labor = 'PLANT', skill = 'PLANT', label = "Gr"},
    {group = 5, color = 6, profession = 'DYER', labor = 'DYER', skill = 'DYER', label = "Dy"},
    {group = 5, color = 6, profession = 'SOAP_MAKER', labor = 'SOAP_MAKER', skill = 'SOAP_MAKING', label = "So"},
    {group = 5, color = 6, profession = 'WOOD_BURNER', labor = 'BURN_WOOD', skill = 'WOOD_BURNING', label = "WB"},
    {group = 5, color = 6, profession = 'POTASH_MAKER', labor = 'POTASH_MAKING', skill = 'POTASH_MAKING', label = "Po"},
    {group = 5, color = 6, profession = 'LYE_MAKER', labor = 'LYE_MAKING', skill = 'LYE_MAKING', label = "Ly"},
    {group = 5, color = 6, profession = 'MILLER', labor = 'MILLER', skill = 'MILLING', label = "Ml"},
    {group = 5, color = 6, profession = 'BREWER', labor = 'BREWER', skill = 'BREWING', label = "Br"},
    {group = 5, color = 6, profession = 'HERBALIST', labor = 'HERBALIST', skill = 'HERBALISM', label = "He"},
    {group = 5, color = 6, profession = 'THRESHER', labor = 'PROCESS_PLANT', skill = 'PROCESSPLANTS', label = "Th"},
    {group = 5, color = 6, profession = 'CHEESE_MAKER', labor = 'MAKE_CHEESE', skill = 'CHEESEMAKING', label = "Ch"},
    {group = 5, color = 6, profession = 'MILKER', labor = 'MILK', skill = 'MILK', label = "Mk"},
    {group = 5, color = 6, profession = 'SHEARER', labor = 'SHEARER', skill = 'SHEARING', label = "Sh"},
    {group = 5, color = 6, profession = 'SPINNER', labor = 'SPINNER', skill = 'SPINNING', label = "Sp"},
    {group = 5, color = 6, profession = 'COOK', labor = 'COOK', skill = 'COOK', label = "Co"},
    {group = 5, color = 6, profession = 'PRESSER', labor = 'PRESSING', skill = 'PRESSING', label = "Pr"},
    {group = 5, color = 6, profession = 'BEEKEEPER', labor = 'BEEKEEPING', skill = 'BEEKEEPING', label = "Be"},
    {group = 5, color = 6, profession = 'GELDER', labor = 'GELD', skill = 'GELD', label = "Ge"},
-- Fishing/Related
    {group = 6, color = 1, profession = 'FISHERMAN', labor = 'FISH', skill = 'FISH', label = "Fi"},
    {group = 6, color = 1, profession = 'FISH_CLEANER', labor = 'CLEAN_FISH', skill = 'PROCESSFISH', label = "Cl"},
    {group = 6, color = 1, profession = 'FISH_DISSECTOR', labor = 'DISSECT_FISH', skill = 'DISSECT_FISH', label = "Di"},
-- Metalsmithing
    {group = 7, color = 8, profession = 'FURNACE_OPERATOR', labor = 'SMELT', skill = 'SMELT', label = "Fu"},
    {group = 7, color = 8, profession = 'WEAPONSMITH', labor = 'FORGE_WEAPON', skill = 'FORGE_WEAPON', label = "We"},
    {group = 7, color = 8, profession = 'ARMORER', labor = 'FORGE_ARMOR', skill = 'FORGE_ARMOR', label = "Ar"},
    {group = 7, color = 8, profession = 'BLACKSMITH', labor = 'FORGE_FURNITURE', skill = 'FORGE_FURNITURE', label = "Bl"},
    {group = 7, color = 8, profession = 'METALCRAFTER', labor = 'METAL_CRAFT', skill = 'METALCRAFT', label = "Cr"},
-- Jewelry
    {group = 8, color = 10, profession = 'GEM_CUTTER', labor = 'CUT_GEM', skill = 'CUTGEM', label = "Cu"},
    {group = 8, color = 10, profession = 'GEM_SETTER', labor = 'ENCRUST_GEM', skill = 'ENCRUSTGEM', label = "Se"},
-- Crafts
    {group = 9, color = 9, profession = 'LEATHERWORKER', labor = 'LEATHER', skill = 'LEATHERWORK', label = "Le"},
    {group = 9, color = 9, profession = 'WOODCRAFTER', labor = 'WOOD_CRAFT', skill = 'WOODCRAFT', label = "Wo"},
    {group = 9, color = 9, profession = 'STONECRAFTER', labor = 'STONE_CRAFT', skill = 'STONECRAFT', label = "St"},
    {group = 9, color = 9, profession = 'BONE_CARVER', labor = 'BONE_CARVE', skill = 'BONECARVE', label = "Bo"},
    {group = 9, color = 9, profession = 'GLASSMAKER', labor = 'GLASSMAKER', skill = 'GLASSMAKER', label = "Gl"},
    {group = 9, color = 9, profession = 'WEAVER', labor = 'WEAVER', skill = 'WEAVING', label = "We"},
    {group = 9, color = 9, profession = 'CLOTHIER', labor = 'CLOTHESMAKER', skill = 'CLOTHESMAKING', label = "Cl"},
    {group = 9, color = 9, profession = 'STRAND_EXTRACTOR', labor = 'EXTRACT_STRAND', skill = 'EXTRACT_STRAND', label = "Ad"},
    {group = 9, color = 9, profession = 'POTTER', labor = 'POTTERY', skill = 'POTTERY', label = "Po"},
    {group = 9, color = 9, profession = 'GLAZER', labor = 'GLAZING', skill = 'GLAZING', label = "Gl"},
    {group = 9, color = 9, profession = 'WAX_WORKER', labor = 'WAX_WORKING', skill = 'WAX_WORKING', label = "Wx"},
-- Engineering
    {group = 10, color = 12, profession = 'SIEGE_ENGINEER', labor = 'SIEGECRAFT', skill = 'SIEGECRAFT', label = "En"},
    {group = 10, color = 12, profession = 'SIEGE_OPERATOR', labor = 'SIEGEOPERATE', skill = 'SIEGEOPERATE', label = "Op"},
    {group = 10, color = 12, profession = 'MECHANIC', labor = 'MECHANIC', skill = 'MECHANICS', label = "Me"},
    {group = 10, color = 12, profession = 'PUMP_OPERATOR', labor = 'OPERATE_PUMP', skill = 'OPERATE_PUMP', label = "Pu"},
-- Hauling
    {group = 11, color = 3, profession = 'NONE', labor = 'HAUL_STONE', skill = 'NONE', label = "St"},
    {group = 11, color = 3, profession = 'NONE', labor = 'HAUL_WOOD', skill = 'NONE', label = "Wo"},
    {group = 11, color = 3, profession = 'NONE', labor = 'HAUL_ITEM', skill = 'NONE', label = "It"},
    {group = 11, color = 3, profession = 'NONE', labor = 'HAUL_BODY', skill = 'NONE', label = "Bu"},
    {group = 11, color = 3, profession = 'NONE', labor = 'HAUL_FOOD', skill = 'NONE', label = "Fo"},
    {group = 11, color = 3, profession = 'NONE', labor = 'HAUL_REFUSE', skill = 'NONE', label = "Re"},
    {group = 11, color = 3, profession = 'NONE', labor = 'HAUL_FURNITURE', skill = 'NONE', label = "Fu"},
    {group = 11, color = 3, profession = 'NONE', labor = 'HAUL_ANIMALS', skill = 'NONE', label = "An"},
    {group = 11, color = 3, profession = 'NONE', labor = 'HANDLE_VEHICLES', skill = 'NONE', label = "Ve"},
    {group = 11, color = 3, profession = 'NONE', labor = 'HAUL_TRADE', skill = 'NONE', label = "Tr"},
    {group = 11, color = 3, profession = 'NONE', labor = 'HAUL_WATER', skill = 'NONE', label = "Wa"},
-- Other Jobs
    {group = 12, color = 4, profession = 'ARCHITECT', labor = 'ARCHITECT', skill = 'DESIGNBUILDING', label = "Ar"},
    {group = 12, color = 4, profession = 'ALCHEMIST', labor = 'ALCHEMIST', skill = 'ALCHEMY', label = "Al"},
    {group = 12, color = 4, profession = 'NONE', labor = 'CLEAN', skill = 'NONE', label = "Cl"},
    {group = 12, color = 4, profession = 'NONE', labor = 'PULL_LEVER', skill = 'NONE', label = "Lv"},
    {group = 12, color = 4, profession = 'NONE', labor = 'BUILD_ROAD', skill = 'NONE', label = "Ro"},
    {group = 12, color = 4, profession = 'NONE', labor = 'BUILD_CONSTRUCTION', skill = 'NONE', label = "Co"},
    {group = 12, color = 4, profession = 'NONE', labor = 'REMOVE_CONSTRUCTION', skill = 'NONE', label = "CR"},
-- Military - Weapons
    {group = 13, color = 7, profession = 'WRESTLER', labor = 'NONE', skill = 'WRESTLING', label = "Wr"},
    {group = 13, color = 7, profession = 'AXEMAN', labor = 'NONE', skill = 'AXE', label = "Ax"},
    {group = 13, color = 7, profession = 'SWORDSMAN', labor = 'NONE', skill = 'SWORD', label = "Sw"},
    {group = 13, color = 7, profession = 'MACEMAN', labor = 'NONE', skill = 'MACE', label = "Mc"},
    {group = 13, color = 7, profession = 'HAMMERMAN', labor = 'NONE', skill = 'HAMMER', label = "Ha"},
    {group = 13, color = 7, profession = 'SPEARMAN', labor = 'NONE', skill = 'SPEAR', label = "Sp"},
    {group = 13, color = 7, profession = 'CROSSBOWMAN', labor = 'NONE', skill = 'CROSSBOW', label = "Cb"},
    {group = 13, color = 7, profession = 'THIEF', labor = 'NONE', skill = 'DAGGER', label = "Kn"},
    {group = 13, color = 7, profession = 'BOWMAN', labor = 'NONE', skill = 'BOW', label = "Bo"},
    {group = 13, color = 7, profession = 'BLOWGUNMAN', labor = 'NONE', skill = 'BLOWGUN', label = "Bl"},
    {group = 13, color = 7, profession = 'PIKEMAN', labor = 'NONE', skill = 'PIKE', label = "Pk"},
    {group = 13, color = 7, profession = 'LASHER', labor = 'NONE', skill = 'WHIP', label = "La"},
-- Military - Other Combat
    {group = 14, color = 15, profession = 'NONE', labor = 'NONE', skill = 'BITE', label = "Bi"},
    {group = 14, color = 15, profession = 'NONE', labor = 'NONE', skill = 'GRASP_STRIKE', label = "St"},
    {group = 14, color = 15, profession = 'NONE', labor = 'NONE', skill = 'STANCE_STRIKE', label = "Ki"},
    {group = 14, color = 15, profession = 'NONE', labor = 'NONE', skill = 'MISC_WEAPON', label = "Mi"},
    {group = 14, color = 15, profession = 'NONE', labor = 'NONE', skill = 'MELEE_COMBAT', label = "Fg"},
    {group = 14, color = 15, profession = 'NONE', labor = 'NONE', skill = 'RANGED_COMBAT', label = "Ac"},
    {group = 14, color = 15, profession = 'NONE', labor = 'NONE', skill = 'ARMOR', label = "Ar"},
    {group = 14, color = 15, profession = 'NONE', labor = 'NONE', skill = 'SHIELD', label = "Sh"},
    {group = 14, color = 15, profession = 'NONE', labor = 'NONE', skill = 'DODGING', label = "Do"},
-- Military - Misc
    {group = 15, color = 8, profession = 'NONE', labor = 'NONE', skill = 'LEADERSHIP', label = "Ld"},
    {group = 15, color = 8, profession = 'NONE', labor = 'NONE', skill = 'TEACHING', label = "Te"},
    {group = 15, color = 8, profession = 'NONE', labor = 'NONE', skill = 'KNOWLEDGE_ACQUISITION', label = "St"},
    {group = 15, color = 8, profession = 'NONE', labor = 'NONE', skill = 'DISCIPLINE', label = "Di"},
    {group = 15, color = 8, profession = 'NONE', labor = 'NONE', skill = 'CONCENTRATION', label = "Co"},
    {group = 15, color = 8, profession = 'NONE', labor = 'NONE', skill = 'SITUATIONAL_AWARENESS', label = "Ob"},
    {group = 15, color = 8, profession = 'NONE', labor = 'NONE', skill = 'COORDINATION', label = "Cr"},
    {group = 15, color = 8, profession = 'NONE', labor = 'NONE', skill = 'BALANCE', label = "Ba"},
    {group = 15, color = 8, profession = 'NONE', labor = 'NONE', skill = 'CLIMBING', label = "Cl"},
-- Social
    {group = 16, color = 3, profession = 'NONE', labor = 'NONE', skill = 'PERSUASION', label = "Pe"},
    {group = 16, color = 3, profession = 'NONE', labor = 'NONE', skill = 'NEGOTIATION', label = "Ne"},
    {group = 16, color = 3, profession = 'NONE', labor = 'NONE', skill = 'JUDGING_INTENT', label = "Ju"},
    {group = 16, color = 3, profession = 'NONE', labor = 'NONE', skill = 'LYING', label = "Li"},
    {group = 16, color = 3, profession = 'NONE', labor = 'NONE', skill = 'INTIMIDATION', label = "In"},
    {group = 16, color = 3, profession = 'NONE', labor = 'NONE', skill = 'CONVERSATION', label = "Cn"},
    {group = 16, color = 3, profession = 'NONE', labor = 'NONE', skill = 'COMEDY', label = "Cm"},
    {group = 16, color = 3, profession = 'NONE', labor = 'NONE', skill = 'FLATTERY', label = "Fl"},
    {group = 16, color = 3, profession = 'NONE', labor = 'NONE', skill = 'CONSOLE', label = "Cs"},
    {group = 16, color = 3, profession = 'NONE', labor = 'NONE', skill = 'PACIFY', label = "Pc"},
-- Noble
    {group = 17, color = 5, profession = 'TRADER', labor = 'NONE', skill = 'APPRAISAL', label = "Ap"},
    {group = 17, color = 5, profession = 'ADMINISTRATOR', labor = 'NONE', skill = 'ORGANIZATION', label = "Or"},
    {group = 17, color = 5, profession = 'CLERK', labor = 'NONE', skill = 'RECORD_KEEPING', label = "RK"},
-- Miscellaneous
    {group = 18, color = 3, profession = 'NONE', labor = 'NONE', skill = 'THROW', label = "Th"},
    {group = 18, color = 3, profession = 'NONE', labor = 'NONE', skill = 'CRUTCH_WALK', label = "CW"},
    {group = 18, color = 3, profession = 'NONE', labor = 'NONE', skill = 'SWIMMING', label = "Sw"},
    {group = 18, color = 3, profession = 'NONE', labor = 'NONE', skill = 'KNAPPING', label = "Kn"},

    {group = 19, color = 6, profession = 'NONE', labor = 'NONE', skill = 'WRITING', label = "Wr"},
    {group = 19, color = 6, profession = 'NONE', labor = 'NONE', skill = 'PROSE', label = "Pr"},
    {group = 19, color = 6, profession = 'NONE', labor = 'NONE', skill = 'POETRY', label = "Po"},
    {group = 19, color = 6, profession = 'NONE', labor = 'NONE', skill = 'READING', label = "Rd"},
    {group = 19, color = 6, profession = 'NONE', labor = 'NONE', skill = 'SPEAKING', label = "Sp"},

    {group = 20, color = 5, profession = 'NONE', labor = 'NONE', skill = 'MILITARY_TACTICS', label = "MT"},
    {group = 20, color = 5, profession = 'NONE', labor = 'NONE', skill = 'TRACKING', label = "Tr"},
    {group = 20, color = 5, profession = 'NONE', labor = 'NONE', skill = 'MAGIC_NATURE', label = "Dr"},
}

SKILL_LEVELS = {
    {name = "Dabbling",     points = 500,  abbr = '0'},
    {name = "Novice",       points = 600,  abbr = '1'},
    {name = "Adequate",     points = 700,  abbr = '2'},
    {name = "Competent",    points = 800,  abbr = '3'},
    {name = "Skilled",      points = 900,  abbr = '4'},
    {name = "Proficient",   points = 1000, abbr = '5'},
    {name = "Talented",     points = 1100, abbr = '6'},
    {name = "Adept",        points = 1200, abbr = '7'},
    {name = "Expert",       points = 1300, abbr = '8'},
    {name = "Professional", points = 1400, abbr = '9'},
    {name = "Accomplished", points = 1500, abbr = 'A'},
    {name = "Great",        points = 1600, abbr = 'B'},
    {name = "Master",       points = 1700, abbr = 'C'},
    {name = "High Master",  points = 1800, abbr = 'D'},
    {name = "Grand Master", points = 1900, abbr = 'E'},
    {name = "Legendary",    points = 2000, abbr = 'U'},
    {name = "Legendary+1",  points = 2100, abbr = 'V'},
    {name = "Legendary+2",  points = 2200, abbr = 'W'},
    {name = "Legendary+3",  points = 2300, abbr = 'X'},
    {name = "Legendary+4",  points = 2400, abbr = 'Y'},
    {name = "Legendary+5",  points = 0,    abbr = 'Z'},
}

args = {...}
iargs = utils.invert(args)
penarray = dfhack.penarray
if not penarray or iargs['--lua-penarray'] then
    print('lua penarray')
    penarray = {}
    function penarray.new(width)
        self = {width = width, grid = {}}
        for i = 1, width do
            self.grid[i] = dfhack.pen.parse({})
        end
        setmetatable(self, {__index = penarray})
        return self
    end
    function penarray:set_tile(x, y, pen)
        self.grid[x] = dfhack.pen.parse(pen)
    end
    function penarray:draw(x1, y, width, height, bufx, bufy)
        local x2 = x1 + width - 1
        for x = x1, x2 do
            dfhack.screen.paintTile(self.grid[x - x1 + bufx] or {}, x, y)
        end
    end
end

function if_nil(v, default)
    if v == nil then return default else return v end
end

function check_nil(v, msg, traceback)
    if v == nil then
        (traceback and error or qerror)(msg ~= nil and msg or 'nil value')
    end
    return v
end

for id, col in pairs(SKILL_COLUMNS) do
    check_nil(tonumber(col.group), ('Column %i: Invalid group ID: %s'):format(id, col.group))
    check_nil(tonumber(col.color), ('Column %i: Invalid color ID: %s'):format(id, col.color))
    col.profession = check_nil(df.profession[col.profession], ('Column %i: Unrecognized profession: %s'):format(id, col.profession))
    col.labor = check_nil(df.unit_labor[col.labor], ('Column %i: Unrecognized labor: %s'):format(id, col.labor))
    col.skill = check_nil(df.job_skill[col.skill], ('Column %i: Unrecognized skill: %s'):format(id, col.skill))
    if col.label == nil or type(col.label) ~= 'string' or #tostring(col.label) ~= 2 then
        qerror(('Column %i: Invalid label: %s'):format(id, col.label))
    end
    if col.special == nil then col.special = false end
end

for id, lvl in pairs(SKILL_LEVELS) do
    check_nil(lvl.name, ('Skill level %i: Missing name'):format(id))
    check_nil(tonumber(lvl.points), ('Skill level %i: Invalid points: %s'):format(id, lvl.points))
    lvl.abbr = tostring(check_nil(lvl.abbr, ('Skill level %i: Missing abbreviation'):format(id))):sub(0, 1)
end

function clone_table(tbl)
    local out = {}
    for k, v in pairs(tbl) do
        out[k] = v
    end
    return out
end

if dfhack.units.getSquadName == nil then
    function dfhack.units.getSquadName(unit)
        if (unit.military.squad_id == -1) then return "" end
        local squad = df.squad.find(unit.military.squad_id);
        if not squad then return "" end
        if (#squad.alias > 0) then return squad.alias end
        return dfhack.TranslateName(squad.name, true)
    end
end

if dfhack.units.getKillCount == nil then
    function dfhack.units.getKillCount(unit)
        local histfig = df.historical_figure.find(unit.hist_figure_id)
        local count = 0
        if histfig and histfig.info.kills then
            for _, v in pairs(histfig.info.kills.killed_count) do
                count = count + v
            end
        end
        return count
    end
end

OutputString = dfhack.screen.paintString

function OutputKeyString(pen, x, y, key, str)
    if df.interface_key[key] ~= nil then key = df.interface_key[key] end
    local disp = dfhack.screen.getKeyDisplay(key)
    OutputString(COLOR_LIGHTGREEN, x, y, disp)
    OutputString(pen, x + #disp, y, ': ' .. str)
end

function process_keys(keys)
    if keys.STANDARDSCROLL_UP then keys.CURSOR_UP = true end
    if keys.STANDARDSCROLL_DOWN then keys.CURSOR_DOWN = true end
    if keys.STANDARDSCROLL_RIGHT then keys.CURSOR_RIGHT = true end
    if keys.STANDARDSCROLL_LEFT then keys.CURSOR_LEFT = true end
    if keys.STANDARDSCROLL_PAGEUP then keys.CURSOR_UP_FAST = true end
    if keys.STANDARDSCROLL_PAGEDOWN then keys.CURSOR_DOWN_FAST = true end
end

function in_bounds(x, y, coords)
    return x >= coords[1] and x <= coords[3] and y >= coords[2] and y <= coords[4]
end

function merge_sort(tbl, cmp)
    if not cmp then cmp = function(a, b) return a < b end end
    if #tbl <= 1 then return tbl end
    local left = {}
    local right = {}
    local middle = math.floor(#tbl / 2)
    for i = 1, middle do
        table.insert(left, tbl[i])
    end
    for i = middle + 1, #tbl do
        table.insert(right, tbl[i])
    end
    left = merge_sort(left, cmp)
    right = merge_sort(right, cmp)
    return merge_sort_merge(left, right, cmp)
end

function merge_sort_merge(left, right, cmp)
    local tbl = {}
    while #left > 0 and #right > 0 do
        if cmp(left[1], right[1]) then
            table.insert(tbl, table.remove(left, 1))
        else
            table.insert(tbl, table.remove(right, 1))
        end
    end
    for i = 1, #left do
        table.insert(tbl, left[i])
    end
    for i = 1, #right do
        table.insert(tbl, right[i])
    end
    return tbl
end

function make_sort_order(func, descending, ...)
    local args = {...}
    return function(a, b)
        local ret = func(a, b, table.unpack(args))
        if descending then return ret <= 0
        else return ret >= 0 end
    end
end

UnitAttrCache = defclass(UnitAttrCache)

function UnitAttrCache:init()
    self:clear()
end

function UnitAttrCache:get(unit, item)
    if self.cache[unit] == nil then self.cache[unit] = {} end
    if self.cache[unit][item] == nil then
        self.cache[unit][item] = self:lookup(unit, item)
    end
    return self.cache[unit][item]
end

function UnitAttrCache:clear()
    self.cache = {}
end

skill_cache = UnitAttrCache()
function skill_cache:lookup(unit, skill)
    local ret = {rating = 0, experience = 0}
    if unit.status.current_soul then
        for _, unit_skill in pairs(unit.status.current_soul.skills) do
            if unit_skill.id == skill and (unit_skill.experience > 0 or unit_skill.rating > 0) then
                ret.rating = math.min(unit_skill.rating + 1, #SKILL_LEVELS)
                ret.experience = unit_skill.experience
            end
        end
    end
    return ret
end

sort = {
    skill = function(u1, u2, skill)
        local level_diff = skill_cache:get(u2, skill).rating - skill_cache:get(u1, skill).rating
        if level_diff ~= 0 then return level_diff end
        return skill_cache:get(u2, skill).experience - skill_cache:get(u1, skill).experience
    end
}

Column = defclass(Column)

function Column:init(args)
    self.id = check_nil(args.id, 'No column ID given', true)
    self.callback = check_nil(args.callback, 'No callback given', true)
    self.color = check_nil(args.color, 'No color or color callback given', true)
    if type(self.color) ~= 'function' then
        local _c = self.color
        self.color = function() return _c end
    end
    self.title = check_nil(args.title, 'No title given', true)
    self.desc = args.desc or self.title
    self.allow_display = if_nil(args.allow_display, true)
    self.allow_format = if_nil(args.allow_format, true)
    self.default = if_nil(args.default, false)
    self.highlight = if_nil(args.highlight, false)
    self.right_align = if_nil(args.right_align, false)
    self.on_click = if_nil(args.on_click, function() end)
    self.cache = {}
    self.color_cache = {}
    self.disable_cache = if_nil(args.disable_cache, false)
    self.disable_color_cache = if_nil(args.disable_color_cache, false)
    self.width = #self.title
    self.max_width = if_nil(args.max_width, 0)
end

function Column:lookup(unit)
    if self.cache[unit] == nil or unit.dirty or self.disable_cache then
        self.cache[unit] = tostring(self.callback(unit))
        self.width = math.max(self.width, #self.cache[unit])
        if self.max_width > 0 then
            self.width = math.min(self.width, self.max_width)
            self.cache[unit] = self.cache[unit]:sub(0, self.max_width)
        end
    end
    return (self.right_align and (' '):rep(self.width - #self.cache[unit]) or '') .. self.cache[unit]
end

function Column:lookup_color(unit)
    if self.color_cache[unit] == nil or unit.dirty or self.disable_color_cache then
        self.color_cache[unit] = self.color(unit, self:lookup(unit))
    end
    return self.color_cache[unit]
end

function Column:populate(units)
    for _, u in pairs(units) do
        self:lookup(u)
        self:lookup_color(u)
    end
end

function Column:clear_cache()
    self.cache = {}
end

function column_wrap_func(func)
    return function(unit)
        return func(unit._native)
    end
end

function load_columns(scr)
    local columns = {}
    local env = {
        Column = function(args) table.insert(columns, Column(args)) end,
        wrap = column_wrap_func,
        manipulator = {
            view_unit = scr:callback('view_unit'),
            zoom_unit = scr:callback('zoom_unit'),
            blink_state = function() return scr.blink_state end,
        }
    }
    setmetatable(env, {__index = _ENV})
    local f, err = loadfile('hack/scripts/gui/manipulator-columns.lua', 't', env)
    if not f then
        qerror('Could not load columns: ' .. err)
    end
    f()
    if #columns < 1 then qerror('No columns found') end
    return columns
end

function get_column_ids(columns)
    local t = {}
    for _, col in pairs(columns) do
        table.insert(t, col.id)
    end
    return t
end

function get_columns(columns, ids)
    local t = {}
    for _, id in pairs(ids) do
        for _, col in pairs(columns) do
            if col.id == id then
                table.insert(t, col)
                break
            end
        end
    end
    return t
end

if not unit_fields then
    unit_fields = {}
    local dummy_unit = df.unit:new()
    for k, v in pairs(dummy_unit) do
        unit_fields[k] = true
    end
end

function unit_wrapper(u)
    local t = {}
    local custom = {}

    local function index(self, key)
        if key == '_native' then
            return u
        elseif unit_fields[key] then
            return u[key]
        else
            return custom[key]
        end
    end

    local function newindex(self, key, value)
        if key == '_native' then
            error('Cannot set unit_wrapper._native')
        elseif unit_fields[key] then
            u[key] = value
        else
            custom[key] = value
        end
    end

    setmetatable(t, {__index = index, __newindex = newindex})
    return t
end

default_columns = default_columns or 0

manipulator = defclass(manipulator, gui.FramedScreen)
manipulator.focus_path = 'manipulator'
manipulator.ATTRS = {
    frame_style = gui.BOUNDARY_FRAME,
    frame_inset = 1,
    top_margin = 2,
    bottom_margin = 2,
    left_margin = 2,
    right_margin = 2,
    list_top_margin = 3,
    list_bottom_margin = 7,
}

function manipulator:init(args)
    self.units = {}
    for i, u in pairs(args.units) do
        self.units[i + 1] = unit_wrapper(u)
    end
    self.unit_max = #self.units
    self.bounds = {}
    self.gframe = 0
    self.list_start = 1   -- unit index
    self.list_end = 1     -- unit index
    self.list_height = 1  -- list_end - list_start + 1
    self.list_idx = 1
    self.grid_start = 1   -- SKILL_COLUMNS index
    self.grid_end = 1     -- SKILL_COLUMNS index
    self.grid_width = 0   -- grid_end - grid_start + 1
    self.grid_idx = 1
    self.grid_rows = {}
    skill_cache:clear()
    for idx, u in pairs(self.units) do
        self.grid_rows[u] = penarray.new(#SKILL_COLUMNS, 1)
        if u._native == args.selected then
            self.list_idx = idx
        end
        u.allow_edit = true
        if not dfhack.units.isOwnRace(u._native) or not dfhack.units.isOwnCiv(u._native) or
                u.flags1.dead or not df.profession.attrs[u.profession].can_assign_labor then
            u.allow_edit = false
        end
        u.legendary = false
        for skill, _ in ipairs(df.job_skill) do
            if skill_cache:get(u, skill).rating >= 16 then
                u.legendary = true
            end
        end
    end
    self:draw_grid()
    self.all_columns = load_columns(self)
    self.columns = {}
    for k, c in pairs(self.all_columns) do
        if c.default then table.insert(self.columns, c) end
        c:clear_cache()
        c:populate(self.units)
    end
    if type(default_columns) ~= 'table' then
        default_columns = get_column_ids(self.columns)
    else
        self.columns = get_columns(self.all_columns, default_columns)
    end
    self:set_title('Manage Labors')
end

function manipulator:set_title(title)
    self.frame_title = 'Dwarf Manipulator - ' .. title
end

function manipulator:onRenderBody(p)
    self.gframe = self.gframe + 1
    if self.gframe > enabler.gfps then self.gframe = 0 end
    self.blink_state = (self.gframe < enabler.gfps / 3)
    local col_start_x = {}
    local x = self.left_margin
    local y = self.top_margin
    for id, col in pairs(self.columns) do
        col_start_x[id] = x
        OutputString(COLOR_GREY, x, y, col.title)
        x = x + col.width + 1
    end
    local grid_start_x = x
    self.grid_start = math.max(1, self.grid_start)
    self.grid_width = gps.dimx - x - self.right_margin + 1
    self.grid_end = math.min(self.grid_start + self.grid_width - 1, #SKILL_COLUMNS)
    if self.grid_end > #SKILL_COLUMNS then
        self.grid_start = self.grid_start - (self.grid_end - #SKILL_COLUMNS)
        self.grid_end = #SKILL_COLUMNS
    end
    for i = self.grid_start, self.grid_end do
        local col = SKILL_COLUMNS[i]
        local fg = col.color
        local bg = COLOR_BLACK
        if i == self.grid_idx then
            fg = COLOR_BLACK
            bg = COLOR_GREY
        end
        OutputString({fg = fg, bg = bg}, x, 1, col.label:sub(1, 1))
        OutputString({fg = fg, bg = bg}, x, 2, col.label:sub(2, 2))
        x = x + 1
    end
    if gps.mouse_x >= grid_start_x and gps.mouse_y >= 1 and gps.mouse_y <= 2 then
        local caption = ''
        local col = SKILL_COLUMNS[gps.mouse_x - grid_start_x + self.grid_start]
        if col.labor ~= df.unit_labor.NONE then
            caption = df.unit_labor.attrs[col.labor].caption
        elseif col.skill ~= df.job_skill.NONE then
            caption = df.job_skill.attrs[col.skill].caption_noun
        end
        OutputString(COLOR_GREY, math.min(gps.mouse_x, gps.dimx - #caption - 1), 3, caption)
    end
    y = self.list_top_margin + 1
    self.list_end = self.list_start + math.min(self.unit_max - self.list_start, gps.dimy - self.list_bottom_margin - self.list_top_margin - 2)
    self.list_height = self.list_end - self.list_start + 1
    if self.list_idx > self.list_end then
        local d = self.list_idx - self.list_end
        self.list_start = self.list_start + d
        self.list_end = self.list_end + d
    elseif self.list_idx < self.list_start then
        local d = self.list_start - self.list_idx
        self.list_start = self.list_start - d
        self.list_end = self.list_end - d
    end
    for i = self.list_start, self.list_end do
        local unit = self.units[i]
        for id, col in pairs(self.columns) do
            x = col_start_x[id]
            local fg = col:lookup_color(unit)
            local bg = COLOR_BLACK
            local text = col:lookup(unit)
            if i == self.list_idx and col.highlight then
                bg = COLOR_GREY
                fg = COLOR_BLACK
                text = text .. (' '):rep(col.width - #text)
            end
            OutputString({fg = fg, bg = bg}, x, y, text)
        end
        self.grid_rows[unit]:draw(grid_start_x, self.list_top_margin + i - self.list_start + 1,
            gps.dimx - grid_start_x - 1, 1,
            self.grid_start - 1, 0)
        y = y + 1
    end
    local unit = self.units[self.list_idx]
    local col = SKILL_COLUMNS[self.grid_idx]
    p:pen{fg = COLOR_WHITE}
    p:seek(0, gps.dimy - self.list_bottom_margin - 1)
    p:string(dfhack.units.isMale(unit._native) and string.char(11) or string.char(12)):string(' ')
    p:string(dfhack.TranslateName(unit.name)):string(', ')
    p:string(dfhack.units.getProfessionName(unit._native)):string(': ')
    if col.skill == df.job_skill.NONE then
        if col.labor ~= df.unit_labor.NONE then
            p:string(df.unit_labor.attrs[col.labor].caption, {fg = COLOR_LIGHTBLUE}):string(' ')
        end
        p:string(unit.status.labors[col.labor] and 'Enabled' or 'Not Enabled', {fg = COLOR_LIGHTBLUE})
    else
        local skill = skill_cache:get(unit, col.skill)
        local lvl = skill.rating
        local prof = df.job_skill.attrs[col.skill].caption_noun
        p:string((lvl > 0 and SKILL_LEVELS[lvl].name or 'Not') .. ' ' .. prof, {fg = COLOR_LIGHTBLUE})
        if lvl < #SKILL_LEVELS then
            p:string(' '):string(('(%i/%i)'):format(skill.experience, SKILL_LEVELS[lvl > 0 and lvl or 1].points), {fg = COLOR_LIGHTBLUE})
        end
    end
    p:newline()
    p:key('SELECT'):string(': Toggle labor ')
    p:key('SELECT_ALL'):string(': Toggle group ')
    p:key('UNITJOB_VIEW'):string(': View Unit ')
    p:key('UNITJOB_ZOOM_CRE'):string(': Go to Unit')
    p:newline()
    p:key('SECONDSCROLL_UP'):key('SECONDSCROLL_DOWN'):string(': Sort by skill')
    p:newline()
    p:key('CUSTOM_SHIFT_C'):string(': Columns ')
    self.bounds.grid = {grid_start_x, self.list_top_margin + 1, gps.dimx - 2, self.list_top_margin + self.list_height}
    self.bounds.grid_header = {self.bounds.grid[1], 1, self.bounds.grid[3], 2}
    self.bounds.columns = {}
    for id, col in pairs(self.columns) do
        self.bounds.columns[id] = {col_start_x[id], self.list_top_margin + 1,
            col_start_x[id] + col.width - 1, self.list_top_margin + self.list_height}
    end
    for _, u in pairs(self.units) do
        u.dirty = false
    end
end

function manipulator:update_grid_tile(x, y)
    if x == nil then x = self.grid_idx end
    if y == nil then y = self.list_idx end
    local unit = self.units[y]
    local fg = COLOR_WHITE
    local bg = COLOR_BLACK
    local c = string.char(0xFA)
    local skill = SKILL_COLUMNS[x].skill
    local labor = SKILL_COLUMNS[x].labor
    if skill ~= df.job_skill.NONE then
        local level = skill_cache:get(unit, skill).rating
        c = level > 0 and SKILL_LEVELS[level].abbr or '-'
    end
    if labor ~= df.unit_labor.NONE then
        if unit.status.labors[labor] then
            bg = COLOR_GREY
            if skill == df.job_skill.NONE then
                c = string.char(0xF9)
            end
        end
    else
        bg = COLOR_CYAN
    end
    if x == self.grid_idx and y == self.list_idx then
        fg = COLOR_LIGHTBLUE
    end
    self.grid_rows[unit]:set_tile(x - 1, 0, {fg = fg, bg = bg, ch = c})
end

function manipulator:update_unit_grid_tile(unit, x)
    for y, u in pairs(self.units) do
        if u == unit then
            self:update_grid_tile(x, y)
            return
        end
    end
    error('Could not find unit in unit list')
end

function manipulator:draw_grid()
    for y = 1, #self.units do
        for x = 1, #SKILL_COLUMNS do
            self:update_grid_tile(x, y)
        end
    end
end

function manipulator:onInput(keys)
    local old_x = self.grid_idx
    local old_y = self.list_idx
    local old_unit = self.units[self.list_idx]
    process_keys(keys)
    if keys.LEAVESCREEN then
        self:dismiss()
    elseif keys.CURSOR_UP or keys.CURSOR_DOWN or keys.CURSOR_UP_FAST or keys.CURSOR_DOWN_FAST then
        self.list_idx = self.list_idx + (
            ((keys.CURSOR_UP or keys.CURSOR_UP_FAST) and -1 or 1)
            * ((keys.CURSOR_UP_FAST or keys.CURSOR_DOWN_FAST) and 10 or 1)
        )
        if self.list_idx < 1 then
            if keys.CURSOR_UP_FAST and self.list_idx > -9 then
                self.list_idx = 1
            else
                self.list_idx = self.unit_max
            end
        elseif self.list_idx > self.unit_max then
            if keys.CURSOR_DOWN_FAST and self.list_idx < self.unit_max + 10 then
                self.list_idx = self.unit_max
            else
                self.list_idx = 1
            end
        end
        if self.list_idx > self.list_end then
            self.list_start = self.list_idx - self.list_height + 1
        elseif self.list_idx < self.list_start then
            self.list_start = self.list_idx
        end
    elseif keys.CURSOR_LEFT or keys.CURSOR_RIGHT or keys.CURSOR_LEFT_FAST or keys.CURSOR_RIGHT_FAST then
        self.grid_idx = self.grid_idx + (
            ((keys.CURSOR_LEFT or keys.CURSOR_LEFT_FAST) and -1 or 1)
            * ((keys.CURSOR_LEFT_FAST or keys.CURSOR_RIGHT_FAST) and 10 or 1)
        )
        if self.grid_idx < 1 then
            self.grid_idx = 1
        elseif self.grid_idx > #SKILL_COLUMNS then
            self.grid_idx = #SKILL_COLUMNS
        end
        if self.grid_idx > self.grid_end then
            self.grid_start = self.grid_idx - self.grid_width + 1
        elseif self.grid_idx < self.grid_start then
            self.grid_start = self.grid_idx
        end
    elseif keys.SELECT then
        self:toggle_labor(self.grid_idx, self.list_idx)
    elseif keys.SELECT_ALL then
        self:toggle_labor_group(self.grid_idx, self.list_idx)
    elseif keys.CUSTOM_SHIFT_C then
        manipulator_columns{parent = self}:show()
    elseif keys.UNITJOB_VIEW then
        self:view_unit(self.units[self.list_idx])
    elseif keys.UNITJOB_ZOOM_CRE then
        self:zoom_unit(self.units[self.list_idx])
    elseif keys.SECONDSCROLL_UP or keys.SECONDSCROLL_DOWN then
        self:sort_skill(SKILL_COLUMNS[self.grid_idx].skill, keys.SECONDSCROLL_UP)
        self:update_unit_grid_tile(old_unit, old_x)
    elseif keys._MOUSE_L or keys._MOUSE_R then
        self:onMouseInput(gps.mouse_x, gps.mouse_y,
            {left = keys._MOUSE_L, right = keys._MOUSE_R}, dfhack.internal.getModifiers())
    end
    self:update_grid_tile(old_x, old_y)
    self:update_grid_tile()
end

function manipulator:onMouseInput(x, y, buttons, mods)
    local old_grid_col = self.grid_idx
    local old_grid_row = self.list_idx
    local old_unit = self.units[old_grid_row]
    local grid_col = x - self.bounds.grid[1] + self.grid_start
    local grid_row = y - self.bounds.grid[2] + self.list_start
    if in_bounds(x, y, self.bounds.grid) then
        if buttons.left then
            if mods.shift then
                self:toggle_labor_group(grid_col, grid_row)
            else
                self:toggle_labor(grid_col, grid_row)
            end
        elseif buttons.right then
            self.grid_idx = grid_col
            self.list_idx = grid_row
            self:update_grid_tile(old_grid_col, old_grid_row)
            self:update_grid_tile()
        end
    elseif in_bounds(x, y, self.bounds.grid_header) then
        if buttons.right or mods.shift then
            self:sort_skill(SKILL_COLUMNS[grid_col].skill, false)
        else
            self:sort_skill(SKILL_COLUMNS[grid_col].skill, true)
        end
        self:update_unit_grid_tile(old_unit, old_grid_col)
    else
        for id, col in pairs(self.columns) do
            if in_bounds(x, y, self.bounds.columns[id]) then
                col.on_click(self.units[grid_row], buttons, mods)
            end
        end
    end
end

function manipulator:sort_skill(skill, descending)
    self.units = merge_sort(self.units, make_sort_order(sort.skill, descending, skill))
end

function manipulator:is_valid_labor(labor)
    if labor == df.unit_labor.NONE then return false end
    local ent = df.global.ui.main.fortress_entity
    if ent and ent.entity_raw and not ent.entity_raw.jobs.permitted_labor[labor] then
        return false
    end
    return true
end

function manipulator:set_labor(x, y, state)
    local col = SKILL_COLUMNS[x] or error('Invalid column ID: ' .. x)
    local unit = self.units[y] or error('Invalid unit ID: ' .. y)
    if not unit.allow_edit then return end
    if not self:is_valid_labor(col.labor) then return end
    if col.special then
        if state then
            for i, c in pairs(SKILL_COLUMNS) do
                if c.special then
                    self:set_labor(i, y, false)
                end
            end
        end
        unit.military.pickup_flags.update = true
    end
    unit.status.labors[col.labor] = state
    self:update_grid_tile(x, y)
end

function manipulator:toggle_labor(x, y)
    local col = SKILL_COLUMNS[x] or error('Invalid column ID: ' .. x)
    local unit = self.units[y] or error('Invalid unit ID: ' .. y)
    if not self:is_valid_labor(col.labor) then return end
    self:set_labor(x, y, not unit.status.labors[col.labor])
end

function manipulator:toggle_labor_group(x, y)
    local col = SKILL_COLUMNS[x] or error('Invalid column ID: ' .. x)
    local unit = self.units[y] or error('Invalid unit ID: ' .. y)
    local labor = col.labor
    local group = col.group
    if not self:is_valid_labor(labor) then return end
    local state = not unit.status.labors[labor]
    for x, col in pairs(SKILL_COLUMNS) do
        if col.group == group then
            self:set_labor(x, y, state)
        end
    end
end

function manipulator:parent_select_unit(unit)
    local parent = self._native.parent
    for id, u in pairs(parent.units[parent.page]) do
        if u == unit._native then
            parent.cursor_pos[parent.page] = id
            return true
        end
    end
    return false
end

function manipulator:view_unit(u)
    local parent = self._native.parent
    if self:parent_select_unit(u) then
        u.dirty = true
        gui.simulateInput(parent, {UNITJOB_VIEW = true})
    end
end

function manipulator:zoom_unit(u)
    local parent = self._native.parent
    if self:parent_select_unit(u) then
        gui.simulateInput(parent, {UNITJOB_ZOOM_CRE = true})
        self:dismiss()
    end
end

function manipulator:onResize(...)
    self.super.onResize(self, ...)
end

function manipulator:onDismiss(...)
    default_columns = get_column_ids(self.columns)
    self.super.onDismiss(...)
end

function manipulator:onGetSelectedUnit()
    local u = self.units[self.list_idx]
    u.dirty = true
    return u._native
end

manipulator_columns = defclass(manipulator_columns, gui.FramedScreen)
manipulator_columns.ATTRS = {
    frame_title = 'Dwarf Manipulator - Columns',
}

function manipulator_columns:init(args)
    self.parent = args.parent
    if getmetatable(self.parent) ~= manipulator then error('Invalid context') end
    self.columns = self.parent.columns
    self.all_columns = self.parent.all_columns
    self.col_idx = 1
    self.all_col_idx = 1
    self.cur_list = 1
end

function manipulator_columns:get_selection()
    if self.cur_list == 1 then
        return self.columns[self.col_idx]
    else
        return self.all_columns[self.all_col_idx]
    end
end

function manipulator_columns:onRenderBody(p)
    local x1 = 2
    local x2 = math.floor(gps.dimx / 2) - 1
    local x3 = gps.dimx - 2
    local y1 = 2
    local y2 = gps.dimy - 5
    self.bounds = {x1 = x1, x2 = x2, x3 = x3, y1 = y1, y2 = y2}
    self.bounds.col1 = {x1, y1, x2, y1 + #self.columns - 1}
    self.bounds.col1_full = {x1, y1, x2, y2}
    self.bounds.col2 = {x2 + 1, y1, x3, y1 + #self.all_columns - 1}
    self.bounds.col2_full = {x2 + 1, y1, x3, y2}
    local y = y1
    for i = 1, #self.columns do
        if self.drag_y == y then y = y + 1 end
        OutputString((self.cur_list == 1 and i == self.col_idx and COLOR_LIGHTGREEN) or COLOR_GREEN,
            x1, y, self.columns[i].title:sub(1, x2 - x1 - 1))
        y = y + 1
    end
    for i = 1, #self.all_columns do
        OutputString((self.cur_list == 2 and i == self.all_col_idx and COLOR_YELLOW) or COLOR_BROWN,
            x2 + 1, y1 + i - 1, self.all_columns[i].title:sub(1, x3 - x2 - 1))
    end
    local col = self:get_selection()
    local c_color = self.cur_list == 1 and COLOR_WHITE or COLOR_DARKGREY
    local a_color = self.cur_list == 2 and COLOR_WHITE or COLOR_DARKGREY
    OutputKeyString(c_color, x1, y2, 'CURSOR_UP_FAST', 'Move up')
    OutputKeyString(c_color, x1, y2 + 1, 'CURSOR_DOWN_FAST', 'Move down')
    OutputKeyString(c_color, x1, y2 + 2, 'CUSTOM_R', 'Remove')
    OutputKeyString(a_color, x2 + 1, y2, 'CUSTOM_A', 'Add')
    if col then
        OutputString(COLOR_GREY, x1, y2 + 3, col.desc)
    end
    if enabler.mouse_lbut_down == 1 then
        self:handle_drag()
    elseif enabler.mouse_lbut_down == 0 and self.in_drag then
        self:handle_drop()
    end
end

function manipulator_columns:handle_drag()
    local x = gps.mouse_x
    local y = gps.mouse_y
    if not self.in_drag and (in_bounds(x, y, self.bounds.col1) or
            in_bounds(x, y, self.bounds.col2)) then
        print('start drag')
        self.in_drag = true
        self.drag_add = in_bounds(x, y, self.bounds.col2)
        local col_idx = y - self.bounds.y1 + 1
        local col_list = self.drag_add and self.all_columns or self.columns
        self.drag_text = col_list[col_idx].title
        if in_bounds(x, y, self.bounds.col1) then
            self.drag_column = table.remove(self.columns, col_idx)
        elseif self.drag_add then
            self.drag_column = self.all_columns[col_idx]
        end
    end
    if self.in_drag then
        if in_bounds(x, y, self.bounds.col1_full) then
            self.drag_y = y
        end
        OutputString(COLOR_YELLOW, x, y, self.drag_text)
    end
end

function manipulator_columns:handle_drop()
    local x = gps.mouse_x
    local y = gps.mouse_y
    local col_idx = y - self.bounds.y1 + 1
    self.in_drag = false
    if in_bounds(x, y, self.bounds.col1_full) then
        table.insert(self.columns, math.min(#self.columns + 1, col_idx), self.drag_column)
    end
    self.drag_column = nil
    self.drag_y = nil
end

function manipulator_columns:onInput(keys)
    process_keys(keys)
    if keys.LEAVESCREEN then
        self:dismiss()
        return
    elseif keys.CURSOR_LEFT or keys.CURSOR_RIGHT then
        self.cur_list = 3 - self.cur_list
    elseif keys.CURSOR_UP or keys.CURSOR_DOWN then
        if self.cur_list == 1 then
            self.col_idx = self.col_idx + (keys.CURSOR_UP and -1 or 1)
            if self.col_idx < 1 then
                self.col_idx = #self.columns
            elseif self.col_idx > #self.columns then
                self.col_idx = 1
            end
        else
            self.all_col_idx = self.all_col_idx + (keys.CURSOR_UP and -1 or 1)
            if self.all_col_idx < 1 then
                self.all_col_idx = #self.all_columns
            elseif self.all_col_idx > #self.all_columns then
                self.all_col_idx = 1
            end
        end
    end
    if self.cur_list == 1 then
        if keys.CURSOR_UP_FAST and self.col_idx > 1 then
            tmp = self.columns[self.col_idx - 1]
            self.columns[self.col_idx - 1] = self.columns[self.col_idx]
            self.columns[self.col_idx] = tmp
            self.col_idx = self.col_idx - 1
        elseif keys.CURSOR_DOWN_FAST and self.col_idx < #self.columns then
            tmp = self.columns[self.col_idx + 1]
            self.columns[self.col_idx + 1] = self.columns[self.col_idx]
            self.columns[self.col_idx] = tmp
            self.col_idx = self.col_idx + 1
        elseif keys.CUSTOM_R then
            table.remove(self.columns, self.col_idx)
            self.col_idx = math.min(self.col_idx, #self.columns)
        end
    else
        if keys.CUSTOM_A or keys.SELECT then
            table.insert(self.columns, self.col_idx + 1, self:get_selection())
            self.col_idx = self.col_idx + 1
        end
    end
    self.super.onInput(self, keys)
end

scr = dfhack.gui.getCurViewscreen()
if df.viewscreen_unitlistst:is_instance(scr) then
    cur = manipulator{units = scr.units[scr.page], selected = scr.units[scr.page][scr.cursor_pos[scr.page]]}
    cur:show()
else
    dfhack.printerr('Invalid context')
end
