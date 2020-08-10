MODULE pcb3_com_fun

GLOBAL PROC pcb3_scenes_clocks()
	ClkReset clock_time
	ClkStart clock_time
ENDPROC

GLOBAL PROC pcb3_scenes_clocke()
	ClkStop clock_time
	Print("    [Run Time] : ", ClkRead(clock_time), " s")
ENDPROC

GLOBAL PROC pcb3_scenes_iofalse()
	SetDO do0,false
	Wait 0.5		// 真空关闭等待0.5秒
ENDPROC

GLOBAL PROC pcb3_scenes_flagt()
	// do0 : 气泵输入信号（内部 -> 外部）
	// di_05 : 气泵输出信号（外部 -> 内部）
	flag_out = do0 
	flag_in = di_05
	print("    take the board : ", flag_out, " , ", flag_in)
ENDPROC

GLOBAL PROC pcb3_scenes_flagp()
	flag_out = do0
	flag_in = di_05
	print("    put the board : ", flag_out, " , ", flag_in)
ENDPROC

ENDMODULE