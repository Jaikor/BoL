	

    --[[
            SAC Plugin: Beasty Rengar
                    By: Zikkah
           
            Instructions: http://botoflegends.com/forum/topic/5418-autocarry-plugin-beasty-rengar-with-tripple-q-feature/
            ]]--
           
    local target
    -- spells
    local qReady
    local qCooldown
    local qCount = 0
    local wReady
    local wCooldown
    local wRange = 475
    local starttime = 0

    
    local eReady
    local eCooldown
    local eRange = 525
     
    local rReady
    local rCooldown
     
    local SkipMe = false
    local DoingTripleQ = false
    local AllowQ = true
    local PassiveMax = false
    
    -- items
    local BWCSlot, HXGSlot, BRKSlot, SheenSlot, TrinitySlot, LBSlot, RSHSlot, TMTSlot, STDSlot = nil, nil, nil, nil, nil, nil, nil, nil, nil
    local BWCREADY, HXGREADY, BRKREADY, RSHREADY, TMTREADY, STDREADY, IREADY = false, false, false, false, false, false, false
     
     
    --Damage calcs + draw
    local floattext = {"Hard Kill", "Medium Kill", "Easy Kill"}
    local killable = {}
    local waittxt = {}
     
     
    function PluginOnLoad()
            AutoCarry.SkillsCrosshair.range = 525
            AutoCarry.PluginMenu:addParam("Combo", "Use Main Combo With Auto Carry", SCRIPT_PARAM_ONOFF, true)
            AutoCarry.PluginMenu:addParam("EmpPriority", "Empowered priority:1=Q 2=W 3=E", SCRIPT_PARAM_SLICE, 1, 1, 3, 0)
            AutoCarry.PluginMenu:addParam("TrowE", "Range to throw E in main combo", SCRIPT_PARAM_SLICE, 250, 1, 525, 0)
            AutoCarry.PluginMenu:addParam("ForceE", "Force E at 4 fury when cooldowns", SCRIPT_PARAM_ONOFF, true)
            AutoCarry.PluginMenu:addParam("TripleQ", "Use TrippleQ with Auto Carry", SCRIPT_PARAM_ONKEYTOGGLE, false, string.byte("A"))
            AutoCarry.PluginMenu:addParam("Harass", "Use Harass With Mixed Mode", SCRIPT_PARAM_ONOFF, true)
            AutoCarry.PluginMenu:addParam("eHarass", "Use E in harass", SCRIPT_PARAM_ONOFF, true)  
            AutoCarry.PluginMenu:addParam("wHarass", "Use W in harass", SCRIPT_PARAM_ONOFF, false)
            AutoCarry.PluginMenu:addParam("KillSteal", "Killsteal with E or W", SCRIPT_PARAM_ONOFF, true)
	        AutoCarry.PluginMenu:addParam("LowHealthW", "Empowered W at low health", SCRIPT_PARAM_ONOFF, false)
			 AutoCarry.PluginMenu:addParam("UseWPct", "Health % for empowered W", SCRIPT_PARAM_SLICE, 20, 1, 100, 0)
            for i=1, heroManager.iCount do
            waittxt[i] = i*3
        end
    end
     
    function PluginOnTick()
     
            target = AutoCarry.GetAttackTarget()
            CheckCooldowns()
			if AutoCarry.CanAttack == false then
				myHero:MoveTo(mousePos.x, mousePos.z)
			end

			
            if AutoCarry.PluginMenu.TripleQ and myHero.mana < 4 and DoingTripleQ == false then
                    PrintChat("Not enough Fury, Triple Q DISABLED")
                    AutoCarry.PluginMenu.TripleQ = false
            end
           
            if AutoCarry.PluginMenu.TripleQ and rCooldown and DoingTripleQ == false then
                    PrintChat("Your ult is on cooldown. Triple Q DISABLED")
                    AutoCarry.PluginMenu.TripleQ = false
            end    
           
            if AutoCarry.PluginMenu.TripleQ and qCooldown and DoingTripleQ == false then
                    PrintChat("Your Q is on cooldown. Triple Q DISABLED")
                    AutoCarry.PluginMenu.TripleQ = false
            end    
                   
           
            if AutoCarry.PluginMenu.Combo and AutoCarry.MainMenu.AutoCarry and AutoCarry.PluginMenu.TripleQ == false then
                    Combo()
            end
           
            if AutoCarry.PluginMenu.TripleQ and AutoCarry.PluginMenu.Combo and AutoCarry.MainMenu.AutoCarry then
					TripleQ()
            end    
     
            if AutoCarry.PluginMenu.Harass and AutoCarry.MainMenu.MixedMode then
                    Harass()
            end    
            if AutoCarry.PluginMenu.KillSteal then
                    KillStealEW()
            end
     
     
            if tick == nil or GetTickCount()-tick >= 100 then
                    tick = GetTickCount()
                    CalculateDamage()
            end
			if DoingTripleQ == false then
				AutoCarry.CanAttack = true
			end
    end
     
    function Combo()
     
            if target ~= nil then
                
			HealthPct = (myHero.health / myHero.maxHealth)*100
			
			if HealthPct < AutoCarry.PluginMenu.UseWPct and myHero.mana == 5 and LowHealthW then
				CastSpell(_W)
			end
			
            if myHero.mana <= 4 then
                            if qReady and pActive and GetDistance(target) <= 250 then
                                    CastSpell(_Q)
                            end
                            if qReady and not pActive and GetDistance(target) <= 250 then
                                    CastSpell(_Q)
                            end
                   
                            if wReady and qCooldown and GetDistance(target) <= wRange then
                                    CastSpell(_W)
                            end
                            if wReady and GetDistance(target) >= 150 and GetDistance(target) <= wRange then
                                    CastSpell(_W)
                            end
                           
                            if eReady and GetDistance(target) <= eRange and GetDistance(target) >= AutoCarry.PluginMenu.TrowE then
                                    CastSpell(_E, target)
                            end
                            if myHero.mana == 4 and eReady and qCooldown and wCooldown and AutoCarry.PluginMenu.ForceE then
                                    CastSpell(_E, target)
                            end    
                           
                    end    
     
                    if myHero.mana == 5 and AutoCarry.PluginMenu.EmpPriority == 1 and GetDistance(target) <= 300 then
                            CastSpell(_Q)
                    end
                    if myHero.mana == 5 and AutoCarry.PluginMenu.EmpPriority == 2 and GetDistance(target) <= wRange then
                            CastSpell(_W)
                    end
                    if myHero.mana == 5 and AutoCarry.PluginMenu.EmpPriority == 3 and GetDistance(target) <= eRange then
                            CastSpell(_E, target)
                    end
                   
                    if STDREADY then CastSpell(STDSlot, target) end
                    if BRKREADY then CastSpell(BRKSlot, target) end
                    if BWCREADY then CastSpell(BWCSlot, target) end
                    if GetDistance(target) <= 380 and TMTREADY then CastSpell(TMTSlot) end
                    if GetDistance(target) <= 380 and RSHREADY then CastSpell(RSHSlot) end 
                    if HXGREADY then CastSpell(HXGSlot, target) end        
                   
            end            
     
    end
     

	 
    function TripleQ()
	
		DoingTripleQ = true
		
		if not SkipMe then
			AutoCarry.CanAttack = false
			AutoCarry.CanMove = true
			if rReady then
				CastSpell(_R)
			end
			if PassiveMax then
				if AllowQ then
					CastSpell(_Q)
				else
					SkipMe = true
				end
			end
		else
			if myHero.mana == 4 then
				AutoCarry.CanAttack = true
				JumpTime = os.clock()
			end
			if AutoCarry.CanAttack == true then
				if AllowQ then
					CastSpell(_Q)
				end
			end
			if GetDistance(target) <= 350 then
                if STDREADY then CastSpell(STDSlot, target) end
                if BRKREADY then CastSpell(BRKSlot, target) end
                if BWCREADY then CastSpell(BWCSlot, target) end
                if TMTREADY then CastSpell(TMTSlot) end
                if RSHREADY then CastSpell(RSHSlot) end
                if HXGREADY then CastSpell(HXGSlot, target) end
			end
		end
		
		if qCount >= 3   then
			PrintChat("3rd q cast, going normall combo")
			qCount = 0
			DoingTripleQ = false
			AutoCarry.PluginMenu.TripleQ = false
			SkipMe = false
			JumpTime = nil
		end
		if JumpTime ~= nil and os.clock() - JumpTime > 1.5 then -- fail safe shit
			PrintChat("3rd q cast, going normall combo")
			qCount = 0
			DoingTripleQ = false
			AutoCarry.PluginMenu.TripleQ = false
			SkipMe = false
			JumpTime = nil

		end

           
    end
     
    function Harass()
           
            if target ~= nil then
                    if myHero.mana <= 4 then
                            if eReady and GetDistance(target) <= eRange and AutoCarry.PluginMenu.eHarass then
                                    CastSpell(_E, target)
                            end
                            if wReady and myHero.mana <= 4 and GetDistance(target) <= wRange and AutoCarry.PluginMenu.wHarass then
                                    CastSpell(_W, target)
                            end
                           
                    end
                   
                    if myHero.mana == 5 and AutoCarry.PluginMenu.EmpPriority == 2 and GetDistance(target) <= wRange and AutoCarry.PluginMenu.wHarass then
                            CastSpell(_W, target)
                    end
                    if myHero.mana == 5 and AutoCarry.PluginMenu.EmpPriority == 3 and GetDistance(target) <= eRange then
                            CastSpell(_E, target)
                    end
            end            
    end
     
     
     
     
    function KillStealEW()
     
        for _, enemy in pairs(AutoCarry.EnemyTable) do
         
            if ValidTarget(enemy, eRange) and enemy.health < getDmg("E", enemy, myHero)and eReady then
         
                 CastSpell(_E, enemy)
         
            end
                    if ValidTarget(enemy, wRange) and enemy.health < getDmg("W", enemy, myHero) and wReady then
                           
                 CastSpell(_W, enemy)
         
                    end
         
                    if ValidTarget(enemy, wRange) and enemy.health < getDmg("E", enemy, myHero) + getDmg("W", enemy, myHero) and eReady and wReady then
                            CastSpell(_E, enemy)
                            CastSpell(_W, enemy)
     
                    end
         end       
             
    end
           
     
     
    function PluginOnDraw()


            if AutoCarry.PluginMenu.TripleQ == true and DoingTripleQ == false then
                    PrintFloatText(myHero, 0, "Triple Q Active")
            end
           
                   
            if DoingTripleQ == true then
                    PrintFloatText(myHero, 0, "Performing Tripple Q")
            end
            -- Damage calculations & drawing
            for i = 1, heroManager.iCount do
                    local enemyd = heroManager:GetHero(i)
                    if ValidTarget(enemyd) then
     
                            if killable[i] ~= 0 and waittxt[i] == 1 then
                                    if DoingTripleQ  then
                                            PrintFloatText(enemyd, 0, "Stay close enough")
                                    else
                                    PrintFloatText(enemyd, 0, floattext[killable[i]])
                                    end
                            end
                    end
                    if waittxt[i] == 1 then
                waittxt[i] = 30
            else
                waittxt[i] = waittxt[i]-1
            end
            end            
           
    end    
     
    function CalculateDamage()
        for i=1, heroManager.iCount do
                           
            local enemyc = heroManager:GetHero(i)
            if ValidTarget(enemyc) then
            --spells
                    local aa = getDmg("AD",enemyc,myHero)
                    local qDmg = getDmg("Q", enemyc, myHero)
                    local qDmgEmp = getDmg("Q", enemyc, myHero,2)
                    local wDmg = getDmg("W", enemyc, myHero)
                    local eDmg = getDmg("E", enemyc, myHero)
                           
            -- items
                    local bwcDamage = (BWCSlot and getDmg("BWC",enemyc,myHero) or 0)
                    local hxgDamage = (HXGSlot and getDmg("HXG", enemyc, myHero) or 0)
                    local brkDamage = (BRKSlot and getDmg("RUINEDKING",enemyc,myHero,2) or 0)
                    local igniteDamage = (ignite and getDmg("IGNITE",enemyc,myHero) or 0)
                    local onhitDmg = (SheenSlot and getDmg("SHEEN",enemyc,myHero) or 0)+(TrinitySlot and getDmg("TRINITY",enemyc,myHero) or 0)+(LBSlot and getDmg("LICHBANE",enemyc,myHero) or 0)+(IcebornSlot and getDmg("ICEBORN",enemyc,myHero) or 0)
                    local rshDamage = (RSHSlot and aa*0.8 or 0)
                    local tmtDamage = (TMTSlot and aa*0.8 or 0)
                    local stdDamage = (STDSlot and aa*6 or 0)
            -- extra damage for sword of divine with IE 250% crit damage
                    if GetInventorySlotItem(3031) ~= nil then
                            stdDamage = stdDamage*1.25
                    end
           
            -- calculations
                    local tripleQDmg = qDmg + qDmgEmp*2 + aa*3 + onhitDmg
                    local NormalCombo = qDmg + wDmg + eDmg + aa*2
                    local DoubleCombo = tripleQDmg + NormalCombo
           
                    if BRKREADY then
                    tripleQDmg = tripleQDmg + brkDamage
                    NormalCombo = NormalCombo + brkDamage
                    DoubleCombo = tripleQDmg + NormalCombo - brkDamage
                    end
                    if IREADY then
                    tripleQDmg = tripleQDmg + igniteDamage
                    NormalCombo = NormalCombo + igniteDamage
                    DoubleCombo = tripleQDmg + NormalCombo - igniteDamage
                    end
                    if HXGREADY then
                    tripleQDmg = tripleQDmg + hxgDamage
                    NormalCombo = NormalCombo + hxgDamage
                    DoubleCombo = tripleQDmg + NormalCombo - hxgDamage
                    end
                    if BWCREADY then
                    tripleQDmg = tripleQDmg + bwcDamage
                    NormalCombo = NormalCombo + bwcDamage
                    DoubleCombo = tripleQDmg + NormalCombo - bwcDamage
                    end
                    if TMTREADY then
                    tripleQDmg = tripleQDmg + tmtDamage
                    NormalCombo = NormalCombo + tmtDamage
                    DoubleCombo = tripleQDmg + NormalCombo - tmtDamage
                    end    
                    if RSHREADY then
                    tripleQDmg = tripleQDmg + rshDamage
                    NormalCombo = NormalCombo + rshDamage
                    DoubleCombo = tripleQDmg + NormalCombo - rshDamage
                    end
                    if STDREADY then
                    tripleQDmg = tripleQDmg + stdDamage
                    NormalCombo = NormalCombo + stdDamage
                    DoubleCombo = tripleQDmg + NormalCombo - stdDamage
                    end
                    if myHero.mana >= 3 then
                    NormalCombo = NormalCombo + qDmgEmp
                    end
            --
                    if NormalCombo >= enemyc.health then
                            killable[i] = 3
                           
                    elseif tripleQDmg >= enemyc.health then
                            if myHero.level >= 6 then
                                    killable[i] = 2
                            end
                    elseif DoubleCombo - qDmgEmp >= enemyc.health then
                            if myHero.level >= 6 then      
                                    killable[i] = 1
                            end    
                    else
                            killable[i] = 0
                    end
                           
            end
            end
           
     
     
    end
     
    function CheckCooldowns()
            --spells
            qReady = myHero:CanUseSpell(_Q) == READY
        wReady = myHero:CanUseSpell(_W) == READY
        eReady = myHero:CanUseSpell(_E)     == READY
        rReady = myHero:CanUseSpell(_R) == READY
            qCooldown = myHero:CanUseSpell(_Q) ~= READY
        wCooldown = myHero:CanUseSpell(_W) ~= READY
        eCooldown = myHero:CanUseSpell(_E)  ~= READY
        rCooldown = myHero:CanUseSpell(_R) ~= READY
           
     
           
           
            -- items
            BWCSlot = GetInventorySlotItem(3144)
            HXGSlot = GetInventorySlotItem(3146)
            BRKSlot = GetInventorySlotItem(3153)
            SheenSlot, TrinitySlot, LBSlot = GetInventorySlotItem(3057), GetInventorySlotItem(3078), GetInventorySlotItem(3100)
            RSHSlot = GetInventorySlotItem(3074)
            TMTSlot = GetInventorySlotItem(3077)
            STDSlot = GetInventorySlotItem(3131)
     
            BWCREADY = (BWCSlot ~= nil and myHero:CanUseSpell(BWCSlot) == READY)
            HXGREADY = (HXGSlot ~= nil and myHero:CanUseSpell(HXGSlot) == READY)
            BRKREADY = (BRKSlot ~= nil and myHero:CanUseSpell(BRKSlot) == READY)
            RSHREADY = (RSHSlot ~= nil and myHero:CanUseSpell(RSHSlot) == READY)
            TMTREADY = (TMTSlot ~= nil and myHero:CanUseSpell(TMTSlot) == READY)
            STDREADY = (STDSlot ~= nil and myHero:CanUseSpell(STDSlot) == READY)
            IREADY = (ignite ~= nil and myHero:CanUseSpell(ignite) == READY)
    end

function PluginOnProcessSpell(object,spell)
if spell.name:find("RengarQ") and DoingTripleQ then
	qCount = qCount + 1

	AllowQ = false
end

end


function PluginOnCreateObj(obj)
if obj.name:find("RengarQ_tar") then
	AllowQ = true
end
if obj.name:find("RengarPassiveMax") then
	PassiveMax = true
end
end

function PluginOnDeleteObj(obj)

if obj.name:find("RengarPassiveMax") then
	PassiveMax = false
end
if obj.name:find("RengarQReady") then
	AllowQ = true
end

end
