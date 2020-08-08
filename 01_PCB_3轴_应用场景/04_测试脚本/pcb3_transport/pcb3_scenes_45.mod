MODULE pcb3_scenes_45

LOCAL VAR robtarget pos_a = p:{{60.652483242,-0.000000000,-884.629125108},{0.000000000,0.999968392,-0.000000000,-0.007950728}}{cfg 0,0,0,0}{EJ 0.000000000,0.000000000,0.000000000,0.000000000,0.000000000,0.000000000}
LOCAL VAR robtarget pos_b = p:{{-553.242,0,-857.308},{0,0.923803,0,-0.382869}}{cfg 0,0,0,0}{EJ 0,0,0,0,0,0}
LOCAL VAR robtarget pos_d = p:{{653.442524321,-0.000000000,-671.223402306},{0.000000000,0.814674739,0.000000000,0.579918158}}{cfg 0,0,0,0}{EJ 0.000000000,0.000000000,0.000000000,0.000000000,0.000000000,0.000000000}
LOCAL VAR robtarget pos_h = p:{{469.091336834,-0.000000000,-633.679354671},{0.000000000,0.833655822,0.000000000,0.552284320}}{cfg 0,0,0,0}{EJ 0.000000000,0.000000000,0.000000000,0.000000000,0.000000000,0.000000000}
LOCAL VAR robtarget pos_g = p:{{-344.034,0,-786.761},{0,0.851603,0,-0.524187}}{cfg 0,0,0,0}{EJ 0,0,0,0,0,0}

GLOBAL PROC pcb3_scenes_45()
	// pos_a : 平台输送板件位置（放料）
	// pos_b : 45度RACK初始点位置（取料）
	// pos_d : 不良品暂存点位置（放料）
	// pos_g : 45度RACK取料与放料过渡点位置
	// pos_h : 平台输送板与不良品过渡点位置
	scenes_45_init()
	scenes_45_end()
	scenes_bad_data = (succ_45_init+fail_45_init)%scenes_bad_num
	IF(scenes_bad_data == 0)
		scenes_45_bad()
	ENDIF
ENDPROC

GLOBAL PROC scenes_45_init()
	// 45度RACK初始点（取料）-> 过渡点g -> 平台输送板（放料）-> 过渡点g -> 45度RACK初始点
	pcb3_scenes_clocks()
	print("    >>> scenes 45 : step 1")
	MoveJ RelTool(pos_b,0,0,-20,0,0,0),v7000,z50,tool01
	SetDO do0,true
	Wait 0.05
	IF(di_05 == TRUE)
		pcb3_scenes_flagt()
		MoveJ pos_b,v1000,fine,tool01
		scenes_45_com_g()
		MoveJ RelTool(pos_a,0,0,150,0,0,0),v7000,fine,tool01
		pcb3_scenes_iofalse()
		pcb3_scenes_flagp()
		scenes_45_com_r()
		pcb3_scenes_clocke()
		succ_45_init++
	ELSE
		fail_45_init++
	ENDIF
	Print("    >>> scenes 45 (step 1) : succ time ", succ_45_init, " , fail time ", fail_45_init)
	Print()
ENDPROC

GLOBAL PROC scenes_45_end()
    // 45度RACK结束点位置（取料）-> 过渡点g -> 平台输送板（放料）-> 过渡点g -> 45度RACK初始点
	pcb3_scenes_clocks()
    print("    >>> scenes 45 : step 2")
	MoveJ RelTool(pos_b,0,0,-20,0,0,0),v7000,z50,tool01
	SetDO do0,true
	Wait 0.05
	IF(di_05 == TRUE)
		pcb3_scenes_flagt()
		MoveJ RelTool(pos_b,0,0,172,0,0,0),v1000,fine,tool01
		scenes_45_com_g()
		MoveJ RelTool(pos_a,0,0,150,0,0,0),v7000,fine,tool01
		pcb3_scenes_iofalse()
		pcb3_scenes_flagp()
		scenes_45_com_r()
		pcb3_scenes_clocke()
		succ_45_end++
	ELSE
		fail_45_end++
	ENDIF
    Print("    >>> scenes 45 (step 2) : succ time ", succ_45_end, " , fail time ", fail_45_end)
	Print()
ENDPROC

GLOBAL PROC scenes_45_bad()
    // 45度RACK初始点位置(取料)->过渡点g->平台输送板->过渡点h->不良品区(放料)->过渡点h->平台输送板->过渡点g->45度RACK初始点位置
    pcb3_scenes_clocks()
    print("    >>> scenes 45 : step 3")
	MoveJ RelTool(pos_b,0,0,-20,0,0,0),v7000,z50,tool01
	SetDO do0,true
	Wait 0.05
	IF(di_05 == TRUE)
		pcb3_scenes_flagt()
		MoveJ pos_b,v1000,fine,tool01
		scenes_45_com_g()
		MoveJ pos_h,v7000,z50,tool01
		MoveJ RelTool(pos_d,0,0,10,0,0,0),v1000,z50,tool01
		pcb3_scenes_iofalse()
		pcb3_scenes_flagp()
		MoveJ pos_h,v7000,z50,tool01
		scenes_45_com_r()
		pcb3_scenes_clocke()
		succ_45_bad++
	ELSE
		fail_45_bad++
	ENDIF
    Print("    >>> scenes 45 (step 3) : succ time ", succ_45_bad, " , fail time ", fail_45_bad)
	Print()
ENDPROC

GLOBAL PROC scenes_45_com_g()
	Wait 0.5		// 取料等待0.5秒
	MoveJ RelTool(pos_b,0,0,-20,0,0,0),v1000,fine,tool01
	Wait 1			// 抖动1秒
	MoveJ pos_g,v7000,z50,tool01
	MoveJ pos_a,v7000,z50,tool01
ENDPROC

GLOBAL PROC scenes_45_com_r()
	MoveJ pos_a,v7000,fine,tool01
	MoveJ pos_g,v7000,z50,tool01
	MoveJ RelTool(pos_b,0,0,-20,0,0,0),v7000,z50,tool01
ENDPROC

ENDMODULE