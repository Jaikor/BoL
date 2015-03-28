local VERSION = "1.6"
if myHero.charName ~= "Udyr" then return end

 require 'SxOrbWalk'

assert(load(Base64Decode("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"), nil, "bt", _ENV))() ScriptStatus("TGJHHLIHFHI") 

local Config = nil
local SpellQ = {Range = 600, Delay = 0.25}
local SpellW = {Range = 600, Delay = 0.25}
local SpellE = {Range = 600, Delay = 0.25}
local SpellR = {Range = 600, Delay= 0.25}
local QRange, WRange, ERange, RRange  = nil, nil, nil, nil
local QREADY, WREADY, EREADY, RREADY = nil, nil, nil, nil


function OnLoad()
	DelayAction(OrbwalkCheck, 1)
	Menu()
    Init()
	
	PrintChat("<font color=\"#81BEF7\">>> JKUdyr Imba Shit V1.5!!loaded</font>")
end

function Init()
	ts = TargetSelector(TARGET_LESS_CAST_PRIORITY, 600, DAMAGE_PHYSICAL)
	ts.name = "Udyr - Selecter"
    Menu:addTS(ts)
	JungleMinions = minionManager(MINION_JUNGLE, 600, myHero)
	EnemyMinions = minionManager(MINION_ENEMY, 600, myHero, MINION_SORT_MAXHEALTH_DEC)
    initDone = true
end


function Menu()
				--{ Initiate Menu
			Menu = scriptConfig("Udyr","ImbaUdyr")
			Menu:addParam("Author","Author: Jaikor",5,"")
			--{ General/Key Bindings
				Menu:addSubMenu("Udyr: General","General")
				Menu.General:addParam("Combo","Combo",2,false,32)
				Menu.General:addParam("LaneClear","Lane Clear",2,false,string.byte("V"))
				Menu.General:addParam("JungleFarm","Jungle Farm",2,false,string.byte("V"))
	--			Menu.General:addParam("Flee","Ferrari Mode",2,false,string.byte("X"))

				--{	Combo Settings
				Menu:addSubMenu("Udyr: Combo","Combo")
				Menu.Combo:addParam("Q","Use Q in 'Combo'",1,true)
				Menu.Combo:addParam("W","Use W in 'Combo'",1,true)
				Menu.Combo:addParam("E","Use E in 'Combo'",1,true)
				Menu.Combo:addParam("R", "Use R in'Combo'",3, true, GetKey("G"))
			--}
			--{ Farm Settings
				Menu:addSubMenu("Udyr: Farm","Farm")
				Menu.Farm:addParam("Mana","Minimum Mana Percentage",4,70,0,100,0)
				Menu.Farm:addParam("Q","Use Q in 'Farm'",1,true)
				Menu.Farm:addParam("Qclear","Use Q in 'Lane Clear'",1,true)
				Menu.Farm:addParam("R","Use R in 'Farm'",1,true)
				Menu.Farm:addParam("Rclear","Use R in 'Lane Clear'",1,true)
			--}
			--{ Jungle Farm Settings
				Menu:addSubMenu("Udyr: JungleFarm","JungleFarm")
	    	    Menu.JungleFarm:addParam("JungleQ", "Jungle Q", SCRIPT_PARAM_ONOFF, true)
	        	Menu.JungleFarm:addParam("JungleR", "Jungle R", SCRIPT_PARAM_ONOFF, true)
				
			--{ Draw Settings
				Menu:addSubMenu("Udyr: Draw","Draw")
	            Menu.Draw:addParam("DrawQ", "Draw Q Range", SCRIPT_PARAM_ONOFF, true)
				Menu.Draw:addParam("DrawW", "Draw W Range", SCRIPT_PARAM_ONOFF, true)
			    Menu.Draw:addParam("DrawE", "Draw E Range", SCRIPT_PARAM_ONOFF, true)
				Menu.Draw:addParam("DrawR", "Draw R Range", SCRIPT_PARAM_ONOFF, true)
		--		Menu.Draw:addParam("Drawkillable", "Draw killable enemy with ulti", SCRIPT_PARAM_ONOFF, true)
		    --}
				Menu:addSubMenu("Orbwalking Settings", "Orbwalking") 
		    --{ Permashow
				Menu.General:permaShow("Combo")
				Menu.General:permaShow("JungleFarm")
				Menu.General:permaShow("LaneClear")
end

	
function OnTick()
	if initDone then
		Check()
			QMANA = GetSpellData(_Q).mana
			WMANA = GetSpellData(_W).mana
			EMANA = GetSpellData(_E).mana
			RMANA = GetSpellData(_R).mana
			Farm = Menu.General.LaneClear and Menu.Farm.Mana <= (myHero.mana / myHero.maxMana) * 100
			JungleFarm = Menu.General.JungleFarm
			Combat = Menu.General.Combo
			Flee = Menu.General.Flee
		ts:update()
		Target = ts.target
		--{ Combo and Harass
		if Combat then
			if Target and not Target.dead then
				if EREADY not TargetHaveBuff("udyrbearstuncheck", Target) and Menu.Combo.E then
					CastSpell(_E)
				end
				if (TargetHaveBuff("udyrbearstuncheck", Target) and myHero:GetSpellData(_E).level > 0 and GetDistance(Target) <= 400) or (myHero:GetSpellData(_E).level == 0 and GetDistance(Target) <= 400) then
					--print("3")
					if QREADY and Combo.Menu.Q then
						CastSpell(_Q)
					end
					if RREADY and myHero:GetSpellData(_Q).level >= 1 and Tiger and (AttackCount >= 2 or TigerProc == true) and Menu.Combo.R then
						CastSpell(_R)
					elseif myHero:GetSpellData(_Q).level == 0 and Menu.Combo.R then
						CastSpell(_R)
					end
					if Phoenix == true and (AttackCount >= 3 or FlameBreath == true) and Menu.Combo.W then
						CastSpell(_W)
					elseif Tiger == true and (AttackCount >= 2 or TigerProc == true) and Menu.Combo.W then
						CastSpell(_W)
					elseif myHero:GetSpellData(_Q).level == 0 and myHero:GetSpellData(_R).level == 0 and Menu.Combo.W then
						CastSpell(_W)
					end
		
				end
			end
		end
		--}	
		--{ Farming
		if Farm then
			EnemyMinions:update()
			for i, Minion in pairs(EnemyMinions.objects) do
				if ValidTarget(Minion) then
					if QREADY and Menu.General.LaneClear then
						CastSpell(_Q)
					end
					if RREADY and Menu.General.LaneClear then
						CastSpell(_R)
					end
				end
			end
		end
	--}
	--{ Jungle Farming
		if JungleFarm then
			JungleMinions:update()
			JungleCreep = JungleMinions.objects[1]
			if ValidTarget(JungleCreep) then
				if QREADY then 
					CastSpell(_Q)
				elseif RREADY and (not QREADY or myHero:GetSpellData(_Q).level < 1) then
					CastSpell(_R)
				end
			end
		end
	--}	
--}
	end
end

function Check()
	QREADY = (myHero:CanUseSpell(_Q) == READY)
	WREADY = (myHero:CanUseSpell(_W) == READY)
	EREADY = (myHero:CanUseSpell(_E) == READY)
	RREADY = (myHero:CanUseSpell(_R) == READY)
end

function OrbwalkCheck()
 if _G.AutoCarry then
  sacused = true
  Menu.Orbwalking:addParam("info11","SAC Detected", SCRIPT_PARAM_INFO, "")
 elseif _G.Reborn_Loaded then
  DelayAction(OrbwalkCheck, 1)
 elseif _G.MMA_Loaded then
  Menu.Orbwalking:addParam("info11","MMA Detected", SCRIPT_PARAM_INFO, "")
  mmaused = true
 else
  SxOrb:LoadToMenu(Menu.Orbwalking, false) 
  sxorbused = true
  DelayAction(function()  
   if SxOrb.Version < 2.08 then
    script_Messager("Your SxOrbWalk library is outdated, please redownload it manually!")
   end
  end, 5)
 end
end

function OnProcessSpell(unit, spell)
  if unit.isMe then
		if spell and spell.name == myHero:GetSpellData(_Q).name then
			Tiger, Turtle, Bear, Phoenix = true, false, false, false
			AttackCount, TurtleCount = 0, 0
		end
		if spell and spell.name == myHero:GetSpellData(_W).name then
			Tiger, Turtle, Bear, Phoenix = false, true, false, false
			AttackCount, TurtleCount = 0, 0
		end
		if spell and spell.name == myHero:GetSpellData(_E).name then
			Tiger, Turtle, Bear, Phoenix = false, false, true, false
			AttackCount, TurtleCount = 0, 0
		end
		if spell and spell.name == myHero:GetSpellData(_R).name then     
			Tiger, Turtle, Bear, Phoenix = false, false, false, true
			AttackCount, TurtleCount = 0, 0
		end
		if spell.name:find("Attack") then
			if (Target and spell.target == Target) or (Minion and spell.target == Minion) then
				if Tiger == true or Phoenix == true then
					AttackCount = AttackCount + 1
				elseif Turtle == true then
					TurtleCount = TurtleCount + 1
				end
			end
		end
	end
end

function OnCreateObj(obj)
	if GetDistance(obj) <= 70 and (obj.name == "Udyr_PhoenixBreath_cas.troy" or obj.name == "Udyr_Spirit_Phoenix_Breath_cas.troy") then
		FlameBreath = true
	end
	if GetDistance(obj) <= 450 and (obj.name == "udyr_tiger_claw_tar.troy" or obj.name == "Udyr_Spirit_Tiger_Claw_tar.troy") then
		TigerProc = true
	end
end

function OnDeleteObj(obj)
	if GetDistance(obj) <= 70 and (obj.name == "Udyr_PhoenixBreath_cas.troy" or obj.name == "Udyr_Spirit_Phoenix_Breath_cas.troy") then
		FlameBreath = false
	end
	if GetDistance(obj) <= 450 and (obj.name == "udyr_tiger_claw_tar.troy" or obj.name == "Udyr_Spirit_Tiger_Claw_tar.troy") then
		TigerProc = false
	end
end

function OnDraw()
  --  if Config.Draw.Drawkillable then warning() end -- Floating text warning 
    --Draw QQ
    if Menu.Draw.DrawQ then
		DrawCircle3D(myHero.x, myHero.y, myHero.z, SpellQ.Range, 1,  ARGB(255, 0, 255, 255))
	end
	    if Menu.Draw.DrawW then
		DrawCircle3D(myHero.x, myHero.y, myHero.z, SpellQ.Range, 1,  ARGB(255, 0, 255, 255))
	end
	    if Menu.Draw.DrawE then
		DrawCircle3D(myHero.x, myHero.y, myHero.z, SpellQ.Range, 1,  ARGB(255, 0, 255, 255))
	end
    --Draw W
	if Menu.Draw.DrawR then
		DrawCircle3D(myHero.x, myHero.y, myHero.z, SpellW.Range, 1,  ARGB(255, 0, 255, 255))
	end
end
