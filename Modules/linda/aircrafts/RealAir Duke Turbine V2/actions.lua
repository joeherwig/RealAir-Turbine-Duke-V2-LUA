-- module 1.0
-- August 2015
-- ################################
-- RealAir Duke Turbine B60 V2
-- ################################

-- ## system ###############

function InitVars ()
	Yoke_Hide ()
	ChangeCabinPressureByXFeet = 250
	ChangeCabinRateByX = 50
	ChangeCabinPressureTempByX = 10
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
		Ignition_L_auto()
	else
		Ignition_L_off()
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
		Ignition_R_auto()
	else
		Ignition_R_off()
	end
end

function Ignition_BOTH_on ()
	Ignition_R_on()
	_sleep(150, 350)
	Ignition_L_on()
	DspShow ("Ign", "on")
end

function Ignition_BOTH_off ()
	Ignition_R_off()
	_sleep(150, 350)
	Ignition_L_off()
	DspShow ("Ign", "off")
end

function Ignition_BOTH_auto ()
	Ignition_BOTH_auto()
	DspShow ("Ign", "auto")
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
	DspShow ("Gen", "On")
end

function Generator_BOTH_off ()
	ipc.writeSB("3b78", 0)
	ipc.writeSB("3ab8", 0)
	DspShow ("Gen", "Off")
end


-- ## Fuel #####################################

-- Fuel Pumps:
function Fuel_Pump_1_ENG_L_on ()
	ipc.control(66340, 0)
	DspShow("Pump L", "1 on")
end

function Fuel_Pump_1_ENG_L_off ()
	ipc.control(66340, 1)
	DspShow("Pump L", "off")
end

function Fuel_Pump_1_ENG_L_toggle()
	Fuel_PumpswitchLState = ipc.readLvar("L:Fuel_PumpswitchL")
	if Fuel_PumpswitchLState == 0 then
		Fuel_Pump_1_ENG_L_on()
	else
		Fuel_Pump_1_ENG_L_off()
	end
end

function Fuel_Pump_1_ENG_R_on ()
	ipc.control(66341, 0)
	DspShow("Pump R", "1 on")
end

function Fuel_Pump_1_ENG_R_off ()
	ipc.control(66341, 1)
	DspShow("Pump R", "off")
end

function Fuel_Pump_1_ENG_R_toggle()
	Fuel_PumpswitchRState = ipc.readLvar("L:Fuel_PumpswitchR")
	if Fuel_PumpswitchRState == 0 then
		Fuel_Pump_1_ENG_R_on()
	else
		Fuel_Pump_1_ENG_R_off()
	end
end

function Fuel_Pumps_on ()
	Fuel_Pump_1_ENG_L_on ()
	_sleep(150, 350)
	Fuel_Pump_1_ENG_R_on ()
end

function Fuel_Pumps_off ()
	 Fuel_Pump_1_ENG_L_off ()
	_sleep(150, 350)
	Fuel_Pump_ENG_2_off ()
end

function Fuel_Pump_1_ENG_L_toggle ()
	 Fuel_Pump_1_ENG_L_off ()
	_sleep(150, 350)
	Fuel_Pump_1_ENG_R_toggle ()
end

-- Fuel Valves:
function Fuel_Valve_ENG_L_on ()
	ipc.writeLvar("L:Duke_Tank_Selector_L", 50)
	DspShow("Fuel", "1 on")
end

function Fuel_Valve_ENG_L_off ()
	ipc.writeLvar("L:Duke_Tank_Selector_L", 0)
	DspShow("Fuel", "1 off")
end

function Fuel_Valve_ENG_L_XFeed ()
	ipc.writeLvar("L:Duke_Tank_Selector_L", 100)
	DspShow("Fuel", "1 XFeed")
end

function Fuel_Valve_ENG_L_dec ()
	Fuel_Valve_L_State = ipc.readLvar("L:Duke_Tank_Selector_L_Ant")
	if Fuel_Valve_L_State == 100 then
		Fuel_Valve_ENG_L_on ()
	elseif Fuel_Valve_L_State == 50 then
		Fuel_Valve_ENG_L_off ()
	end
end

function Fuel_Valve_ENG_L_inc ()
	Fuel_Valve_L_State = ipc.readLvar("L:Duke_Tank_Selector_L_Ant")
	if Fuel_Valve_L_State == 0 then
		Fuel_Valve_ENG_L_on ()
	elseif Fuel_Valve_L_State == 50 then
		Fuel_Valve_ENG_L_XFeed ()
	end
end

function Fuel_Valve_ENG_R_on ()
	ipc.writeLvar("L:Duke_Tank_Selector_R", 50)
	DspShow("Fuel", "2 on")
end

function Fuel_Valve_ENG_R_off ()
	ipc.writeLvar("L:Duke_Tank_Selector_R", 0)
	DspShow("Fuel", "2 off")
end

function Fuel_Valve_ENG_R_XFeed ()
	ipc.writeLvar("L:Duke_Tank_Selector_R", 100)
	DspShow("Fuel", "2 XFeed")
end

function Fuel_Valve_ENG_R_dec ()
	Fuel_Valve_R_State = ipc.readLvar("L:Duke_Tank_Selector_R_Ant")
	if Fuel_Valve_R_State == 100 then
		Fuel_Valve_ENG_R_on()
	elseif Fuel_Valve_R_State == 50 then
		Fuel_Valve_ENG_R_off()
	end
end

function Fuel_Valve_ENG_R_inc ()
	Fuel_Valve_R_State = ipc.readLvar("L:Duke_Tank_Selector_R_Ant")
	if Fuel_Valve_R_State == 0 then
		Fuel_Valve_ENG_R_on()
	elseif Fuel_Valve_R_State == 50 then
		Fuel_Valve_ENG_R_XFeed()
	end
end

function Fuel_Valves_on ()
	Fuel_Valve_ENG_R_on()
	_sleep(350, 550)
	Fuel_Valve_ENG_L_on()
end

function Fuel_Valves_off ()
	Fuel_Valve_ENG_R_off()
	_sleep(350, 550)
	Fuel_Valve_ENG_L_off()
end

function Fuel_Valves_dec ()
	Fuel_Valve_ENG_R_dec()
	_sleep(550, 650)
	Fuel_Valve_ENG_L_dec()
end

function Fuel_Valves_inc ()
	Fuel_Valve_ENG_R_inc()
	_sleep(550, 650)
	Fuel_Valve_ENG_L_inc()
end

function Fuel_Valves_toggle_OnOff()
	Fuel_Valve_L_State = ipc.readLvar("L:Duke_Tank_Selector_L_Ant")
	if Fuel_Valve_L_State == 0 then
		Fuel_Valves_on()
	else
		Fuel_Valves_off()
	end
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

function Parking_Breakes_set ()
	ParkingBreakState = ipc.readLvar("L:Brake Parking PositionAnt")
	if ParkingBreakState <= 50 then
    	ipc.control("65752", 1)
    end
	DspShow("ParkBrk", "set")
end

function Parking_Breakes_release ()
	ParkingBreakState = ipc.readLvar("L:Brake Parking PositionAnt")
	if ParkingBreakState >= 50 then
        ipc.control("65752", 0)
    end
    DspShow("ParkBrk", "release")
end
function Parking_Breakes_toggle ()
	ParkingBreakState = ipc.readLvar("L:Brake Parking PositionAnt")
	if ParkingBreakState <= 50 then
        Parking_Breakes_set ()
	else
        Parking_Breakes_release ()
	end
end

-- ## Cabin ###############

function Cabin_Temp_Mode_manual_cool()
	ipc.writeLvar("L:CabinTempMode", -3)
	DspShow ("CTemp", "cManual")
end

function Cabin_Temp_Mode_cool_auto()
	ipc.writeLvar("L:CabinTempMode", -2)
	DspShow ("CTemp", "cAuto")
end

function Cabin_Temp_Mode_cool_blower()
	ipc.writeLvar("L:CabinTempMode", -1)
	DspShow ("CTemp", "cBlower")
end

function Cabin_Temp_Mode_off()
	ipc.writeLvar("L:CabinTempMode", 0)
	DspShow ("CTemp", "off")
end

function Cabin_Temp_Mode_heat_auto()
	ipc.writeLvar("L:CabinTempMode", 1)
	DspShow ("CTemp", "hAuto")
end

function Cabin_Temp_Mode_heat_manual()
	ipc.writeLvar("L:CabinTempMode", 2)
	DspShow ("CTemp", "hManual")
end

function Cabin_Temp_Mode_heat_blower()
	ipc.writeLvar("L:CabinTempMode", 3)
	DspShow ("CTemp", "hBlower")
end

function Cabin_Temp_Mode_inc()
	CabinModeState = ipc.readLvar("L:CabinTempMode")
	if CabinModeState == -3 then
		Cabin_Temp_Mode_cool_auto()
	elseif CabinModeState == -2 then
		Cabin_Temp_Mode_cool_blower()
	elseif CabinModeState == -1 then
		Cabin_Temp_Mode_off()
	elseif CabinModeState == 0 then
		Cabin_Temp_Mode_heat_auto()
	elseif CabinModeState == 1 then
		Cabin_Temp_Mode_heat_manual()
	else
		Cabin_Temp_Mode_heat_blower()
	end
end

function Cabin_Temp_Mode_dec()
	CabinModeState = ipc.readLvar("L:CabinTempMode")
	if CabinModeState == 3 then
		Cabin_Temp_Mode_heat_manual()
	elseif CabinModeState == 2 then
		Cabin_Temp_Mode_heat_auto()
	elseif CabinModeState == 1 then
		Cabin_Temp_Mode_off()
	elseif CabinModeState == 0 then
		Cabin_Temp_Mode_cool_blower()
	elseif CabinModeState == -1 then
		Cabin_Temp_Mode_cool_auto()
	else
		Cabin_Temp_Mode_manual_cool()
	end
end

function Cabin_Air_Knob_pull()
	ipc.writeLvar("L:CabinAirLever", 1)
	DspShow ("Cab Air", "on")
end

function Cabin_Air_Knob_push()
	ipc.writeLvar("L:CabinAirLever", 0)
	DspShow ("Cab Air", "off")
end

function Cabin_Air_Knob_toggle()
	Cabin_Air_KnobState = ipc.readLvar("L:cabinAirLeverAnt")
	if Cabin_Air_KnobState == 0 then
		Cabin_Air_Knob_pull()
	else
		Cabin_Air_Knob_push()
	end
end

function Copilot_Air_Knob_pull()
	ipc.writeLvar("L:copilotAirLever", 1)
	DspShow ("FO Air", "on")
end

function Copilot_Air_Knob_push()
	ipc.writeLvar("L:copilotAirLever", 0)
	DspShow ("FO Air", "off")
end

function Copilot_Air_Knob_toggle()
	Copilot_Air_KnobState = ipc.readLvar("L:copilotAirLeverAnt")
	if Copilot_Air_KnobState == 0 then
		Copilot_Air_Knob_pull()
	else
		Copilot_Air_Knob_push()
	end
end

-- copilotAirLeverAnt

function Cabin_Pressure_alt_goal_dec()
	CabinPressureAlt = ipc.readLvar("L:cabinAltGoal")
	if CabinPressureAlt > ChangeCabinPressureByXFeet then
        ipc.writeLvar("L:cabinAltGoal", CabinPressureAlt - ChangeCabinPressureByXFeet)
	else
	    ipc.writeLvar("L:cabinAltGoal", 0)
	end
	CabinPressureAlt = ipc.readLvar("L:cabinAltGoal")
	DspShow ("CPress", CabinPressureAlt)
end

function Cabin_Pressure_alt_goal_inc()
	CabinPressureAlt = ipc.readLvar("L:cabinAltGoal")
	if CabinPressureAlt <= 10000 - ChangeCabinPressureByXFeet then
        ipc.writeLvar("L:cabinAltGoal", CabinPressureAlt + ChangeCabinPressureByXFeet)
	else
	    ipc.writeLvar("L:cabinAltGoal", 10000)
	end
	CabinPressureAlt = ipc.readLvar("L:cabinAltGoal")
	DspShow ("CPress", CabinPressureAlt)
end

function Cabin_Pressure_Dump_off()
	ipc.writeLvar("L:pressureDumpSwitch", 0)
	DspShow ("CPrDump", "off")
end

function Cabin_Pressure_Dump_on()
	ipc.writeLvar("L:pressureDumpSwitch", 1)
	DspShow ("CPrDump", "dump")
end

function Cabin_Pressure_Dump_toggle()
	CabinPressureDumpState = ipc.readLvar("L:pressureDumpSwitchAnt")
	if CabinPressureDumpState == 1 then
		Cabin_Pressure_Dump_off()
	else
		Cabin_Pressure_Dump_on()
	end
end

function Cabin_Rate_Knob_dec()
	CabinRateVal = ipc.readLvar("L:CabinRateKnob")
	if CabinRateAlt > ChangeCabinRateByX then
        ipc.writeLvar("L:CabinRateKnob", CabinRateAlt - ChangeCabinRateByX)
	else
	    ipc.writeLvar("L:CabinRateKnob", 100)
	end
	CabinRateAlt = ipc.readLvar("L:CabinRateKnob")
	DspShow ("CRate", CabinRateAlt)
end

function Cabin_Rate_Knob_inc()
	CabinRateState = ipc.readLvar("L:CabinRateKnob")
	if CabinRateState <= 2000 - ChangeCabinRateByX then
        ipc.writeLvar("L:CabinRateKnob", CabinRateState + ChangeCabinRateByX)
	else
	    ipc.writeLvar("L:CabinRateKnob", 2000)
	end
	CabinRateAlt = ipc.readLvar("L:CabinRateKnob")
	DspShow ("CRate", CabinRateAlt)
end

function Cabin_Pressure_Shutoff_Lever_1_on()
	ipc.writeLvar("L:pressAirShutoffLever1", 1)
	DspShow ("Shutof1", "on")
end

function Cabin_Pressure_Shutoff_Lever_1_off()
	ipc.writeLvar("L:pressAirShutoffLever1", 0)
	DspShow ("Shutof1", "off")
end

function Cabin_Pressure_Shutoff_Lever_1_toggle()
	CabinShutoff1State = ipc.readLvar("L:pressAirShutoffLever1Ant")
	if CabinShutoff1State == 0 then
		Cabin_Pressure_Shutoff_Lever_1_on()
	else
		Cabin_Pressure_Shutoff_Lever_1_off()
	end
end

function Cabin_Pressure_Shutoff_Lever_2_on()
	ipc.writeLvar("L:pressAirShutoffLever2", 1)
	DspShow ("Shutof2", "on")
end

function Cabin_Pressure_Shutoff_Lever_2_off()
	ipc.writeLvar("L:pressAirShutoffLever2", 0)
	DspShow ("Shutof2", "off")
end

function Cabin_Pressure_Shutoff_Lever_2_toggle()
	CabinShutoff2State = ipc.readLvar("L:pressAirShutoffLever2Ant")
	if CabinShutoff2State == 0 then
		Cabin_Pressure_Shutoff_Lever_2_on()
	else
		Cabin_Pressure_Shutoff_Lever_2_off()
	end
end

function Cabin_Pressure_Temp_Lever_1_inc ()
	CabinPressTemp1Value = ipc.readLvar("L:pressTempLever1")
	if CabinPressTemp1Value <= 25 - ChangeCabinPressureTempByX then
        ipc.writeLvar("L:pressTempLever1", CabinPressTemp1Value + ChangeCabinPressureTempByX)
	else
	    ipc.writeLvar("L:pressTempLever1", 25)
	end
	CabinPressTemp1Value = ipc.readLvar("L:pressTempLever1")
	DspShow ("CPrTemp1", CabinPressTemp1Value)
end

function Cabin_Pressure_Temp_Lever_1_dec ()
	CabinPressTemp1Value = ipc.readLvar("L:pressTempLever1")
	if CabinPressTemp1Value >= -75 + ChangeCabinPressureTempByX then
        ipc.writeLvar("L:pressTempLever1", CabinPressTemp1Value - ChangeCabinPressureTempByX)
	else
	    ipc.writeLvar("L:pressTempLever1", -75)
	end
	CabinPressTemp1Value = ipc.readLvar("L:pressTempLever1")
	DspShow ("CPrTemp1", CabinPressTemp1Value)
end

function Cabin_Pressure_Temp_Lever_2_inc ()
	CabinPressTemp2Value = ipc.readLvar("L:pressTempLever2")
	if CabinPressTemp2Value <= 25 - ChangeCabinPressureTempByX then
        ipc.writeLvar("L:pressTempLever2", CabinPressTemp2Value + ChangeCabinPressureTempByX)
	else
	    ipc.writeLvar("L:pressTempLever2", 25)
	end
	CabinPressTemp2Value = ipc.readLvar("L:pressTempLever2")
	DspShow ("CPrTemp2", CabinPressTemp2Value)
end

function Cabin_Pressure_Temp_Lever_2_dec ()
	CabinPressTemp2Value = ipc.readLvar("L:pressTempLever2")
	if CabinPressTemp2Value >= -75 + ChangeCabinPressureTempByX then
        ipc.writeLvar("L:pressTempLever2", CabinPressTemp2Value - ChangeCabinPressureTempByX)
	else
	    ipc.writeLvar("L:pressTempLever2", -75)
	end
	CabinPressTemp2Value = ipc.readLvar("L:pressTempLever2")
	DspShow ("CPrTemp2", CabinPressTemp2Value)
end

