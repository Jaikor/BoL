if myHero.charName ~= "Shaco" then return end

------------- Configuration ------------------
 
local highEnabled         = true -- Enable High Priority Boxes
local medEnabled          = true -- Enable Medium Priority Boxes
local lowEnabled          = true -- Enable Low Priority Boxes
local blueEnabled         = true -- Enable Blue Team Boxes (in and around blue jungle)
local purpEnabled         = true -- Enable Purple Team Boxes (in and around purple jungle)
 
local autoboxHigh  = true -- Auto-Box high priority locations
 
local showLocationsInRange = 1200 -- When you press W, locations in this range will be shown
local showClose = true -- Show box locations that are close to you
local showCloseRange = 800

drawboxSpots = false
 --------------------------------------------

function OnLoad()
PrintChat("<font color='#C80046'>L</font><font color='#C70027'>o</font><font color='#C80005'>a</font><font color='#C71C00'>d</font><font color='#C83900'>e</font><font color='#C75400'>d</font><font color='#C86D00'> </font><font color='#C88800'>B</font><font color='#C7A400'>o</font><font color='#C7C500'>x</font><font color='#A8C800'>e</font><font color='#88C800'>s</font><font color='#6AC700'> </font><font color='#4BC800'>F</font><font color='#2AC800'>r</font><font color='#04C700'>o</font><font color='#00C822'>m</font><font color='#00C744'> </font><font color='#00C863'>H</font><font color='#00C781'>e</font><font color='#00C8A0'>l</font><font color='#00C8C2'>l</font><font color='#00ABC8'> </font><font color='#008EC8'>f</font><font color='#0073C8'>o</font><font color='#005AC7'>r</font><font color='#003FC7'>,</font><font color='#0023C8'> </font><font color='#0002C8'>S</font><font color='#2000C8'>h</font><font color='#3F00C8'>a</font><font color='#5D00C8'>c</font><font color='#7C00C8'>o</font><font color='#9D00C8'>!</font>")
PrintChat("<font color='#C80046'>C</font><font color='#C80031'>r</font><font color='#C8001B'>e</font><font color='#C80004'>d</font><font color='#C81300'>i</font><font color='#C82800'>t</font><font color='#C83B00'>s</font><font color='#C84D00'>:</font><font color='#C85F00'> </font><font color='#C77000'>S</font><font color='#C78200'>i</font><font color='#C89500'>d</font><font color='#C8A900'>a</font><font color='#C8BF00'> </font><font color='#B8C800'>f</font><font color='#A1C800'>o</font><font color='#8CC700'>r</font><font color='#77C700'> </font><font color='#63C800'>h</font><font color='#4EC800'>i</font><font color='#38C800'>s</font><font color='#20C700'> </font><font color='#06C800'>S</font><font color='#00C815'>h</font><font color='#00C82D'>r</font><font color='#00C744'>o</font><font color='#00C759'>o</font><font color='#00C86E'>o</font><font color='#00C883'>o</font><font color='#00C797'>o</font><font color='#00C8AD'>o</font><font color='#00C8C5'>o</font><font color='#00B3C8'>o</font><font color='#009EC7'>o</font><font color='#008BC7'>o</font><font color='#0079C8'>o</font><font color='#0067C8'>o</font><font color='#0055C7'>o</font><font color='#0043C7'>o</font><font color='#0031C8'>m</font><font color='#001CC8'>s</font><font color='#0006C8'>!</font><font color='#1100C8'> </font><font color='#2700C8'>S</font><font color='#3C00C7'>c</font><font color='#5100C7'>r</font><font color='#6500C8'>i</font><font color='#7A00C8'>p</font><font color='#9100C8'>t</font><font color='#A800C8'>.</font>")
PrintChat("<font color='#C80046'>I</font><font color='#C8003A'>n</font><font color='#C8002E'>s</font><font color='#C80022'>t</font><font color='#C80016'>r</font><font color='#C80009'>u</font><font color='#C80400'>c</font><font color='#C81100'>t</font><font color='#C81D00'>i</font><font color='#C82900'>o</font><font color='#C83400'>n</font><font color='#C83E00'>s</font><font color='#C84900'>:</font><font color='#C85300'> </font><font color='#C85D00'>E</font><font color='#C76600'>n</font><font color='#C87000'>s</font><font color='#C87A00'>u</font><font color='#C88400'>r</font><font color='#C88F00'>e</font><font color='#C79A00'> </font><font color='#C7A500'>t</font><font color='#C8B100'>h</font><font color='#C7BE00'>a</font><font color='#C4C800'>t</font><font color='#B7C800'> </font><font color='#AAC800'>W</font><font color='#9EC800'> </font><font color='#92C800'>i</font><font color='#86C800'>s</font><font color='#7AC700'> </font><font color='#6FC700'>n</font><font color='#63C800'>o</font><font color='#58C800'>t</font><font color='#4CC700'> </font><font color='#40C700'>a</font><font color='#33C800'> </font><font color='#26C800'>s</font><font color='#17C800'>m</font><font color='#08C700'>a</font><font color='#00C806'>r</font><font color='#00C816'>t</font><font color='#00C824'> c</font><font color='#00C831'>a</font><font color='#00C83E'>s</font><font color='#00C74A'>t</font><font color='#00C856'> </font><font color='#00C862'>k</font><font color='#00C86D'>e</font><font color='#00C879'>y</font><font color='#00C884'>.</font><font color='#00C890'> </font><font color='#00C89C'>P</font><font color='#00C8A8'>r</font><font color='#00C8B5'>e</font><font color='#00C8C2'>s</font><font color='#00BFC8'>s</font><font color='#00B2C8'> </font><font color='#00A6C8'>W</font><font color='#009BC7'> </font><font color='#0090C7'>a</font><font color='#0086C8'>n</font><font color='#007CC8'>d</font><font color='#0072C8'> </font><font color='#0068C7'>l</font><font color='#005EC8'>e</font><font color='#0054C8'>f</font><font color='#004AC8'>t</font><font color='#0040C8'> </font><font color='#0035C8'>c</font><font color='#002AC7'>l</font><font color='#001FC8'>i</font><font color='#0013C8'>c</font><font color='#0006C8'>k</font><font color='#0700C8'> </font><font color='#1400C7'>i</font><font color='#2100C8'>n</font><font color='#2D00C8'> </font><font color='#3900C8'>t</font><font color='#4400C8'>h</font><font color='#5000C8'>e</font><font color='#5B00C8'> </font><font color='#6700C8'>c</font><font color='#7300C8'>i</font><font color='#7F00C8'>r</font><font color='#8B00C8'>c</font><font color='#9800C8'>l</font><font color='#A500C8'>e</font><font color='#B400C8'>.</font>")
end

function OnTick()

for i, group in pairs(boxSpots) do
	for x, boxspot in pairs(group.Locations) do
		if boxSpot and group.Enabled and group.Auto and GetDistance(boxSpot) <= 900 and not boxExists(boxSpot) then
			CastSpell(_W, boxSpot.x, boxSpot.z)
		end
	end
end
end

function boxExists(boxSpot)
        for i=1, objManager.maxObjects do
        local obj = objManager:getObject(i)
                if obj ~= nil and obj.name:find("Jack In The Box") then
                        if GetDistance(obj) <= 400 then
                                return true
                        end
                end
        end    
        return false
end

function OnWndMsg(msg,key)
        if msg == KEY_DOWN and key == string.byte("W") then
                if player:CanUseSpell(_W) == READY then
                        drawboxSpots = true
                end
        elseif msg == WM_LBUTTONDOWN and drawboxSpots then
                for i,group in pairs(boxSpots) do
                        for x, boxSpot in pairs(group.Locations) do
                                if group.Enabled then
                                        if GetDistance(boxSpot, mousePos) <= 399 then
                                                        CastSpell(_W, boxSpot.x, boxSpot.z)
                                        end
                                end
                        end
                end
        elseif msg == WM_RBUTTONDOWN and drawboxSpots then
                drawboxSpots = false
        end
end
 
function drawCircles(x,y,z,colour)
        DrawCircle(x, y, z, 28, colour)
        DrawCircle(x, y, z, 29, colour)
        DrawCircle(x, y, z, 30, colour)
        DrawCircle(x, y, z, 31, colour)
        DrawCircle(x, y, z, 32, colour)
        DrawCircle(x, y, z, 250, colour)
        if colour == red or colour == blue
                or colour == purple or colour == yellow then
                DrawCircle(x, y, z, 251, colour)
                DrawCircle(x, y, z, 252, colour)
                DrawCircle(x, y, z, 253, colour)
                DrawCircle(x, y, z, 254, colour)
        end
end
 
function OnDraw()
        for i,group in pairs(boxSpots) do
                if group.Enabled == true then
                        if drawboxSpots then
                                for x, boxSpot in pairs(group.Locations) do
                                        if GetDistance(boxSpot) < showLocationsInRange then
                                                if GetDistance(boxSpot, mousePos) <= 399 then
                                                        boxColour = 0xFFFFFF
                                                else
                                                        boxColour = group.Colour
                                                end
                                                drawCircles(boxSpot.x, boxSpot.y, boxSpot.z,boxColour)
                                        end
                                end
                        elseif showClose then
                                for x, boxSpot in pairs(group.Locations) do
                                        if GetDistance(boxSpot) <= showCloseRange then
                                                if GetDistance(boxSpot, mousePos) <= 399 then
                                                        boxColour = 0xFFFFFF
                                                else
                                                        boxColour = group.Colour
                                                end
                                                drawCircles(boxSpot.x, boxSpot.y, boxSpot.z,boxColour)
                                        end
                                end
                        end
                end
        end    
end

red, yellow, green, blue, purple = 0x990000, 0x993300, 0x00FF00, 0x000099, 0x660066

boxSpots = {
        -- High priority for both sides
        HighPriority =  {
                                                Locations = {
                                                                                { x = 3316.20,  y = -74.06, z = 9334.85},
                                                                                { x = 4288.76,  y = -71.71, z = 9902.76},
                                                                                { x = 3981.86,  y = 39.54,      z = 11603.55},
                                                                                { x = 6435.51,  y = 47.51,      z = 9076.02},
                                                                                { x = 9577.91,  y = 45.97,      z = 6634.53},
                                                                                { x = 7635.25,  y = 45.09,      z = 5126.81},
                                                                                { x = 10731.51, y = -30.77, z = 5287.01},
                                                                                { x = 9662.24,  y = -70.79, z = 4536.15},
                                                                                { x = 10080.45, y = 44.48,      z = 2829.56}  
                                                                        },
                                                Colour = red,
                                                Enabled = highEnabled,
                                                Auto = autoboxHigh
                                        },
-- Medium priority for both sides
        MediumPriority ={
                                                Locations = {
                                                                                { x = 3283.18,  y = -69.64, z = 10975.15},
                                                                                { x = 2595.85,  y = -74.00, z = 11044.66},
                                                                                { x = 2524.10,  y = 23.36,      z = 11912.28},
                                                                                { x = 4347.64,  y = 43.34,      z = 7796.28},
                                                                                { x = 6093.20,  y = -67.90, z = 8067.45},
                                                                                { x = 7960.99,  y = -73.41, z = 6233.09},
                                                                                { x = 10652.57, y = -58.96, z = 3507.64},
                                                                                { x = 11460.14, y = -63.94, z = 3544.83},
                                                                                { x = 11401.81, y = -11.72, z = 2626.61}  
                                                                        },
                                                Colour = yellow,
                                                Enabled = medEnabled,
                                                Auto = false
                                        },
-- Low priority/situational for both sides
        LowPriority =   {
                                                Locations = {
                                                                                { x = 1346.10,  y = 26.56,      z = 11064.81},
                                                                                { x = 705.87,   y = 26.93,      z = 11359.88},
                                                                                { x = 762.80,   y = 26.15,      z = 12210.61},
                                                                                { x = 1355.53,  y = 24.13,      z = 12936.99},
                                                                                { x = 1926.92,  y = 25.14,      z = 11567.44},
                                                                                { x = 1752.22,  y = 24.02,      z = 13176.95},
                                                                                { x = 2512.96,  y = 21.74,      z = 13524.44},
                                                                                { x = 3577.42,  y = 25.27,      z = 12429.88},
                                                                                { x = 5246.01,  y = 30.91,      z = 12508.33},
                                                                                { x = 5549.60,  y = 42.94,      z = 10917.27},
                                                                                { x = 6552.56,  y = 47.09,      z = 9688.99},
                                                                                { x = 5806.41,  y = 46.01,      z = 9918.99},
                                                                                { x = 7112.27,  y = 46.86,      z = 8443.55},
                                                                                { x = 4896.10,  y = -72.08, z = 8964.81},
                                                                                { x = 3096.10,  y = 45.41,      z = 8164.81},
                                                                                { x = 2390.53,  y = 46.57,      z = 5232.34},
                                                                                { x = 4358.81,  y = 45.83,      z = 5834.64},
                                                                                { x = 5746.10,  y = 42.52,      z = 4864.81},
                                                                                { x = 6307.66,  y = 46.07,      z = 7165.92},
                                                                                { x = 5443.82,  y = 45.64,      z = 7110.85},
                                                                                { x = 5153.75,  y = 45.41,      z = 3358.76},
                                                                                { x = 6876.07,  y = 46.44,      z = 5897.48},
                                                                                { x = 6881.30,  y = 46.08,      z = 6555.85},
                                                                                { x = 8555.10,  y = 46.36,      z = 7267.04},
                                                                                { x = 7946.10,  y = 44.19,      z = 7214.81},
                                                                                { x = 9088.99,  y = -73.12, z = 5441.11},
                                                                                { x = 7687.96,  y = 46.12,      z = 5203.08},
                                                                                { x = 8559.97,  y = 47.97,      z = 3477.87},
                                                                                { x = 8841.04,  y = 52.28,      z = 1944.09},
                                                                                { x = 10582.93, y = 43.25,      z = 1707.35},
                                                                                { x = 11046.10, y = 43.26,      z = 964.81},
                                                                                { x = 11682.20, y = 43.40,      z = 1061.03},
                                                                                { x = 12420.51, y = 46.87,      z = 1532.34},
                                                                                { x = 12819.32, y = 45.74,      z = 1931.32},
                                                                                { x = 13275.52, y = 45.38,      z = 2873.69},
                                                                                { x = 11978.71, y = 45.49,      z = 2914.69},
                                                                                { x = 13379.36, y = 45.37,      z = 3499.62},
                                                                                { x = 12818.08, y = 45.38,      z = 3625.44},
                                                                                { x = 10985.17, y = 45.69,      z = 6305.81},
                                                                                { x = 11580.80, y = 41.26,      z = 9214.09},
                                                                                { x = 9574.88,  y = 44.40,      z = 8679.65},
                                                                                { x = 8359.96,  y = 44.37,      z = 9595.58},
                                                                                { x = 8927.12,  y = 48.17,      z = 11175.70}  
                                                                        },
                                                Colour = green,
                                                Enabled = lowEnabled,
                                                Auto = false
                                        },
-- blue team areas
        BlueOnly = {
                                                Locations = {
																				{ x = 3529.24, y = 54.65, z = 7700.50},  -- Blue Camp
                                                                                { x = 6397.00, y = 51.67, z = 5065.00},  -- Wraith Camp
                                                                                { x = 3388.47, y = 55.61, z = 6168.49},  -- Wolf Camp
                                                                                { x = 7586.97, y = 57.00, z = 3828.58},  -- Red Camp
                                                                                { x = 7445.00, y = 55.60, z = 3365.00},  -- Red Camp(Bush, E little minion closest to bush)
                                                                                { x = 8055.41, y = 54.28, z = 2671.30},  -- Golem Camp
                                                                                { x = 2112.87, y = 43.81, z = 7047.48},
                                                                                { x = 2646.25, y = 45.84, z = 7545.78},
                                                                                { x = 1926.95, y = 44.83, z = 9515.71},
                                                                                { x = 4239.97, y = 44.40, z = 7132.02},
                                                                                { x = 6149.34, y = 42.51, z = 4481.88},
                                                                                { x = 6630.28, y = 46.56, z = 2836.88},
                                                                                { x = 7687.62, y = 45.54, z = 3210.98},
                                                                                { x = 7050.22, y = 46.46, z = 2351.33} 
                                                                        },
                                                Colour = blue,
                                                Enabled = blueEnabled,
                                                Auto = false
                                },
-- purple team areas
        PurpleOnly =    {
                                        Locations = {
																		{ x = 10520.72, y = 54.87, z = 6927.20}, -- Blue Camp
                                                                        { x = 7645.00, y = 55.20, z = 9413.00 }, -- Wraith Camp
                                                                        { x = 10580.53, y = 65.54, z = 7958.30}, -- Wolf Camp
                                                                        { x = 6431.00, y = 54.63, z = 10535.00}, -- Red Camp
                                                                        { x = 6597.55, y = 54.63, z = 11117.78}, -- Red Camp(Bush, E little minion closest to bush)
                                                                        { x = 6143.00, y = 39.55, z = 11777.00},  -- Golem Camp
                                                                        { x = 7466.52, y = 41.54, z = 11720.22},
                                                                        { x = 6945.85, y = 43.53, z = 11901.30},
                                                                        { x = 6636.28, y = 45.03, z = 11079.65},
                                                                        { x = 7878.53, y = 43.83, z = 10042.65},
                                                                        { x = 9701.57, y = 45.72, z = 7298.22},
                                                                        { x = 11358.86, y = 45.71, z = 6872.10},
                                                                        { x = 11946.10, y = 45.80, z = 7414.81},
                                                                        { x = 12169.52, y = 44.03, z = 4858.85}  
                                                                },
                                        Colour = purple,
                                        Enabled = purpEnabled,
                                        Auto = false
                                }
}



--UPDATEURL=
--HASH=F86F661AC97BB23BE11E340A41EC128A
