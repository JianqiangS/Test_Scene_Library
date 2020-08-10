MODULE pcb3_com_var

GLOBAL VAR bool flag_in = false
GLOBAL VAR bool flag_out = false
GLOBAL VAR clock clock_time
GLOBAL VAR double delay_time = 1.0
GLOBAL VAR int scenes_run_num = 1
GLOBAL VAR int scenes_bad_num = 100
GLOBAL VAR int scenes_bad_data = 0
GLOBAL VAR int scenes_45_num = 0
GLOBAL VAR int scenes_65_num = 0
GLOBAL VAR int succ_45_init = 0
GLOBAL VAR int fail_45_init = 0
GLOBAL VAR int succ_45_end = 0
GLOBAL VAR int fail_45_end = 0
GLOBAL VAR int succ_45_bad = 0
GLOBAL VAR int fail_45_bad = 0
GLOBAL VAR int succ_65_init = 0
GLOBAL VAR int fail_65_init = 0
GLOBAL VAR int succ_65_end = 0
GLOBAL VAR int fail_65_end = 0
GLOBAL VAR int succ_65_bad = 0
GLOBAL VAR int fail_65_bad = 0
GLOBAL VAR string scenes_mode = ""
GLOBAL VAR string so_conn_ip = "192.168.0.88"
GLOBAL VAR string so_conn_name = "pcb"
GLOBAL VAR int so_conn_port = 8080

GLOBAL PROC pcb3_scenes_vars()
    delay_time = 1.0
    scenes_bad_num = 100
    so_conn_ip = "192.168.0.88"
    so_conn_name = "pcb"
    so_conn_port = 8080
ENDPROC

ENDMODULE