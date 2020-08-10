MODULE pcb3_scenes_65

LOCAL VAR robtarget pos_a = p:{{60.652483242,-0.000000000,-884.629125108},{0.000000000,0.999968392,-0.000000000,-0.007950728}}{cfg 0,0,0,0}{EJ 0.000000000,0.000000000,0.000000000,0.000000000,0.000000000,0.000000000}
LOCAL VAR robtarget pos_d = p:{{653.442524321,-0.000000000,-671.223402306},{0.000000000,0.814674739,0.000000000,0.579918158}}{cfg 0,0,0,0}{EJ 0.000000000,0.000000000,0.000000000,0.000000000,0.000000000,0.000000000}
LOCAL VAR robtarget pos_e = p:{{-444.377158465,-0.000000000,-839.194778803},{0.000000000,0.842354858,-0.000000000,-0.538923273}}{cfg 0,0,0,0}{EJ 0.000000000,0.000000000,0.000000000,0.000000000,0.000000000,0.000000000}
LOCAL VAR robtarget pos_f = p:{{-657.366,0,-937.534},{0,0.842372,0,-0.538896}}{cfg 0,0,0,0}{EJ 0,0,0,0,0,0}
LOCAL VAR robtarget pos_h = p:{{469.091336834,-0.000000000,-633.679354671},{0.000000000,0.833655822,0.000000000,0.552284320}}{cfg 0,0,0,0}{EJ 0.000000000,0.000000000,0.000000000,0.000000000,0.000000000,0.000000000}

GLOBAL PROC pcb3_scenes_65()
	// pos_a : 平台输送板件位置（放料）
	// pos_d : 不良品暂存点位置（放料）
	// pos_e : 65度RACK初始点位置（取料）
	// pos_f : 65度RACK结束点位置（取料）
	// pos_h : 平台输送板与不良品过渡点位置
	scenes_65_init()
	scenes_65_end()
	scenes_bad_data = (succ_65_init+fail_65_init)%scenes_bad_num
	IF(scenes_bad_data == 0)
		scenes_65_bad()
	ENDIF
ENDPROC

GLOBAL PROC scenes_65_init()
	// 65度RACK初始点（取料）-> 平台输送板（放料）-> 65度RACK初始点
	pcb3_scenes_clocks()
    print("    >>> scenes 65 : step 1")
	MoveJ RelTool(pos_e,0,0,-100,0,0,0),v7000,z50,tool01
	SetDO do0,true
	Wait 0.05
	IF(di_05 == TRUE)
		pcb3_scenes_flagt()
		MoveJ pos_e,v1000,fine,tool01
		scenes_65_com_g()
		MoveJ RelTool(pos_a,0,0,150,0,0,0),v7000,fine,tool01
		pcb3_scenes_iofalse()
		pcb3_scenes_flagp()
		scenes_65_com_r()
		pcb3_scenes_clocke()
		succ_65_init++
	ELSE
		fail_65_init++
	ENDIF
    Print("    >>> scenes 65 (step 1) : succ time ", succ_65_init, " , fail time ", fail_65_init)
	Print()
ENDPROC

GLOBAL PROC scenes_65_end()
	// 65度RACK结束点位置（取料）-> 平台输送板（放料）-> 65度RACK初始点
    pcb3_scenes_clocks()
    print("    >>> scenes 65 : step 2")
	MoveJ RelTool(pos_e,0,0,-100,0,0,0),v7000,z50,tool01
	SetDO do0,true
	Wait 0.05
	IF(di_05 == TRUE)
		pcb3_scenes_flagt()
		MoveJ pos_f,v1000,fine,tool01
		scenes_65_com_g()
		MoveJ RelTool(pos_a,0,0,150,0,0,0),v7000,fine,tool01
		pcb3_scenes_iofalse()
		pcb3_scenes_flagp()
		scenes_65_com_r()
		pcb3_scenes_clocke()
		succ_65_end++
	ELSE
		fail_65_end++
	ENDIF
    Print("    >>> scenes 65 (step 2) : succ time ", succ_65_end, " , fail time ", fail_65_end)
	Print()
ENDPROC

GLOBAL PROC scenes_65_bad()
	// 65度RACK初始点位置(取料)->平台输送板->过渡点h->不良品区(放料)->过渡点h->平台输送板->65度RACK初始点位置
    pcb3_scenes_clocks()
    print("    >>> scenes 65 : step 3")
	MoveJ RelTool(pos_e,0,0,-100,0,0,0),v7000,z50,tool01
	SetDO do0,true
	Wait 0.05
	IF(di_05 == TRUE)
		pcb3_scenes_flagt()
		MoveJ pos_e,v1000,fine,tool01
		scenes_65_com_g()
		MoveJ pos_h,v7000,z50,tool01
		MoveJ RelTool(pos_d,0,0,10,0,0,0),v1000,z50,tool01
		pcb3_scenes_iofalse()
		pcb3_scenes_flagp()
		MoveJ pos_h,v7000,z50,tool01
		scenes_65_com_r()
		pcb3_scenes_clocke()
		succ_65_bad++
	ELSE
		fail_65_bad++
	ENDIF
    Print("    >>> scenes 65 (step 3) : succ time ", succ_65_bad, " , fail time ", fail_65_bad)
	Print()
ENDPROC

LOCAL PROC scenes_65_com_g()
	Wait 0.5		// 取料等待0.5秒
	MoveJ RelTool(pos_e,0,0,-100,0,0,0),v1000,fine,tool01
	Wait 1			// 抖动1秒
	MoveJ pos_a,v7000,z50,tool01
ENDPROC

LOCAL PROC scenes_65_com_r()
	MoveJ pos_a,v7000,fine,tool01
	MoveJ RelTool(pos_e,0,0,-100,0,0,0),v7000,z50,tool01
ENDPROC

ENDMODULE