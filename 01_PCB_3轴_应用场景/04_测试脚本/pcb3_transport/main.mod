MODULE MainModule

GLOBAL PROC main()
	main_pcb3_scenes()
ENDPROC

GLOBAL PROC main_pcb3_scenes()
	pcb3_scenes_vars()
	socketclose(so_conn_name)
	socketcreate(so_conn_ip,so_conn_port,client,"\r",so_conn_name)
	WHILE(true)
		Print("----------------------------")
		Print("[Cycle] : the ", scenes_run_num, " times")
		scenes_mode = socketreadstring(60,so_conn_name)
		IF(scenes_mode == "45")
			scenes_45_num++
			pcb3_scenes_45()
		ENDIF
		IF(scenes_mode == "65")
			scenes_65_num++
			pcb3_scenes_65()
		ENDIF
		scenes_run_num++
		Print("[Scenes 45] : Run ", scenes_45_num, " times")
        Print("[Scenes 65] : Run ", scenes_65_num, " times")
		Print("----------------------------")
		Print()
		WAIT delay_time
	ENDWHILE
ENDPROC

ENDMODULE