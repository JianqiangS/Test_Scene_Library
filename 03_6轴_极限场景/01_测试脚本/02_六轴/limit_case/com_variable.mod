MODULE common_variable

GLOBAL VAR double time_delay = 1
GLOBAL VAR int times_cycle = 1000
GLOBAL VAR int times_init = 1
GLOBAL VAR int di_axis_init = 1
GLOBAL VAR int di_axis_end = 4
GLOBAL VAR int di_axis_mode[6] = {0,0,0,0,0,0}
GLOBAL VAR int di_dikaer_mode[6] = {0,0,0,0,0,0}

GLOBAL PROC com_var_value()
    // function : Define variable initialization
    time_delay = 1
    times_cycle = 10000
    times_init = 1
ENDPROC

GLOBAL PROC com_var_axis()
    // function : Define variable initialization
    di_axis_init = 1                // Parameter configuration item, 1/2/3/4/5/6
    di_axis_end = 6                 // Configure according to actual situation, di_axis_init <= di_axis_end
ENDPROC

GLOBAL PROC com_var_dikaer()
    // function : Define variable initialization
    di_dikaer_mode[1] = 1           // Parameter configuration item, 0/1/2
    di_dikaer_mode[2] = 0
    di_dikaer_mode[3] = 1
    di_dikaer_mode[4] = 0
    di_dikaer_mode[5] = 1
    di_dikaer_mode[6] = 0
ENDPROC

ENDMODULE