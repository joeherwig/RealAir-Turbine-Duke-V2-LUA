-- module 1.0
-- August 2015
-- ################################
-- RealAir Duke Turbine B60 V2
-- ################################

-- ## system ###############

function InitVars ()

	Yoke_Hide ()
end

function LargerockerSound ()
	 ipc.writeLvar("L:LargerockerSound", 1)
end

-- ## Avionics ###############

function Inverter_on ()
	 ipc.writeLvar("L:Duke_inverter_Switch", 0)
	 DspShow("Inv", "on")
end

function Inverter_off ()
	 ipc.writeLvar("L:Duke_inverter_Switch", 1)
	 DspShow("Inv", "off")
end

function Inverter_stby ()
	 ipc.writeLvar("L:Duke_inverter_Switch", 2)
	 DspShow("Inv", "stby")
end

function Inverter_toggle ()
	inverterState = ipc.readLvar("L:Duke_inverter_Switch")
	if inverterState == 0 then
		Inverter_off ()
	else
		Inverter_on ()
	end
end

function NavCom1_On ()
	 ipc.writeLvar("L:NavCom1_On", 0)
	 DspShow("Nav1", "on")
end

function NavCom1_Off ()
	 ipc.writeLvar("L:NavCom1_On", 1)
	 DspShow("Nav1", "off")
end

function NavCom2_On ()
	 ipc.writeLvar("L:NavCom2_On", 0)
	 DspShow("Nav2", "on")
end

function NavCom2_Off ()
	 ipc.writeLvar("L:NavCom2_On", 1)
	 DspShow("Nav2", "off")
end

function GPS_On ()
	 ipc.writeLvar("L:dukeGpsOn", 1)
	 DspShow("GPS", "on")
end

function GPS_Off ()
	 ipc.writeLvar("L:dukeGpsOn", 0)
	 DspShow("GPS", "off")
end

function ADF_On ()
	 ipc.writeLvar("L:ADF_On_Switch", 1)
	 DspShow("ADF", "on")
end

function ADF_Off ()
	 ipc.writeLvar("L:ADF_On_Switch", 0)
	 DspShow("ADF", "off")
end

function Avionics_on ()
	NavCom1_On ()
	_sleep(200, 400)
	NavCom2_On ()
	_sleep(200, 400)
	GPS_On ()
	_sleep(200, 400)
	ADF_On ()
	_sleep(200, 400)
	 XPDR_on ()
end

function Avionics_off ()
	NavCom1_Off ()
	_sleep(200, 400)
	NavCom2_Off ()
	_sleep(200, 400)
	ADF_Off ()
	_sleep(200, 400)
	GPS_Off ()
	_sleep(200, 400)
	XPDR_off ()
end

-- ## Autopilot #####################################

function VS_inc ()
	VS_value = ipc.readLvar("L:ApVsUpButAnt")
	if VS_value == 0 then
		ipc.writeLvar("L:ApVsUpBut", 1)
	else
		ipc.writeLvar("L:ApVsUpBut", 0)
	end
	VS_value = ipc.readLvar("L:ApVsUpButAnt")
	DspShow ("VS", VS_value)
end

-- ## Electrics #####################################

function Battery_on ()
	ipc.writeDD("281C", 1)
	DspShow ("BAT ", "On  ")
	LargerockerSound ()
end

function Battery_off ()
	ipc.writeDD("281C", 0)
	DspShow ("BAT ", "Off ")
	LargerockerSound ()
end

function Battery_toggle ()
	if ipc.readDD("281C") == 0 then
		Battery_on ()
	else
		Battery_off ()
	end
end

-- turbine Ignition

function Ignition_L_on ()
	ipc.writeLvar("L:ignSwL", 2)
	DspShow ("IgnR", "on")
end

function Ignition_L_off ()
	ipc.writeLvar("L:ignSwL", 0)
	DspShow ("IgnR", "off")
end

function Ignition_L_auto ()
	ipc.writeLvar("L:ignSwL", 2)
	DspShow ("IgnR", "auto")
end

function Ignition_L_toggle_OffAuto ()
	IgnitionLeftState = ipc.readLvar("L:ignSwLAnt")
	if IgnitionLeftState == 0 then
		IgnitionL_auto()
	else
		IgnitionL_off()
	end
end

function Ignition_R_on ()
	ipc.writeLvar("L:ignSwR", 2)
	DspShow ("IgnR", "on")
end

function Ignition_R_off ()
	ipc.writeLvar("L:ignSwR", 0)
	DspShow ("IgnR", "off")
end

function Ignition_R_auto ()
	ipc.writeLvar("L:ignSwR", 2)
	DspShow ("IgnR", "auto")
end

function Ignition_R_toggle_OffAuto ()
	IgnitionRightState = ipc.readLvar("L:ignSwRAnt")
	if IgnitionRightState == 0 then
		IgnitionR_auto()
	else
		IgnitionR_off()
	end
end

function Ignition_BOTH_on ()
	Ignition_R_on()
	_sleep(150, 350)
	Ignition_L_on()
end

function Ignition_BOTH_off ()
	Ignition_R_off()
	_sleep(150, 350)
	Ignition_L_off()
end

function Ignition_BOTH_auto ()
	Ignition_R_auto()
	_sleep(150, 350)
	Ignition_L_auto()
end
---

-- generator
function Generator_L_on ()
	ipc.writeSB("3b78", 1)
	DspShow ("GenL", "On")
end

function Generator_L_off ()
	ipc.writeSB("3b78", 0)
	DspShow ("GenL", "Off")
end

function Generator_L_toggle ()
	GeneratorLStatus = ipc.readLvar("L:RECIP ENG COWL FLAP POSITION2Ant")
end

function Generator_R_off ()
	ipc.writeSB("3ab8", 0)
	DspShow ("GenR", "Off")
end

function Generator_R_on ()
	ipc.writeSB("3ab8", 1)
	DspShow ("GenR", "On")
end

function Generator_BOTH_on ()
	ipc.writeSB("3b78", 1)
	ipc.writeSB("3ab8", 1)
	DspShow ("GenB", "On")
end

function Generator_BOTH_off ()
	ipc.writeSB("3b78", 0)
	ipc.writeSB("3ab8", 0)
	DspShow ("GenB", "Off")
end


-- ## Fuel #####################################

-- Fuel pump + valve ENG1 on (both engines)

function FuelPumpENG1_on ()
	ipc.writeSB("3b98", 1)
	DspShow("Pump", "1 on")
end

function FuelPumpENG1_off ()
	ipc.writeSB("3b98", 0)
	DspShow("Pump", "1off")
end


function FuelPumpENG2_on ()
	ipc.writeSB("3ad8", 1)
	DspShow("Pump", "2 on")
end

function FuelPumpENG2_off ()
	ipc.writeSB("3ad8", 0)
	DspShow("Pump", "2off")
end


function FuelValveENG1_on ()
	ipc.writeLvar("L:Duke_Tank_Selector_L", 50)
	DspShow("Fuel", "1 on")
end


function FuelValveENG1_off ()
	ipc.writeLvar("L:Duke_Tank_Selector_L", 0)
	DspShow("Fuel", "1off")
end


function FuelValveENG2_on ()
	ipc.writeLvar("L:Duke_Tank_Selector_R", 50)
	DspShow("Fuel", "2 on")
end

function FuelValveENG2_off ()
	ipc.writeLvar("L:Duke_Tank_Selector_R", 0)
	DspShow("Fuel", "2off")
end



function FuelPumps_on ()
	FuelPumpENG1_on ()
	_sleep(150, 350)
	FuelPumpENG2_on ()
end

function FuelPumps_off ()
	 FuelPumpENG1_off ()
	_sleep(150, 350)
	FuelPumpENG2_off ()
end

function FuelValves_on ()
	FuelValveENG1_on ()
	_sleep(150, 350)
	FuelValveENG2_on ()
end

function FuelValves_off ()
	FuelValveENG1_off ()
	_sleep(150, 350)
	FuelValveENG2_off ()
end

-- ## Cowl Flaps #####################################

function Duke_CowlFlap1_show ()
	ipc.sleep(10)
	CF1var = ipc.readLvar("L:RECIP ENG COWL FLAP POSITION1Ant")
	if CF1var == 0 then CF1txt = "clsd"
	elseif CF1var > 0 and CF1var < 1 then CF1txt = "half"
	elseif CF1var == 1 then CF1txt = "open"
	end
	FLIGHT_INFO1 = "CwlL"
	FLIGHT_INFO2 = CF1txt
end

function Duke_CowlFlap2_show ()
	ipc.sleep(10)
	CF2var = ipc.readLvar("L:RECIP ENG COWL FLAP POSITION2Ant")
	if CF2var == 0 then CF2txt = "clsd"
	elseif CF2var > 0 and CF2var < 1 then CF2txt = "half"
	elseif CF2var == 1 then CF2txt = "open"
	end
	FLIGHT_INFO1 = "CwlR"
	FLIGHT_INFO2 = CF2txt
end

function CowlFlaps_L_open ()
	ipc.control(66162, 16400)
	Duke_CowlFlap1_show ()
	LargerockerSound ()
end

function CowlFlaps_L_half ()
	ipc.control(66162, 8200)
	Duke_CowlFlap1_show ()
	LargerockerSound ()
end

function CowlFlaps_L_close ()
	ipc.control(66162, 0)
	Duke_CowlFlap1_show ()
	LargerockerSound ()
end

function CowlFlaps_R_open ()
	ipc.control(66163, 16400)
	Duke_CowlFlap2_show ()
	LargerockerSound ()
end

function CowlFlaps_R_half ()
	ipc.control(66163, 8200)
	Duke_CowlFlap2_show ()
	LargerockerSound ()
end

function CowlFlaps_R_close ()
	ipc.control(66163, 0)
	Duke_CowlFlap2_show ()
	LargerockerSound ()
end

function CowlFlaps_BOTH_open ()
	CowlFlaps_L_open ()
	CowlFlaps_R_open ()
end

function CowlFlaps_BOTH_half ()
	CowlFlaps_L_half ()
	CowlFlaps_R_half ()
end

function CowlFlaps_BOTH_close ()
	CowlFlaps_L_close ()
	CowlFlaps_R_close ()
end

function CowlFlaps_L_inc ()
	CF1var = ipc.readLvar("L:RECIP ENG COWL FLAP POSITION1Ant")
	if CF1var == 0 then
		CowlFlaps_L_half ()
	elseif CF1var > 0 then
		CowlFlaps_L_open ()
	end
	Duke_CowlFlap1_show ()
end

function CowlFlaps_L_dec ()
	CF1var = ipc.readLvar("L:RECIP ENG COWL FLAP POSITION1Ant")
	if CF1var == 1 then
		CowlFlaps_L_half ()
	elseif CF1var < 1 then
		CowlFlaps_L_close ()
	end
	Duke_CowlFlap1_show ()
end

--

function CowlFlaps_R_inc ()
	CF2var = ipc.readLvar("L:RECIP ENG COWL FLAP POSITION2Ant")
	if CF2var == 0 then
	CowlFlaps_R_half ()
	elseif CF2var > 0 then
	CowlFlaps_R_open ()
	end
	Duke_CowlFlap2_show ()
end

function CowlFlaps_R_dec ()
	CF2var = ipc.readLvar("L:RECIP ENG COWL FLAP POSITION2Ant")
	if CF2var == 1 then
	CowlFlaps_R_half ()
	elseif CF2var < 1 then
	CowlFlaps_R_close ()
	end
	Duke_CowlFlap2_show ()
end

---

function CowlFlaps_inc ()
	CowlFlaps_L_inc ()
	CowlFlaps_R_inc ()
end

function CowlFlaps_dec ()
	CowlFlaps_L_dec ()
	CowlFlaps_R_dec ()
end


-- ## Other ###############

function XPDR_show ()
	XPDRvar = ipc.readLvar("L:XPDR_State")
	if XPDRvar == 0 then
	XPDRtext = "off"
	elseif XPDRvar == 1 then
	XPDRtext = "sby"
	elseif XPDRvar == 2 then
	XPDRtext = "tst"
	elseif XPDRvar == 3 then
	XPDRtext = "gnd"
	elseif XPDRvar == 4 then
	XPDRtext = "on"
	elseif XPDRvar == 5 then
	XPDRtext = "alt"
	end
	if _MCP1() then
	  DspShow("XPDR", XPDRtext)
	elseif _MCP2() then
	DspRadioShort(XPDRtext)
	end
end

function XPDR_off ()
	ipc.writeLvar("L:XPDR_State", 0)
	XPDR_show ()
end

function XPDR_sby ()
	ipc.writeLvar("L:XPDR_State", 1)
	XPDR_show ()
end

function XPDR_tst ()
	ipc.writeLvar("L:XPDR_State", 2)
	XPDR_show ()
end

function XPDR_gnd ()
	ipc.writeLvar("L:XPDR_State", 3)
XPDR_show ()
end

function XPDR_on ()
	ipc.writeLvar("L:XPDR_State", 4)
	XPDR_show ()
end

function XPDR_alt ()
	  ipc.writeLvar("L:XPDR_State", 5)
	  XPDR_show ()
end


-- XPDR inc

function XPDR_inc ()
	i = ipc.readLvar("L:XPDR_State")
	if i < 5 then
		ipc.writeLvar("L:XPDR_State", i+1)
	end
	if i == 5 then
		ipc.writeLvar("L:XPDR_State", 5)
	end
	XPDR_show ()
end

-- XPDR dec

function XPDR_dec ()
	i = ipc.readLvar("L:XPDR_State")
	if i > 0 then
		ipc.writeLvar("L:XPDR_State", i-1)
	end
	if i == 0 then
		ipc.writeLvar("L:XPDR_State", 0)
	end
	XPDR_show ()
end

function Master_Warning_Reset ()
	LVarSet = "L:MW_Reset"
	ipc.writeLvar(LVarSet, 1)
	DspShow("MSTR", "CLR")
end

function Yoke_Hide ()
	LVarSet = "L:DukeYokeVis"
	ipc.writeLvar(LVarSet, 1)
	DspShow("YOKE", "OFF")
end

function Yoke_Show ()
	LVarSet = "L:DukeYokeVis"
	ipc.writeLvar(LVarSet, 0)
	DspShow("YOKE", "ON")
end

function RXP_530_show ()
	-- shift + 2
	ipc.keypress(50,9)
end

function ParkingBreakesToggle ()
	ParkingBreakState = ipc.readLvar("L:Brake Parking PositionAnt")
	DspShow("pBrk", ParkingBreakState)
end