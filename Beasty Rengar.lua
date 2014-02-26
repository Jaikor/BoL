--[[
Beasty rengar 2.0 fix by Prototype23 and his friend I myself didn't do much
Credits to them and ofcourze Zikkah for this Beasty script
]]--

if myHero.charName ~= "Rengar" then return end

function OnLoad()
	Menu()
	Vars()
	-- Create Table structure
	for i=1, heroManager.iCount do
		local champ = heroManager:GetHero(i)
		if champ.team ~= myHero.team then
		EnemysInTable = EnemysInTable + 1
		EnemyTable[EnemysInTable] = { hero = champ, Name = champ.charName, q = 0, q2=0, w = 0, e = 0, r = 0, IndicatorText = "", IndicatorPos, NotReady = false, Pct = 0, PeelMe = false }
		
		end
	end

end

function LowHealthW()
   if not RMenu.ComboS.LowHealthW then return end
   if Fury == 5 then
      if (RMenu.ComboS.AlwaysCastLowHealthW or GetDistance(Target) < 450) then
         local health_pct = (myHero.health / myHero.maxHealth) * 100

         if health_pct < RMenu.ComboS.HealthW then
            CastSpell(_W)
         end
      end
   end
end

function OnTick()
	
	GlobalInfo()
	Calculations()
   
	if RMenu.TripleQ then
		TripleQ()
	else
	TqText = nil
   
   LowHealthW()
   
   Ks()
	if RMenu.Combo then
		Combo()
	end
    if RMenu.Harass then
        Harass()
    end
   end
end



function Combo()
if RMenu.ComboS.Orbwalk then
    OrbWalk()
end

if ValidTarget(Target) then
	if Fury <= 4 then
		if qReady and GetDistance(Target) < 250  then
			CastSpell(_Q)
		end
		if wReady and GetDistance(Target) < 450 then
			CastSpell(_W)
		end
		
		if eReady and GetDistance(Target) < 525 and GetDistance(Target) > 300 then
			CastSpell(_E, Target)
		end
		
		if Fury == 4 then
			if not qReady and not wReady and eReady and RMenu.ComboS.ForceE then
				CastSpell(_E, Target)
			end
		end
	end
	
	if Fury == 5 then
      if RMenu.ComboS.EmpPriority == 1 then
			if GetDistance(Target) < 250 then
				CastSpell(_Q)
			end
		elseif RMenu.ComboS.EmpPriority == 2 then
			if GetDistance(Target) < 450 then
				CastSpell(_W)
			end
		elseif RMenu.ComboS.EmpPriority == 3 then
			if GetDistance(Target) < 525 then
				CastSpell(_E, Target)
			end
		end
	end
	
	 if YGBREADY then CastSpell(YGBSlot) end
	 if STDREADY then CastSpell(STDSlot, Target) end
    if BRKREADY then CastSpell(BRKSlot, Target) end
    if BWCREADY then CastSpell(BWCSlot, Target) end
    if GetDistance(Target) <= 380 and TMTREADY then CastSpell(TMTSlot) end
    if GetDistance(Target) <= 380 and RSHREADY then CastSpell(RSHSlot) end 
    if HXGREADY then CastSpell(HXGSlot, Target) end        
end
end

function TripleQ()
	if Phase == 1 then
		if not qReady or not rReady or (Fury ~= 3 and Fury ~= 2) then
			TqText = "Need Q + R and only 3 or 2 stacks"
            if ValidTarget(Target) then
                Combo()
            end
            return
		elseif rReady and qReady and (Fury == 3 or Fury == 2) then
         PrintChat("TRIPLEQ. PHASE1: Entering ult with " .. Fury .. " stacks")
			DisableAttacks = true
			CastSpell(_R)
			Phase = 2
			EndTime = GetGameTimer() + 7
      else
         --do nothing...
      end
   end
	
	if Phase == 2 then
		if Fury == 5 and PassiveMax and GetGameTimer() > CastQTime then
         PrintChat("TRIPLEQ. PHASE2: CASTING Q. GET CLOSE TO ENEMY!")
			CastSpell(_Q)
			Phase = 3
		end
	end

   if Phase == 3 then
		if Fury == 2 then
         PrintChat("TRIPLEQ. PHASE3: WE HAVE TWO STACKS NOW!!!")
         DisableAttacks = false
			Phase = 4
		end
	end
	
	if Phase == 4 then
		if qReady and DisableAttacks == false and timeToShoot() then
         PrintChat("TRIPLEQ. PHASE4: WE'VE JUMPED!")
			CastSpell(_Q)
         CastSpell(_W)
         CastSpell(_E, Target)
         Phase = 5
			if ValidTarget(Target) and GetDistance(Target) < 300 then
				if STDREADY then CastSpell(STDSlot, Target) end
				if BRKREADY then CastSpell(BRKSlot, Target) end
				if BWCREADY then CastSpell(BWCSlot, Target) end
				if TMTREADY then CastSpell(TMTSlot) end
				if RSHREADY then CastSpell(RSHSlot) end 
				if HXGREADY then CastSpell(HXGSlot, Target) end    
			end	
		end
	end

   if Phase == 5 then
      if Fury == 5 and PassiveMax then
         PrintChat("TRIPLEQ. PHASE5: Last Q!")
         CastSpell(_Q)
         RMenu.TripleQ = false
      end
   end
	
	OrbWalk()

end

function Harass()
            if ValidTarget(Target) then
                    if myHero.mana <= 4 then
                            if eReady and GetDistance(Target) <= 525 and RMenu.HarassS.HarassE then
                                    CastSpell(_E, Target)
                            end
                            if wReady and myHero.mana <= 4 and GetDistance(Target) <= 300 and RMenu.HarassS.HarassW then
                                    CastSpell(_W, Target)
                            end
                           
                    end
                   
                    if myHero.mana == 5 and GetDistance(Target) <= 525 and RMenu.HarassS.HarassW then
                            CastSpell(_W, Target)
                    elseif myHero.mana == 5 and GetDistance(Target) <= 300 and RMenu.HarassS.HarassEthen then
                            CastSpell(_E, Target)
                    end
            end  
    if RMenu.HarassS.Orbwalk then
        OrbWalk()
    end
end

function Ks()
  	for i=1, EnemysInTable do
		local enemy = EnemyTable[i].hero
        
        if RMenu.KsE and ValidTarget(enemy, 525) and enemy.health < eDmg and eReady then
            CastSpell(_E, enemy)
        elseif RMenu.KsW and ValidTarget(enemy, 350) and wDmg and wReady and enemy.health < wDmg then
            CastSpell(_W, enemy)
        elseif RMenu.KsW and RMenu.KsE and ValidTarget(enemy, 350) and enemy.health < eDmg+wDmg and eReady and wReady then
            CastSpell(_E, enemy)
            CastSpell(_W, enemy)
        elseif RMenu.KsIgnite and ValidTarget(enemy, 600) and enemy.health < iDmg and  iReady then
            CastSpell(iSlot, enemy)
        end
         end   
end
------------------
-- 	Helpers 	--
------------------


function GlobalInfo()
	MouseScreen = WorldToScreen(D3DXVECTOR3(mousePos.x, mousePos.y, mousePos.z))
	ts:update()
	Target = ts.target

	qReady = myHero:CanUseSpell(_Q) == READY 
	wReady = myHero:CanUseSpell(_W) == READY
	eReady = myHero:CanUseSpell(_E) == READY
	rReady = myHero:CanUseSpell(_R) == READY

	iSlot = ((myHero:GetSpellData(SUMMONER_1).name:find("SummonerDot") and SUMMONER_1) or (myHero:GetSpellData(SUMMONER_2).name:find("SummonerDot") and SUMMONER_2) or nil)
	iReady = (iSlot ~= nil and myHero:CanUseSpell(iSlot) == READY)
	dfgSlot = GetInventorySlotItem(3128)
	dfgReady = (dfgSlot ~= nil and GetInventoryItemIsCastable(3128,myHero))
	lichSlot = GetInventorySlotItem(3100)
	lichReady = (lichSlot ~= nil and myHero:CanUseSpell(lichSlot) == READY)
	sheenSlot = GetInventorySlotItem(3057)
	sheenReady = (sheenSlot ~= nil and myHero:CanUseSpell(sheenSlot) == READY)
    trinitySlot = GetInventorySlotItem(3078)
	trinityReady = (trinitySlot ~= nil and myHero:CanUseSpell(trinitySlot) == READY)

		BWCSlot = GetInventorySlotItem(3144)
    HXGSlot = GetInventorySlotItem(3146)
    BRKSlot = GetInventorySlotItem(3153)
    YGBSlot = GetInventorySlotItem(3142) 
     
    RSHSlot = GetInventorySlotItem(3074)
    TMTSlot = GetInventorySlotItem(3077)
    STDSlot = GetInventorySlotItem(3131)
     
	YGBREADY = (YGBSlot ~= nil and myHero:CanUseSpell(YGBSlot) == READY)
    BWCREADY = (BWCSlot ~= nil and myHero:CanUseSpell(BWCSlot) == READY)
    HXGREADY = (HXGSlot ~= nil and myHero:CanUseSpell(HXGSlot) == READY)
    BRKREADY = (BRKSlot ~= nil and myHero:CanUseSpell(BRKSlot) == READY)
	YGBREADY = (YGBSlot ~= nil and myHero:CanUseSpell(YGBSlot) == READY)
    RSHREADY = (RSHSlot ~= nil and myHero:CanUseSpell(RSHSlot) == READY)
    TMTREADY = (TMTSlot ~= nil and myHero:CanUseSpell(TMTSlot) == READY)
    STDREADY = (STDSlot ~= nil and myHero:CanUseSpell(STDSlot) == READY)
	
	
	
	Fury = myHero.mana

    if ValidTarget(Target) then
    qDmg = getDmg("Q", Target, myHero)
    wDmg = getDmg("W", Target, myHero)
		eDmg = getDmg("E", Target, myHero)
		iDmg = getDmg("IGNITE", Target, myHero)    
    end
	
	if EndTime ~= nil and GetGameTimer() > EndTime then
		TqText = nil
		Phase = 1
		EndTime = nil
		CastQTime = nil
    DisableAttacks = false
	end
	

end


------------------
-- Orbwalkstuff --
------------------
function OrbWalk()
	if ValidTarget(Target) and GetDistance(Target) <= trueRange() then
		if timeToShoot() then
			myHero:Attack(Target)
		elseif heroCanMove() then
			moveToCursor()
		end
	else
		moveToCursor()
		
	end
end

function trueRange()
	
		return myHero.range + GetDistance(myHero.minBBox)
	
end

function heroCanMove()
	return (GetTickCount() + GetLatency()/2 > lastAttack + lastWindUpTime + 20)
end

function timeToShoot()
	if DisableAttacks then
		return false
	end
	return (GetTickCount() + GetLatency()/2 > lastAttack + lastAttackCD)
end

function moveToCursor()
	if GetDistance(mousePos) > 150 or lastAnimation == "Idle1" then
		local moveToPos = myHero + (Vector(mousePos) - myHero):normalized()*300
		myHero:MoveTo(moveToPos.x, moveToPos.z)
	end	
end




------------------
-- Draw+Calcs	--
------------------
function OnDraw()





	if RMenu.DmgIndic then
	for i=1, EnemysInTable do
		local enemy = EnemyTable[i].hero
		if ValidTarget(enemy) then
		--	enemy.barData = GetEnemyBarData()
			local barPos = WorldToScreen(D3DXVECTOR3(enemy.x, enemy.y, enemy.z))
            local PosX = barPos.x - 35
            local PosY = barPos.y - 50
--			local barPosOffset = GetUnitHPBarOffset(enemy)
--			local barOffset = { x = enemy.barData.PercentageOffset.x, y = enemy.barData.PercentageOffset.y }
--			local barPosPercentageOffset = { x = enemy.barData.PercentageOffset.x, y = enemy.barData.PercentageOffset.y }
--			local BarPosOffsetX = 171
--			local BarPosOffsetY = 46
--			local CorrectionY =  14.5
--			local StartHpPos = 31
--			local IndicatorPos = EnemyTable[i].IndicatorPos
			local Text = EnemyTable[i].IndicatorText
--			barPos.x = barPos.x + (barPosOffset.x - 0.5 + barPosPercentageOffset.x) * BarPosOffsetX + StartHpPos 
--			barPos.y = barPos.y + (barPosOffset.y - 0.5 + barPosPercentageOffset.y) * BarPosOffsetY + CorrectionY 
			if EnemyTable[i].NotReady == true then
                
				DrawText(tostring(Text),15,PosX ,PosY  ,orange)	
--				DrawText("|",13,barPos.x+IndicatorPos ,barPos.y ,orange)
--				DrawText("|",13,barPos.x+IndicatorPos ,barPos.y-9 ,orange)
--				DrawText("|",13,barPos.x+IndicatorPos ,barPos.y-18 ,orange)
			else
				DrawText(tostring(Text),15,PosX ,PosY ,ARGB(255,0,255,0))	
--				DrawText("|",13,barPos.x+IndicatorPos ,barPos.y ,ARGB(255,0,255,0))
--				DrawText("|",13,barPos.x+IndicatorPos ,barPos.y-9 ,ARGB(255,0,255,0))
--				DrawText("|",13,barPos.x+IndicatorPos ,barPos.y-18 ,ARGB(255,0,255,0))
			end
		end
	end
	end
	if RMenu.ShowE then
            if eReady then
                DrawCircle(myHero.x, myHero.y, myHero.z, 525, ARGB(255,0,255,0))
            else
                DrawCircle(myHero.x, myHero.y, myHero.z, 525, ARGB(255,255,0,0))
            end
        
	end
    
end

function Calculations()
	
	 
	
	for i=1, EnemysInTable do
		
		local enemy = EnemyTable[i].hero
		if ValidTarget(enemy) and enemy.visible then
        caaDmg = getDmg("AD",enemy,myHero)
				cqDmg = getDmg("Q", enemy, myHero)
        cqDmgEmp = getDmg("Q", enemy, myHero,2)
				cwDmg = getDmg("W", enemy, myHero)
				ceDmg = getDmg("E", enemy, myHero)
				crDmg = getDmg("R", enemy, myHero)
				ciDmg = getDmg("IGNITE", enemy, myHero)
				csheendamage = (sheenReady and getDmg("SHEEN",enemy,myHero) or 0)
				clichdamage = (lichReady and getDmg("LICHBANE",enemy,myHero) or 0)
        cbotrkdamage = (BRKREADY and getDmg("RUINEDKING",enemy,myHero) or 0)
        crshdamage = (RSHREADY and caaDmg*.8 or 0)
        ctmtdamage = (TMTREADY and caaDmg*.8 or 0)
        cstddamage = (STDREADY and caaDmg*6 or 0)        
        if GetInventorySlotItem(3031) ~= nil then
            cstddamage = cstddamage*1.25
        end

		
		cExtraDmg = 0
		cTotal = 0
	
	if iReady then
		cExtraDmg = cExtraDmg + ciDmg
	end
	

	
   cExtraDmg = cExtraDmg + cbotrkdamage + ctmtdamage + cstddamage + crshdamage + csheendamage + clichdamage

	
	
		EnemyTable[i].q = cqDmg
		EnemyTable[i].q2 = cqDmgEmp

        
		EnemyTable[i].w = cqDmg

		EnemyTable[i].e = ceDmg
	
	
	
	
	-- Make combos
    if enemy.health < EnemyTable[i].e  then
		EnemyTable[i].IndicatorText = "E Kill"
		EnemyTable[i].IndicatorPos = 0
        if not eReady then
			EnemyTable[i].NotReady = true
		else
			EnemyTable[i].NotReady = false
        end   
	elseif enemy.health < EnemyTable[i].w  then
		EnemyTable[i].IndicatorText = "W Kill"
		EnemyTable[i].IndicatorPos = 0
        if not wReady then
			EnemyTable[i].NotReady = true
		else
			EnemyTable[i].NotReady = false
        end   
	elseif enemy.health < EnemyTable[i].q then
		EnemyTable[i].IndicatorText =  "Q Kill"
		EnemyTable[i].IndicatorPos = 0
		if rMana > MyMana or not qReady or not rReady then
			EnemyTable[i].NotReady = true
		else
			EnemyTable[i].NotReady = false
		end
	elseif enemy.health < EnemyTable[i].q + (caaDmg*2) then
		EnemyTable[i].IndicatorText =  "Q+AA Kill"
		EnemyTable[i].IndicatorPos = 0
		if not qready then
			EnemyTable[i].NotReady = true
		else
			EnemyTable[i].NotReady = false
		end	
        
    elseif enemy.health < EnemyTable[i].w + EnemyTable[i].q + EnemyTable[i].e + (caaDmg*2) then
		EnemyTable[i].IndicatorText =  "Q+W+E Kill"
		EnemyTable[i].IndicatorPos = 0
		if  not qReady or not eReady or not wReady then
			EnemyTable[i].NotReady = true
		else
			EnemyTable[i].NotReady = false
		end
        
	elseif enemy.health < EnemyTable[i].q + EnemyTable[i].q2 + (caaDmg*2) then
		EnemyTable[i].IndicatorText =  "Q+Q2+AA Kill"
		EnemyTable[i].IndicatorPos = 0
		if not eReady or not qReady then
			EnemyTable[i].NotReady = true
		else
			EnemyTable[i].NotReady = false
		end
        
    elseif enemy.health < EnemyTable[i].q2 + EnemyTable[i].w + EnemyTable[i].q + EnemyTable[i].e + (caaDmg*2) then
		EnemyTable[i].IndicatorText =  "Q+Q2+W+E+AA Kill"
		EnemyTable[i].IndicatorPos = 0
		if  not qReady or not rReady then
			EnemyTable[i].NotReady = true
		else
			EnemyTable[i].NotReady = false
		end    
        
    elseif enemy.health < (EnemyTable[i].q2*2) + EnemyTable[i].w + EnemyTable[i].q + EnemyTable[i].e + (caaDmg*4) + cExtraDmg then
		EnemyTable[i].IndicatorText =  "Triple Q Kill"
		EnemyTable[i].IndicatorPos = 0
		if  not qReady or not rReady then
			EnemyTable[i].NotReady = true
		else
			EnemyTable[i].NotReady = false
		end    
	
		
	else
		
			cTotal = cTotal + EnemyTable[i].q
            cTotal = cTotal + EnemyTable[i].q2

			cTotal = cTotal + EnemyTable[i].w

			cTotal = cTotal + EnemyTable[i].e
		
			
		
		
		HealthLeft = math.round(enemy.health - cTotal)
		PctLeft = math.round(HealthLeft / enemy.maxHealth * 100)
		BarPct = PctLeft / 103 * 100
		EnemyTable[i].Pct = PctLeft
		EnemyTable[i].IndicatorPos = BarPct
 		EnemyTable[i].IndicatorText = PctLeft .. "% Harass"
		if not qReady or not wReady or not eReady then
			EnemyTable[i].NotReady =  true
		else
			EnemyTable[i].NotReady = false
		end

		if not qReady or not wReady or not eReady then
			EnemyTable[i].NotReady =  true
		else
			EnemyTable[i].NotReady = false
		end
	end
	
	end

	end	

	
	
	

end


------------------
-- 	On Load		--
------------------

function Menu()
			RMenu = scriptConfig("Beasty Rengar!", "Rengar")
			RMenu:addParam("sep", "----- [ General Settings ] -----", SCRIPT_PARAM_INFO, "")
			
            RMenu:addParam("Combo","Combo", SCRIPT_PARAM_ONKEYDOWN, false, 32)
            RMenu:addSubMenu("Combo Settings", "ComboS")
            RMenu.ComboS:addParam("Orbwalk","Orbwalk", SCRIPT_PARAM_ONOFF, true)
            RMenu.ComboS:addParam("EmpPriority","Empowered priority:1=Q 2=W 3=E", SCRIPT_PARAM_SLICE, 1, 1, 3, 0)
            RMenu.ComboS:addParam("sep", "----- [ W Settings ] -----", SCRIPT_PARAM_INFO, "")            
            RMenu.ComboS:addParam("LowHealthW","Use empowered W below set %", SCRIPT_PARAM_ONOFF, true)
            RMenu.ComboS:addParam("AlwaysCastLowHealthW", "when set to false will cast LowHealthW only against champions", SCRIPT_PARAM_ONOFF, true)
            RMenu.ComboS:addParam("HealthW","Empowered W health %", SCRIPT_PARAM_SLICE, 20, 1, 100, 0)
            RMenu.ComboS:addParam("sep", "----- [ E Settings ] -----", SCRIPT_PARAM_INFO, "")
            RMenu.ComboS:addParam("ForceE","Force E at 4 fury when cooldowns", SCRIPT_PARAM_ONOFF, true)

			RMenu:addParam("Harass","Harass", SCRIPT_PARAM_ONKEYDOWN, false, string.byte("C"))
            RMenu:addSubMenu("Harass Settings", "HarassS")
            RMenu.HarassS:addParam("Orbwalk","Orbwalk", SCRIPT_PARAM_ONOFF, true)
            RMenu.HarassS:addParam("HarrasW","Harass with W", SCRIPT_PARAM_ONOFF, true)
            RMenu.HarassS:addParam("HarrasE","Harass with E", SCRIPT_PARAM_ONOFF, true)

			RMenu:addParam("TripleQ","Triple Q (HOLD!)", SCRIPT_PARAM_ONKEYDOWN, false, string.byte("A"))

			RMenu:addParam("sep", "----- [ KS Settings ] -----", SCRIPT_PARAM_INFO, "")
			RMenu:addParam("KsIgnite","Ignite killable", SCRIPT_PARAM_ONOFF, true)

			RMenu:addParam("KsE","E killable", SCRIPT_PARAM_ONOFF, true)
			RMenu:addParam("KsW","W killable", SCRIPT_PARAM_ONOFF, true)
			
			RMenu:addParam("sep", "----- [ Draw Settings ] -----", SCRIPT_PARAM_INFO, "")
			RMenu:addParam("DmgIndic","Kill text", SCRIPT_PARAM_ONOFF, true)
			RMenu:addParam("ShowE","Draw E Range", SCRIPT_PARAM_ONOFF, true)

			
end



function Vars()

ts = TargetSelector(TARGET_NEAR_MOUSE, 600, true)
ts.name = "Rengar"
RMenu:addTS(ts)
CastQTime = nil
--Spells
qReady, wReady, eReady, rReady = false, false, false, false, false
qCurrCd, wCurrCd,eCurrCd, rCurrCd = 0,0,0,0
qDmg, wDmg, eDmg, rDmg, iDmg, dfgDamage = 0,0,0,0,0,0
cqDmg, wDmg, ceDmg, crDmg, ciDmg, cExtraDmg, cTotal, cMana = 0,0,0,0,0,0,0,0
Fury = 0
TqText = nil
PassiveMax = false
Phase = 1
EndTime = nil
qCount = 0
--Helpers
lastAttack, lastWindUpTime, lastAttackCD = 0, 0, 0
THealth = 0
EnemyTable = {}
EnemysInTable = 0
HealthLeft = 0
PctLeft = 0
BarPct = 0
orange = 0xFFFFE303
green = ARGB(255,0,255,0)
blue = ARGB(255,0,0,255)
red = ARGB(255,255,0,0)



end






------------------
-- Callbacks	--
------------------

function OnProcessSpell(object,spell)
--	gragasbarrelrolltoggle
	if object == myHero then
		if spell.name:lower():find("attack") then
			lastAttack = GetTickCount() - GetLatency()/2
			lastWindUpTime = spell.windUpTime*1000
			lastAttackCD = spell.animationTime*1000
		end
		
		if spell.name:find("RengarQ") and Phase >= 3 then
			qCount = qCount + 1

		end
	end
end


		
		
		

function OnCreateObj(obj)
if GetDistance(obj) < 200 then
	if obj.name:find("RengarQ_tar") then
	end
	if obj.name:find("RengarPassiveMax") and Phase == 2 then
	
		PassiveMax = true
		CastQTime = GetGameTimer()+0.3
	end
end
end
