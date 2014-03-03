--[[	
    Kayle The Judicator, Judgement Day Has Come !!! 1.3 by Jaikor 
    Credtis to HeX Original Plugin and Pain for his work ( this is a improved version by me )
	Special thanks to Felina, Chrisokgo and gespierd and all the others who help testing the script for me. 
	Copyright 2013
	Changelog :
	1.0 - inicial release
    1.1 - Bug fixes, ult fixed, reborn & revamp compatible
    1.2 - Bug Fixes, should work for free users, revamp and reborn, new ult logic it should only cast R on % hp if detects enemy in range
    1.2a - BETA FIX
	1.3 - no more Auto Carry now StandAlone Script
	1.3a - HEAL added to ally 
]]--

if myHero.charName ~= "Kayle" then return end

local rRange = 900
local qRange,wRange,eRange,rRange = 650, 900, 525, 900

function OnLoad()
    minionMobs = {}
	minionClusters = {}
	Vars()
	PrintChat("<font color='#CCCCCC'> >> Kayle The Judicator v1.3a loaded! <<</font>")
	KayleConfig = scriptConfig("Kayle - The Judicator", "Kayle_The_Judicator")
	KayleConfig:addSubMenu("Basic Settings", "Combo")
	KayleConfig.Combo:addParam("Combo", "Combo", SCRIPT_PARAM_ONKEYDOWN, false, 32)
	KayleConfig.Combo:addParam("attacks", "Use auto attacks", SCRIPT_PARAM_ONOFF, true)
	KayleConfig.Combo:addParam("Harass", "Harass", SCRIPT_PARAM_ONKEYDOWN, false, 88)
	KayleConfig.Combo:addParam("useQ", "Use - Reckoning", SCRIPT_PARAM_ONOFF, true)
	KayleConfig.Combo:addParam("useW", "Use - Devine Blessing", SCRIPT_PARAM_ONOFF, true)
	KayleConfig.Combo:addParam("useE", "Use - Righteous Fury", SCRIPT_PARAM_ONOFF, true)
	KayleConfig.Combo:addParam("useR", "Use - Intervention", SCRIPT_PARAM_ONOFF, true)
	KayleConfig.Combo:addParam("PercentofHealth", "PercentofHealth",SCRIPT_PARAM_SLICE, 25, 0, 100, 0)	
	KayleConfig.Combo:addParam("movement", "Basic Orb Walking", SCRIPT_PARAM_ONOFF, true)
	KayleConfig.Combo:permaShow("Combo")
	KayleConfig.Combo:permaShow("Harass")

	--> Heal Settings
	KayleConfig:addSubMenu("Heal Settings", "Heal")
	KayleConfig.Heal:addSubMenu("Heal Targeting Settings", "HealTargeting")
	KayleConfig.Heal:addParam("PercentofHealth", "PercentofHealth",SCRIPT_PARAM_SLICE, 25, 0, 100, 0)	
	KayleConfig.Heal.HealTargeting:addParam(myHero.charName.."healTarget", "Heal Target - ".. myHero.charName, SCRIPT_PARAM_ONOFF, true)
	for i, ally in ipairs(GetAllyHeroes()) do
		KayleConfig.Heal.HealTargeting:addParam(ally.charName.."healTarget", "Heal Target - "..ally.charName, SCRIPT_PARAM_ONOFF, true)
	end
	KayleConfig.Heal:addParam("healAllies", "Heal Allies", SCRIPT_PARAM_ONOFF, true)

	KayleConfig:addSubMenu("Farm Settings", "Farm")
	KayleConfig.Farm:addParam("Farm", "Farm - Toggle[G]", SCRIPT_PARAM_ONKEYTOGGLE, false, string.byte("G"))
	KayleConfig.Farm:addParam("eFarm", "Use - Righteous Fury", SCRIPT_PARAM_ONOFF, true)

	KayleConfig:addSubMenu("KS Settings", "KS")
	KayleConfig.KS:addParam("autoignite", "Ignite when Killable", SCRIPT_PARAM_ONOFF, true)
	KayleConfig.KS:addParam("killSteal", "KS", SCRIPT_PARAM_ONOFF, true)

	KayleConfig:addSubMenu("Draw Settings", "Draw")
	KayleConfig.Draw:addParam("drawText", "Draw Enemy Text", SCRIPT_PARAM_ONOFF, true)
	KayleConfig.Draw:addParam("qDraw", "Draw - Reckoning", SCRIPT_PARAM_ONOFF, true)
    KayleConfig.Draw:addParam("cDraw", "Draw - Enemy Text", SCRIPT_PARAM_ONOFF, true)
	
	KayleConfig:addTS(ts)
	
	lastBasicAttack = os.clock()
end

function OnProcessSpell(unit, spell)
	if unit.isMe and (spell.name:find("Attack") ~= nil) then
		swing = 1
		lastBasicAttack = os.clock() 
	end
end

function OnTick()
	GlobalInfo()
	DamageCalculation()
	ts:update()
	if KayleConfig.KS.killSteal then KillSteal() end
	AttackDelay = 1/(myHero.attackSpeed*startAttackSpeed)
	if swing == 1 and os.clock() > lastBasicAttack + AttackDelay then
		swing = 0
	end
	
	--[[	Harass	]]--
	if ts.target ~= nil and KayleConfig.Combo.Harass  then
		if QREADY and GetDistance(ts.target) < range then
			CastSpell(_Q, ts.target)
		end
	end  
	--[[	Basic Combo	]]--
	if ts.target ~= nil and KayleConfig.Combo.Combo then
		--[[	Items	]]--
		if GetDistance(ts.target) < 600 then
			if dfgReady then CastSpell(dfgSlot, ts.target) end
			if brkReady then CastSpell(brkSlot, ts.target) end
			if hxgReady then CastSpell(hxgSlot, ts.target) end
			if bwcReady then CastSpell(bwcSlot, ts.target) end
			if stdReady then CastSpell(stdSlot) end
		end
		--[[	Abilities	]]--
		if QREADY and GetDistance(ts.target) < range then 
				CastSpell(_Q, ts.target)
		end
		if EREADY and GetDistance(ts.target) < aRange then
			CastSpell(_E)
		end
		if WREADY and GetDistance(ts.target) > wBuffer then
			CastSpell(_W, myHero)
		end
		
--[[		
		--> Farm
 if not KayleConfig.Combo.Combo and not KayleConfig.Combo.Harass then
        if KayleConfig.Farm.Farm then
                                if KayleConfig.Farm.eFarm and EREADY then FarmWithE() end
	 end
     end   
]]--	
		
			if not KayleConfig.Combo.Combo and not KayleConfig.Combo.Harass then
		if KayleConfig.Farm.Farm then
			for i, minion in pairs(enemyMinions.objects) do
				if minion and minion.valid and not minion.dead and GetDistance(minion) <= 525 then
					if KayleConfig.Farm.eFarm and EREADY then
						if minion.health < getDmg("E", minion, myHero)+getDmg("AD", minion, myHero) then
							CastSpell(_E)
							myHero:Attack(minion) 
						end
					end
				end
			end
			for i, minion in pairs(jungleMinions.objects) do
				if minion and minion.valid and not minion.dead and GetDistance(minion) <= 525 then
					if KayleConfig.Farm.eFarm and EREADY then
						CastSpell(_E) 
						myHero:Attack(minion)
					end
				end
			end
		end
	end
		
		--[[	Attacks	]]--
		if swing == 0 and KayleConfig.Combo.attacks then
			if GetDistance(ts.target) < range and GetTickCount() > nextTick then
				myHero:Attack(ts.target)
				nextTick = GetTickCount()
			end
			elseif swing == 1 and KayleConfig.Combo.movement and KayleConfig.Combo.attacks and GetTickCount() > (nextTick + 250) then
				myHero:MoveTo(mousePos.x, mousePos.z)
		end
	end
	
	if KayleConfig.Heal.healAllies then
		if KayleConfig.Heal.HealTargeting[myHero.charName.."healTarget"] then
			if healthLow(myHero) and myHero.mana >= myHero.maxMana*0.5 then CastSpell(_W, myHero) end
		end
		for i, ally in ipairs(GetAllyHeroes()) do
			if ally and Config.Heal.HealTargeting[ally.charName.."healTarget"] then
				if healthLow(ally) and myHero.mana >= myHero.maxMana*0.5 and GetDistance(ally) <= wRange then CastSpell(_W, ally) end
			end
		end
	end
	
		if KayleConfig.Combo.useR and RREADY then 
		for i, ally in ipairs(GetAllyHeroes()) do 
			if ally and not ally.dead and ally.visible and GetDistance(ally) <= rRange then 
				UltManagement(ally) 
			end
		end
		UltManagement(myHero)
	end

end

function UseItems(enemy)
	if not enemy then
		enemy = ts.target
	end
	if ValidTarget(enemy) then
		if hxgReady and GetDistance(enemy) <= 600 then CastSpell(hxgSlot, enemy) end
		if bwcReady and GetDistance(enemy) <= 450 then CastSpell(bwcSlot, enemy) end
		if brkReady and GetDistance(enemy) <= 450 then CastSpell(brkSlot, enemy) end
		if dfgReady and GetDistance(enemy) <= 600 then CastSpell(dfgSlot, enemy) end
		if tmtReady and GetDistance(enemy) <= 185 then CastSpell(tmtSlot) end
		if hdrReady and GetDistance(enemy) <= 185 then CastSpell(hdrSlot) end
	end
end

-- KillSteal function --
function KillSteal()
	if ValidTarget(ts.target) then
		if QREADY and ts.target.health <= qDmg and GetDistance(ts.target) <= qRange then 
			CastSpell(_Q, ts.target)
		elseif EREADY and ts.target.health <= eDmg and GetDistance(ts.target) <= eRange then
			CastE(ts.target)
		elseif QREADY and EREADY and ts.target.health <= (qDmg + eDmg) and GetDistance(ts.target) <= qRange then
			CastSpell(_Q, ts.target)
			CastSpell(_E)
		elseif EREADY and QREADY and ts.target.health <= (eDmg + qDmg) and GetDistance(ts.target) <= eRange then
			CastSpell(_E)
			CastSpell(_Q, ts.target)
		end
	end
end

function CountEnemies(point, range)
        local ChampCount = 0
        for j = 1, heroManager.iCount, 1 do
                local enemyhero = heroManager:getHero(j)
                if myHero.team ~= enemyhero.team and ValidTarget(enemyhero, range) then
                        if GetDistance(enemyhero, point) <= range then
                                ChampCount = ChampCount + 1
                        end
                end
        end            
        return ChampCount
end




-- Damage Calculations --
function DamageCalculation()
	for i=1, heroManager.iCount do
	local enemy = heroManager:GetHero(i)
		if ValidTarget(enemy) then
			dfgDmg, hxgDmg, bwcDmg, iDmg  = 0, 0, 0, 0
			qDmg, wDmg, eDmg = 0, 0, 0
			if QREADY then qDmg = getDmg("Q",enemy,myHero) end
            if WREADY then wDmg = getDmg("W",enemy,myHero) end
			if EREADY then eDmg = getDmg("E",enemy,myHero) end
			if dfgReady then dfgDmg = (dfgSlot and getDmg("DFG",enemy,myHero) or 0)	end
            if hxgReady then hxgDmg = (hxgSlot and getDmg("HXG",enemy,myHero) or 0) end
            if bwcReady then bwcDmg = (bwcSlot and getDmg("BWC",enemy,myHero) or 0) end
            if iReady then iDmg = (ignite and getDmg("IGNITE",enemy,myHero) or 0) end
            onspellDmg = (liandrysSlot and getDmg("LIANDRYS",enemy,myHero) or 0)+(blackfireSlot and getDmg("BLACKFIRE",enemy,myHero) or 0)
            itemsDmg = dfgDmg + hxgDmg + bwcDmg + iDmg + onspellDmg
				KillText[i] = 1 
			if enemy.health <= (qDmg + eDmg + wDmg + itemsDmg) then
				KillText[i] = 2
			elseif enemy.health <= ((qDmg*2) + eDmg + wDmg + itemsDmg) then
				KillText[i] = 3
			elseif enemy.health <= ((qDmg*2) + wDmg + eDmg + itemsDmg) then
				KillText[i] = 4
			end
		end
	end
end

--[Drawing our Range/Killable Enemies]--
function OnDraw()
	--> Ranges
	if not KayleConfig.Draw.drawText and not myHero.dead then
		if QREADY and KayleConfig.Draw.qDraw then
			DrawCircle(myHero.x, myHero.y, myHero.z, qRange, 0x0000FF)
		end
		if eReady and KayleConfig.Draw.eDraw then
			DrawCircle(myHero.x, myHero.y, myHero.z, eRange, 0x0000FF)
		end
	end
	if KayleConfig.Draw.cDraw then
		for i=1, heroManager.iCount do
			local Unit = heroManager:GetHero(i)
			if ValidTarget(Unit) then
				if waittxt[i] == 1 and (KillText[i] ~= nil or 0 or 1) then
					PrintFloatText(Unit, 0, TextList[KillText[i]])
				end
			end
			if waittxt[i] == 1 then
				waittxt[i] = 30
			else
				waittxt[i] = waittxt[i]-1
			end
		end
	end
end

---------------------------------------------
---------ULT---------------------------------
---------------------------------------------
function UltManagement(unit)
	if unit.health <= unit.maxHealth*(KayleConfig.Combo.PercentofHealth/100) and CountEnemyHeroInRange(650, unit) > 0 then CastSpell(_R, unit) end
end

function Vars()
ts = TargetSelector(TARGET_LOW_HP, 700, DAMAGE_MAGIC, true)
ts.name = "Kayle"
enemyMinions = minionManager(MINION_ENEMY, 525, myHero)
jungleMinions = minionManager(MINION_JUNGLE, 525, myHero)
qRange,wRange,eRange,rRange = 650, 900, 525, 900
QREADY, WREADY, EREADY, RREADY = false, false, false, false
TextList = {"Harass him!!", "FULL COMBO KILL!"}
KillText = {}
waittxt = {} -- prevents UI lags, all credits to Dekaron
for i=1, heroManager.iCount do waittxt[i] = i*3 end
--Spells --
range = 650
wBuffer = 400 --Wont use W unless they are this far away. 400 by default.
aRange = 525
ignite = nil
lastBasicAttack = 0
swing = 0
startAttackSpeed = 0.625
nextTick = 0
DFGREADY, BRKREADY, HXGREADY, BWCREADY, STDREADY = false, false, false, false, false
DFGSlot, BRKSlot, HXGSlot, BWCSlot, STDSlot = nil, nil, nil, nil, nil
end

function healthLow(ally)
	return ally.health <= ally.maxHealth*(KayleConfig.Heal.PercentofHealth/100)
end

function GlobalInfo()

	MouseScreen = WorldToScreen(D3DXVECTOR3(mousePos.x, mousePos.y, mousePos.z))
	QREADY = myHero:CanUseSpell(_Q) == READY 
    WREADY = myHero:CanUseSpell(_W) == READY
	EREADY = myHero:CanUseSpell(_E) == READY
	RREADY = myHero:CanUseSpell(_R) == READY
	
	iSlot = ((myHero:GetSpellData(SUMMONER_1).name:find("SummonerDot") and SUMMONER_1) or (myHero:GetSpellData(SUMMONER_2).name:find("SummonerDot") and SUMMONER_2) or nil)
	iReady = (iSlot ~= nil and myHero:CanUseSpell(iSlot) == READY)
	dfgSlot = GetInventorySlotItem(3128)
	dfgReady = (dfgSlot ~= nil and GetInventoryItemIsCastable(3128,myHero))
	lichSlot = GetInventorySlotItem(3100)
	lichReady = (lichSlot ~= nil and myHero:CanUseSpell(lichSlot) == READY)
	sheenSlot = GetInventorySlotItem(3057)
	sheenReady = (sheenSlot ~= nil and myHero:CanUseSpell(sheenSlot) == READY)
	enemyMinions:update()
	jungleMinions:update()
	
		-- Slots for Items / Pots / Wards --
	rstSlot, ssSlot, swSlot, vwSlot =    GetInventorySlotItem(2045),
									     GetInventorySlotItem(2049),
									     GetInventorySlotItem(2044),
									     GetInventorySlotItem(2043)
	dfgSlot, hxgSlot, bwcSlot, brkSlot = GetInventorySlotItem(3128),
										 GetInventorySlotItem(3146),
										 GetInventorySlotItem(3144),
										 GetInventorySlotItem(3153)
	hpSlot, mpSlot, fskSlot =            GetInventorySlotItem(2003),
							             GetInventorySlotItem(2004),
							             GetInventorySlotItem(2041)
	znaSlot, wgtSlot =                   GetInventorySlotItem(3157),
	                                     GetInventorySlotItem(3090)
	tmtSlot, hdrSlot = 					 GetInventorySlotItem(3077),
										 GetInventorySlotItem(3074)
	
	
		-- Items --
	dfgReady = (dfgSlot ~= nil and myHero:CanUseSpell(dfgSlot) == READY)
	hxgReady = (hxgSlot ~= nil and myHero:CanUseSpell(hxgSlot) == READY)
	bwcReady = (bwcSlot ~= nil and myHero:CanUseSpell(bwcSlot) == READY)
	brkReady = (brkSlot ~= nil and myHero:CanUseSpell(brkSlot) == READY)
	znaReady = (znaSlot ~= nil and myHero:CanUseSpell(znaSlot) == READY)
	wgtReady = (wgtSlot ~= nil and myHero:CanUseSpell(wgtSlot) == READY)
	tmtReady = (tmtSlot ~= nil and myHero:CanUseSpell(tmtSlot) == READY)
	hdrReady = (hdrSlot ~= nil and myHero:CanUseSpell(hdrSlot) == READY)

end


--[[
-------------------------------------------------------------------------
------------------------------ TEST -------------------------------------
-------------------------------------------------------------------------

function FarmWithE()
	for _, minion in pairs(enemyMinions.objects) do
		if minion and minion.valid and not minion.dead and EREADY and GetDistance(minion) <= aRange then
			if minion.health < (getDmg("E", minion, myHero) - 15) then 
				table.insert(minionMobs, minion)
			end
		else
			table.remove(minionMobs, minion)
		end
	end

	local closeMinion = EWidth * 1.5

	for _, minion in pairs(minionMobs) do
		local foundCluster = false
		for i, mc in ipairs(minionClusters) do
			if GetDistance(mc, minion) < closeMinion then
				mc.x = ((mc.x * mc.count) + minion.x) / (mc.count + 1)
				mc.z = ((mc.z * mc.count) + minion.z) / (mc.count + 1)
				mc.count = mc.count + 1
				foundCluster = true
				break
			end
		end

		if not foundCluster then
			local mc = {x=0, z=0, count=0}
			mc.x = minion.x
			mc.z = minion.z
			mc.count = 1
			table.insert(minionClusters, mc)
		end
	end

	if #minionClusters < 1 then return end

	local largestCluster = 0
	local largestClusterSize = 0
	for i, mc in ipairs(minionClusters) do
		if mc.count > largestClusterSize then
			largestCluster = i
			largestClusterSize = mc.count
		end
	end

	if largestClusterSize >= 1 then
		minionCluster = minionClusters[largestCluster]
		
		-- Needs to be in OnDraw to function.
		-- local minionClusterPoint = {x=minionCluster.x, y=myHero.y, z=minionCluster.z}
		-- DrawArrowsToPos(myHero, minionClusterPoint)

		CastSpell(_E)
		myHero:Attack(minion)
	end

	minionMobs = nil
	minionClusters = nil
end
]]--

