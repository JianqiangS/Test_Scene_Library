MODULE common_function

LOCAL VAR clock clock_time

GLOBAL PROC clock_start_timing()
	ClkReset clock_time
	ClkStart clock_time
ENDPROC

GLOBAL PROC clock_end_timing()
	ClkStop clock_time
	Print("    [Run Time] : ", ClkRead(clock_time), " s")
    Print()
ENDPROC

ENDMODULE