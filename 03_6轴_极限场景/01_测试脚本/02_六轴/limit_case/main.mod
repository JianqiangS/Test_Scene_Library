MODULE MainModule

GLOBAL PROC main()
    com_var_value()
    WHILE(times_init <= times_cycle)
        clock_start_timing()
		Print("---------------------------------------")
		print("[Cycle] : the ", times_init, " times")
        main_axis()
        wait time_delay
        main_dikaer()
        wait time_delay
        times_init++
        clock_end_timing()
    ENDWHILE
ENDPROC

ENDMODULE