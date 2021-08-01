--[[
    =================
    By: Sr. Naja
    =================
]]

function onLookPokeball(player, item, pokeball, gender, level,  nature, pokedate)
local genders = GENDER_CONFIG[gender]
if not genders then
return
end
local natures = NATURE_CONFIG[nature]
if not natures then
    return
end
item:setAttribute(ITEM_ATTRIBUTE_NAME, item:getName() .. " with one " .. pokeball)
item:setAttribute(ITEM_ATTRIBUTE_DESCRIPTION, "level : " .. level .. "."..
"\n" .. "Gender : " .. genders.genderName .. "."..
"\n" .. "Nature : " .. natures.natureName .. "." ..
"\n" .. "Owner : " .. player:getName() .. "."..
"\n" .. "Captured in : " .. pokedate ..". ")
end

function Monster:gender(pokegender, player)

local genders = GENDER_CONFIG[pokegender]

if not genders then

return player:sendTextMessage(MESSAGE_STATUS_SMALL, player:getName() .. " Get in touch with a staff member ( bug in the gender system ! )") and true

end

self:setSkull(pokegender)

local pokemonlife = self:getMaxHealth()

if(pokegender == 1)then

return self:changeSpeed(genders.percent)

end

if(pokegender == 2)then

self:setHealth(genders.percent)

return self:setMaxHealth(pokemonlife + genders.percent)

end

end

function Monster:natureSystem(player, pokenature)

local nature = NATURE_CONFIG[pokenature]

if not nature then

player:sendTextMessage(MESSAGE_STATUS_SMALL, player:getName() " Nature system com problema!")

return false

end

self:changeSpeed(nature.speed)

self:setHealth(nature.defense)

return true

end

function Monster:levelSystem(player, pokelevel)
local slot = player:getSlotItem(CONST_SLOT_FEET)
if not slot then
return false
end
if(pokelevel <= 0)then
slot:setAttribute(ITEM_ATTRIBUTE_POKELEVEL, 1)
return false
end
local pokeball = slot:getAttribute(ITEM_ATTRIBUTE_POKEBALL)
self:setName(pokeball .. "a")
return true
end

function doTransformPokemon(players)
local player = Creature(players)
local pk = player:getSummons()[1]
if not pk then return false end
local slot = player:getSlotItem(CONST_SLOT_FEET)
if not slot then
return player:sendTextMessage(MESSAGE_STATUS_SMALL,player:getName() .. " this is not a pokeball!") and true
end
local pokeball = slot:getAttribute(ITEM_ATTRIBUTE_POKEBALL)
local pklevel = slot:getAttribute(ITEM_ATTRIBUTE_POKELEVEL)
local pos_player = player:getPosition()
pos_player:sendMagicEffect(174)
pos_player:sendMagicEffect(1)
local pokemons_evolution = EVOLUTION_POKEMON[pokeball]
if not pokemons_evolution then
return player:sendTextMessage(MESSAGE_STATUS_SMALL,player:getName() .. " This pokemon does not exist in the table") and true
end
slot:setAttribute(ITEM_ATTRIBUTE_POKEBALL, pokemons_evolution.evolution)
local evolution = slot:getAttribute(ITEM_ATTRIBUTE_POKEBALL)
local pkgender = slot:getAttribute(ITEM_ATTRIBUTE_GENDER)
local pknature = slot:getAttribute(ITEM_ATTRIBUTE_POKENATURE)
local pkdate = slot:getAttribute(ITEM_ATTRIBUTE_POKEDATE)
slot:removeAttribute(ITEM_ATTRIBUTE_NAME)
local ball = Item(slot.uid)
onLookPokeball(player, ball, evolution, pkgender, pklevel, pknature, pkdate)
pk:returnPokemon(player, ball)
GoPokemon(player, ball)
player:sendTextMessage(MESSAGE_STATUS_SMALL,player:getName() .. " Congratulations, you managed to evolve your " .. pokeball .. " for " .. pokemons_evolution.evolution .. ".")
end

function Item:adjustMove(pokeball_name)

    local table_move_teste = MOVE_CONFIG[pokeball_name]

    if(not(table_move_teste))then
        return
    end

    return self:setAttribute(ITEM_ATTRIBUTE_POKEMOVECOMBAT, "TESTE")
end