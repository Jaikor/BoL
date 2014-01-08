--[[
Script - Udyr -The Animal Spirit - Combo
                 by Jaikor

		Features:
			- Full Combo:
				- Full W + E + Q + R Combo
				- Items toggle in combo menu
			- KillSteal Settings:
				- Toggle for Auto Ignite
			- Drawing Settings:
				- Toggle to draw if enemy is killable
				- Toggle to draw Q Range if available
				- Toggle to draw W Range if available (Off by default)
				- Toggle to draw E Range if available (Off by default)
			- Other Features:
                - Auto Smite
		        - Auto HP pots on 30% hp ( will improve this to add a slider later on)
				- Auto TS Priority Arranger
				- Auto level skills for Jungle (Phoenix Jungle Style) I prefer Tiger build tho I gues it does more dmg + attack faster

				  
		Credits & Mentions
			- Burn because this is just a Improve of his script but it doesn't have all the features he had.
			- Sida / Manciuszz for orbwalking stuff.
			- Bothappy for the updated Jungle Names from his autosmite
			- Felina who tested this script and gave awesome suggestions + making the art work for post!
			- HeX for helping me fix a few stuff I got stuck
			
		Changelog:
			1.0   - First Release!


Combos: -dynamic, according to the spells you have leveled-
*E-AA-Q-AA-R-AAx4-W (Max Damage - proc 2x R flames)
*E-AA-R-AAx4-W
*E-AA-Q-AA-W
*Q-AA-R-AAx4-W
*E-AA-Q-AA-R-AAx4
*R-AAx4-W
*E-AA-Q
*Q or R
*extra: Stun Cycle --]]
--]]

if myHero.charName ~= "Udyr" then return end

local levelSequence = {4,2,4,3,4,2,4,2,4,2,2,3,1,3,3,3,1,1} --Trick2g Phoenix jungle style
local lastAttack = GetTickCount()
local ignite = nil
local stunTarget = nil
local lastCast = "none"
local AAcount = 0
local lastAnimation = ""
local lastNameTarget = myHero.name
local storedminions = {}
local walkDistance = 300
local UdyrConfig, ts
local lastWindUpTime = 0
local lastAttackCD = 0
local useDebug = false

function OnLoad()
    PrintChat("<font color='#00FF00'> >> Udyr - The Animal Spirit 1.1 Loaded!! <<</font>")
	UdyrConfig = scriptConfig("Udyr Combo", "UdyrCombo")
	UdyrConfig:addParam("Combo", "Combo", SCRIPT_PARAM_ONKEYDOWN, false, 32)
	UdyrConfig:addParam("StunCycle", "Stun Cycle press C", SCRIPT_PARAM_ONKEYDOWN, false, 67) --c
	UdyrConfig:addParam("drawCircles", "Draw circles", SCRIPT_PARAM_ONOFF, true)
	UdyrConfig:addParam("autoignite", "Auto Ignite killable", SCRIPT_PARAM_ONOFF, true)
	UdyrConfig:addParam("autoTS", "Auto Arrenge TS priority", SCRIPT_PARAM_ONOFF, true)
	UdyrConfig:addParam("autoPotions", "Use potions when HP < 30%", SCRIPT_PARAM_ONOFF, true)
	UdyrConfig:addParam("autoLevel", "Auto level spells", SCRIPT_PARAM_ONOFF, false)
	UdyrConfig:addParam("moveToMouse", "Move to Mouse", SCRIPT_PARAM_ONOFF, false)
	UdyrConfig:permaShow("Combo")
	UdyrConfig:permaShow("StunCycle")

			
	ts = TargetSelector(TARGET_LOW_HP_PRIORITY, 600, DAMAGE_PHYSICAL, true)
    ts.name = "Udyr"
    UdyrConfig:addTS(ts)
	--[[
		if UdyrConfig.autoTS then
		if #GetEnemyHeroes() > 1 then
			arrangePrioritys(#GetEnemyHeroes())
		end
	end	
	]]--
	if myHero:GetSpellData(SUMMONER_1).name:find("SummonerDot") then ignite = SUMMONER_1
	elseif myHero:GetSpellData(SUMMONER_2).name:find("SummonerDot") then ignite = SUMMONER_2 end
end

function OnTick()
	ts:update()
	if myHero.dead then return end
	QREADY = (myHero:CanUseSpell(_Q) == READY)
	WREADY = (myHero:CanUseSpell(_W) == READY)
	EREADY = (myHero:CanUseSpell(_E) == READY)
	RREADY = (myHero:CanUseSpell(_R) == READY)
	IREADY = (ignite ~= nil and myHero:CanUseSpell(ignite) == READY)

--[[	
	JungleKey =  UdyrConfig.JungleClear
	if JungleKey then JungleClear() end
]]--


	--[[ Move to Mouse ]]--
	if UdyrConfig.moveToMouse and ts.target == nil and UdyrConfig.Combo then
		myHero:MoveTo(mousePos.x, mousePos.z)
	end

	--[[ Auto Potions ]]--
	if UdyrConfig.autoPotions then
		if tickPotions == nil or (GetTickCount() - tickPotions > 1000) then
			PotionSlot = GetInventorySlotItem(2003)
			if PotionSlot ~= nil then --we have potions
				if myHero.health/myHero.maxHealth < 0.30 and not TargetHaveBuff("RegenerationPotion", myHero) and not InFountain() then
					CastSpell(PotionSlot)
				end
			end
			tickPotions = GetTickCount()
		end
	end
	
		--[[ Auto Level ]]--
	if UdyrConfig.autoLevel then
		autoLevelSetSequence(levelSequence)
	end

	--[[ Ignite ]]--
	if UdyrConfig.autoignite then
		if IREADY then
			local ignitedmg = 0
			for i = 1, heroManager.iCount, 1 do
				local enemyhero = heroManager:getHero(i)
				if ValidTarget(enemyhero,600) then
					ignitedmg = 50 + 20 * myHero.level
					if enemyhero.health <= ignitedmg then
						CastSpell(ignite, enemyhero)
					end
				end
			end
		end
	end

	--[[ Reset AA Count ]]--
	if ts.target ~= nil then
		if ts.target.name ~= lastNameTarget then
			lastNameTarget = ts.target.name
			AAcount = 0
			lastCast = "none"
		end
	else
		AAcount = 0
		lastCast = "none"
	end

	--[[ Combo ]]--
	if UdyrConfig.Combo and ts.target ~= nil then
		if GetInventoryItemIsCastable(3128) then CastSpell(GetInventorySlotItem(3128), ts.target) end
		if GetInventoryItemIsCastable(3146) then CastSpell(GetInventorySlotItem(3146), ts.target) end
		if GetInventoryItemIsCastable(3144) then CastSpell(GetInventorySlotItem(3144), ts.target) end
		if GetInventoryItemIsCastable(3153) then CastSpell(GetInventorySlotItem(3153), ts.target) end
		if GetInventoryItemIsCastable(3131) and GetDistance(ts.target) < 350 then CastSpell(GetInventorySlotItem(3131)) end
		if GetInventoryItemIsCastable(3077) and GetDistance(ts.target) < 350 then CastSpell(GetInventorySlotItem(3077)) end
		if GetInventoryItemIsCastable(3074) and GetDistance(ts.target) < 350 then CastSpell(GetInventorySlotItem(3074)) end
		if GetInventoryItemIsCastable(3143) and GetDistance(ts.target) < 350 then CastSpell(GetInventorySlotItem(3143)) end
		if GetInventoryItemIsCastable(3042) and GetDistance(ts.target) < 350 then CastSpell(GetInventorySlotItem(3042)) end
		--We have E-Q-R-W
		if myHero:GetSpellData(_Q).level >= 1 and myHero:GetSpellData(_W).level >= 1 and myHero:GetSpellData(_E).level >= 1 and myHero:GetSpellData(_R).level >= 1 then
			if EREADY and TargetHaveBuff("udyrbearstuncheck", ts.target) == false then
				CastSpell(_E)
				lastCast = "E"
				AAcount = 0
			elseif (TargetHaveBuff("udyrbearstuncheck", ts.target) == true and QREADY) and (lastCast == "E" or lastCast == "none" or lastCast == "W") and AAcount >= 1 then
				CastSpell(_Q)
				lastCast = "Q"
				AAcount = 0
			elseif (TargetHaveBuff("udyrbearstuncheck", ts.target) == true and RREADY) and lastCast == "Q" and AAcount >= 1 then
				CastSpell(_R)
				lastCast = "R"
				AAcount = 0
			elseif (TargetHaveBuff("udyrbearstuncheck", ts.target) == true and WREADY) and lastCast == "R" and AAcount >= 4 then
				CastSpell(_W)
				lastCast = "W"
				AAcount = 0
			end
			OrbWalk()
		--We have E-R-W
		elseif myHero:GetSpellData(_W).level >= 1 and myHero:GetSpellData(_E).level >= 1 and myHero:GetSpellData(_R).level >= 1 and myHero:GetSpellData(_Q).level == 0 then
			if EREADY and TargetHaveBuff("udyrbearstuncheck", ts.target) == false then
				CastSpell(_E)
				lastCast = "E"
				AAcount = 0
			elseif (TargetHaveBuff("udyrbearstuncheck", ts.target) == true and RREADY) and (lastCast == "E" or lastCast == "none" or lastCast == "W") and AAcount >= 1 then
				CastSpell(_R)
				lastCast = "R"
				AAcount = 0
			elseif (TargetHaveBuff("udyrbearstuncheck", ts.target) == true and WREADY) and lastCast == "R" and AAcount >= 4 then
				CastSpell(_W)
				lastCast = "W"
				AAcount = 0
			end
			OrbWalk()
		--We have E-Q-W
		elseif myHero:GetSpellData(_W).level >= 1 and myHero:GetSpellData(_E).level >= 1 and myHero:GetSpellData(_Q).level >= 1 and myHero:GetSpellData(_R).level == 0 then
			if EREADY and TargetHaveBuff("udyrbearstuncheck", ts.target) == false then
				CastSpell(_E)
				lastCast = "E"
				AAcount = 0
			elseif (TargetHaveBuff("udyrbearstuncheck", ts.target) == true and QREADY) and (lastCast == "E" or lastCast == "none" or lastCast == "W") and AAcount >= 1 then
				CastSpell(_Q)
				lastCast = "Q"
				AAcount = 0
			elseif (TargetHaveBuff("udyrbearstuncheck", ts.target) == true and WREADY) and lastCast == "Q" and AAcount >= 1 then
				CastSpell(_W)
				lastCast = "W"
				AAcount = 0
			end
			OrbWalk()
		--We have Q-W-R
		elseif myHero:GetSpellData(_W).level >= 1 and myHero:GetSpellData(_E).level == 0 and myHero:GetSpellData(_Q).level >= 1 and myHero:GetSpellData(_R).level >= 1 then
			if QREADY and ((lastCast == "R" and AAcount >= 4) or lastCast == "none") then
				CastSpell(_Q)
				lastCast = "Q"
				AAcount = 0
			elseif WREADY and lastCast == "Q" and AAcount >= 1 then
				CastSpell(_W)
				lastCast = "W"
				AAcount = 0
			elseif RREADY and lastCast == "W" then
				CastSpell(_R)
				lastCast = "R"
				AAcount = 0
			end
			OrbWalk()
		--We have E-Q-R
		elseif myHero:GetSpellData(_W).level == 0 and myHero:GetSpellData(_E).level >=1 and myHero:GetSpellData(_Q).level >= 1 and myHero:GetSpellData(_R).level >= 1 then
			if EREADY and TargetHaveBuff("udyrbearstuncheck", ts.target) == false then
				CastSpell(_E)
				lastCast = "E"
				AAcount = 0
			elseif TargetHaveBuff("udyrbearstuncheck", ts.target) == true and QREADY and (((lastCast == "E" or lastCast == "none") and AAcount >= 1) or (lastCast == "R" and AAcount >= 4)) then
				CastSpell(_Q)
				lastCast = "Q"
				AAcount = 0
			elseif TargetHaveBuff("udyrbearstuncheck", ts.target) == true and RREADY and lastCast == "Q" and AAcount >= 1 then
				CastSpell(_R)
				lastCast = "R"
				AAcount = 0
			end
			OrbWalk()
		--We have R-W
		elseif myHero:GetSpellData(_W).level >= 1 and myHero:GetSpellData(_R).level >= 1 and myHero:GetSpellData(_Q).level == 0 and myHero:GetSpellData(_E).level == 0 then
			if RREADY and (lastCast == "none" or lastCast == "W") and AAcount >= 0 then
				CastSpell(_R)
				lastCast = "R"
				AAcount = 0
			elseif WREADY and lastCast == "R" and AAcount >= 4 then
				CastSpell(_W)
				lastCast = "W"
				AAcount = 0
			end
			OrbWalk()
		--We have E-Q
		elseif myHero:GetSpellData(_W).level == 0 and myHero:GetSpellData(_R).level == 0 and myHero:GetSpellData(_Q).level >= 1 and myHero:GetSpellData(_E).level >= 1 then
			if EREADY TargetHaveBuff("udyrbearstuncheck", ts.target) == false then
				CastSpell(_E)
				lastCast = "E"
				AAcount = 0
			elseif TargetHaveBuff("udyrbearstuncheck", ts.target) == true and QREADY and (lastCast == "E" or lastCast == "none" or lastCast == "Q") and AAcount >= 1 then
				CastSpell(_Q)
				lastCast = "Q"
				AAcount = 0
			end
			OrbWalk()
		--We have Q or R
		elseif (myHero:GetSpellData(_Q).level >= 1 or myHero:GetSpellData(_R).level >= 1) and myHero:GetSpellData(_W).level == 0 and myHero:GetSpellData(_E).level == 0 then
			if QREADY and AAcount >= 0 then CastSpell(_Q) AAcount = 0 end
			if RREADY and AAcount >= 1 then CastSpell(_R) AAcount = 0 end
			OrbWalk()
		end
	end

	--[[ Stun Cycle ]]--
	if UdyrConfig.StunCycle then
		stunTarget = findClosestEnemy()
		if stunTarget ~= nil and GetDistance(stunTarget) <= 600 then
			if EREADY then
				CastSpell(_E)
				lastCast = "E"
			end
			myHero:Attack(stunTarget)
		end
	end
	
--[[
	-- Jungle Farming --
	function JungleClear()
	local JungleMob = GetJungleMobs()
    if JungleMob ~= nil then
 		if (myHero:GetSpellData(_Q).level >= 1 or myHero:GetSpellData(_R).level >= 1) and myHero:GetSpellData(_W).level == 0 and myHero:GetSpellData(_E).level == 0 then
	    if QREADY and AAcount >= 0 then CastSpell(_Q, JungleMob) AAcount = 0 end
		if RREADY and AAcount >= 1 then CastSpell(_R, JungleMob) AAcount = 0 end
			OrbWalk()
		end
    myHero:Attack(JungleMob)
    end
    end
]]--	
end

-- Get Jungle Mob --
function GetJungleMobs()
        return {"Dragon6.1.1", "Worm12.1.1", "GiantWolf8.1.3", "wolf8.1.1", "wolf8.1.2", "AncientGolem7.1.1", "YoungLizard7.1.2", "YoungLizard7.1.3", "Wraith9.1.3", "LesserWraith9.1.1", "LesserWraith9.1.2",
        "LesserWraith9.1.4", "LizardElder10.1.1", "YoungLizard10.1.2", "YoungLizard10.1.3", "Golem11.1.2", "SmallGolem11.1.1", "GiantWolf2.1.3", "wolf2.1.1",
        "wolf2.1.2", "AncientGolem1.1.1", "YoungLizard1.1.2", "YoungLizard1.1.3", "Wraith3.1.3", "LesserWraith3.1.1", "LesserWraith3.1.2", "LesserWraith3.1.4",
        "LizardElder4.1.1", "YoungLizard4.1.2", "YoungLizard4.1.3", "Golem5.1.2", "SmallGolem5.1.1"}
end

function OrbWalk()
	if not TargetHaveBuff("udyrbearstuncheck", ts.target) then
	if EREADY and not TargetHaveBuff("udyrbearstuncheck", ts.target) then
			CastSpell(_E) or myHero:Attack(ts.target)
	else
		if GetDistance(ts.target) <= myHero.range + 65 then
			if timeToShoot() then
				myHero:Attack(ts.target)
			elseif heroCanMove() then
				moveToCursor()
			end
		else
			myHero:Attack(ts.target)
		end
	end
end
end


function findClosestEnemy()
	local closestEnemy = nil
	local currentEnemy = nil
	for i=1, heroManager.iCount do
		currentEnemy = heroManager:GetHero(i)
		if ValidTarget(currentEnemy, 600) then
			if closestEnemy == nil then
				closestEnemy = currentEnemy
			elseif GetDistance(currentEnemy) < GetDistance(closestEnemy) then
				closestEnemy = currentEnemy
			end
		end
	end
	return closestEnemy
end



function OnDraw()
	if useDebug then
		DrawText("AutoAttack Count: "..AAcount,17,WINDOW_W - (WINDOW_W/3*2.45),WINDOW_H - (WINDOW_H/13.3),ARGB(0xFF,0xFF,0xF0,0x00))
		DrawText("Last Cast: "..lastCast,17,WINDOW_W - (WINDOW_W/3*2.45),WINDOW_H - (WINDOW_H/7.3),ARGB(0xFF,0xFF,0xF0,0x00))
		DrawText("Last Target Name: "..tostring(lastNameTarget),17,WINDOW_W - (WINDOW_W/3*2.45),WINDOW_H - (WINDOW_H/5.3),ARGB(0xFF,0xFF,0xF0,0x00))
		if ts.target ~= nil then
			if TargetHaveBuff("udyrbearstuncheck", ts.target) then
				DrawText("Enemy STUNNED Recently",17,WINDOW_W - (WINDOW_W/3*2.45),WINDOW_H - (WINDOW_H/9.3),ARGB(0xFF,0xFF,0xF0,0x00))
			else
				DrawText("Enemy NO stunned",17,WINDOW_W - (WINDOW_W/3*2.45),WINDOW_H - (WINDOW_H/9.3),ARGB(0xFF,0xFF,0xF0,0x00))
			end
		end
	end
	if not myHero.dead and UdyrConfig.drawCircles then
		if ts.target ~= nil then
			DrawCircle(ts.target.x, ts.target.y, ts.target.z, 150, 0x7A24DB)
		end
		DrawCircle(myHero.x, myHero.y, myHero.z, 600, 0xC2743C)
	end
end

----------------------------------------------------------------------------------------------------------
--[[ Orbwalking ]]----------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------
function OrbWalking(Target)
	if TimeToAttack() and GetDistance(Target) <= myHero.range + GetDistance(myHero.minBBox) then
		myHero:Attack(Target)
    elseif heroCanMove() then
        moveToCursor()
    end
end

function TimeToAttack()
    return (GetTickCount() + GetLatency()/2 > lastAttack + lastAttackCD)
end

function timeToShoot()
	return (GetTickCount() + GetLatency()/2 > lastAttack + lastAttackCD)
end

function heroCanMove()
	return (GetTickCount() + GetLatency()/2 > lastAttack + lastWindUpTime + 20)
end

function moveToCursor()
	if GetDistance(mousePos) then
		local moveToPos = myHero + (Vector(mousePos) - myHero):normalized()*300
		myHero:MoveTo(moveToPos.x, moveToPos.z)
    end        
end

function OnProcessSpell(object,spell)
	if object == myHero then
		if spell.name:lower():find("attack") then
			lastAttack = GetTickCount() - GetLatency()/2
			lastWindUpTime = spell.windUpTime*1000
			lastAttackCD = spell.animationTime*1000
        end
    end
end

function OnAnimation(unit,animationName)
    if unit.isMe and lastAnimation ~= animationName then lastAnimation = animationName end
end

function moveToCursor()
	if GetDistance(mousePos) > 1 or lastAnimation == "Idle1" then
		local moveToPos = myHero + (Vector(mousePos) - myHero):normalized()*walkDistance
		myHero:MoveTo(moveToPos.x, moveToPos.z)
	end
end


--[[
function OnProcessSpell(object, spell)
	if myHero.dead then return end
	if object.isMe then
		if spell.name:lower():find("attack") then
			lastAttack = GetTickCount() - GetLatency()/2
			lastWindUpTime = spell.windUpTime*1000
			lastAttackCD = spell.animationTime*1000
			AAcount = AAcount + 1
		end
	end
end

function OnAnimation(unit, animationName)
	if unit.isMe and lastAnimation ~= animationName then lastAnimation = animationName end
end

function trueRange()
	return myHero.range + GetDistance(myHero.minBBox)
end

function heroCanMove()
	return (GetTickCount() + GetLatency()/2 > lastAttack + lastWindUpTime + 20)
end

function timeToShoot()
	return (GetTickCount() + GetLatency()/2 > lastAttack + lastAttackCD)
end

function moveToCursor()
	if GetDistance(mousePos) > 1 or lastAnimation == "Idle1" then
		local moveToPos = myHero + (Vector(mousePos) - myHero):normalized()*walkDistance
		myHero:MoveTo(moveToPos.x, moveToPos.z)
	end
end

]]--


--[[
local priorityTable = {
	AP = {
		"Ahri", "Akali", "Anivia", "Annie", "Brand", "Cassiopeia", "Diana", "Evelynn", "FiddleSticks", "Fizz", "Gragas", "Heimerdinger", "Karthus",
		"Kassadin", "Katarina", "Kayle", "Kennen", "Leblanc", "Lissandra", "Lux", "Malzahar", "Mordekaiser", "Morgana", "Nidalee", "Orianna",
		"Rumble", "Ryze", "Sion", "Swain", "Syndra", "Teemo", "TwistedFate", "Veigar", "Viktor", "Vladimir", "Xerath", "Ziggs", "Zyra", "MasterYi",
	},
	Support = {
		"Blitzcrank", "Janna", "Karma", "Leona", "Lulu", "Nami", "Sona", "Soraka", "Thresh", "Zilean",
	},
	Tank = {
		"Amumu", "Chogath", "DrMundo", "Galio", "Hecarim", "Malphite", "Maokai", "Nasus", "Rammus", "Sejuani", "Shen", "Singed", "Skarner", "Volibear",
		"Warwick", "Yorick", "Zac", "Nunu", "Taric", "Alistar",
	},
	AD_Carry = {
		"Ashe", "Caitlyn", "Corki", "Draven", "Ezreal", "Graves", "Jayce", "KogMaw", "MissFortune", "Pantheon", "Quinn", "Shaco", "Sivir",
		"Talon", "Tristana", "Twitch", "Urgot", "Varus", "Vayne", "Zed", "Jinx", "Lucian"
	},
	Bruiser = {
		"Darius", "Elise", "Fiora", "Gangplank", "Garen", "Irelia", "JarvanIV", "Jax", "Khazix", "LeeSin", "Nautilus", "Nocturne", "Olaf", "Poppy",
		"Renekton", "Rengar", "Riven", "Shyvana", "Trundle", "Tryndamere", "Udyr", "Vi", "MonkeyKing", "XinZhao", "Aatrox"
	},
}

function SetPriority(table, hero, priority)
	for i=1, #table, 1 do
		if hero.charName:find(table[i]) ~= nil then
			TS_SetHeroPriority(priority, hero.charName)
		end
	end
end

function arrangePrioritys(enemies)
	local priorityOrder = {
		[2] = {1,1,2,2,2},
		[3] = {1,1,2,3,3},
		[4] = {1,2,3,4,4},
		[5] = {1,2,3,4,5},
	}
	for i, enemy in ipairs(GetEnemyHeroes()) do
		SetPriority(priorityTable.AD_Carry, enemy, priorityOrder[enemies][1])
		SetPriority(priorityTable.AP,       enemy, priorityOrder[enemies][2])
		SetPriority(priorityTable.Support,  enemy, priorityOrder[enemies][3])
		SetPriority(priorityTable.Bruiser,  enemy, priorityOrder[enemies][4])
		SetPriority(priorityTable.Tank,     enemy, priorityOrder[enemies][5])
	end
end

]]--
