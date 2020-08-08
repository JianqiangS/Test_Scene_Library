MODULE coordinate_axis

LOCAL VAR jointtarget axis1_limit_p = j:{90.330724795,-0.002769281,-0.001455688,0.000000000,0.000000000,0.000000000}{EJ 0.000000000,0.000000000,0.000000000,0.000000000,0.000000000,0.000000000}
LOCAL VAR jointtarget axis1_limit_n = j:{-90.178686725,-0.003200563,-0.001565552,0.000000000,0.000000000,0.000000000}{EJ 0.000000000,0.000000000,0.000000000,0.000000000,0.000000000,0.000000000}

LOCAL VAR jointtarget axis2_limit_p = j:{8.449643978,50.376627268,-0.000054932,0.000000000,0.000000000,0.000000000}{EJ 0.000000000,0.000000000,0.000000000,0.000000000,0.000000000,0.000000000}
LOCAL VAR jointtarget axis2_limit_n = j:{8.445830542,-160.125323839,-0.000192261,0.000000000,0.000000000,0.000000000}{EJ 0.000000000,0.000000000,0.000000000,0.000000000,0.000000000,0.000000000}

LOCAL VAR jointtarget axis3_limit_p = j:{0.000136194,-0.000090796,100.030105591,0.000000000,0.000000000,0.000000000}{EJ 0.000000000,0.000000000,0.000000000,0.000000000,0.000000000,0.000000000}
LOCAL VAR jointtarget axis3_limit_n = j:{0.000181592,-0.000090796,-101.002835083,0.000000000,0.000000000,0.000000000}{EJ 0.000000000,0.000000000,0.000000000,0.000000000,0.000000000,0.000000000}

LOCAL VAR jointtarget axis4_limit_p = j:{0.000000000,-0.000022699,-0.000082397,0.000000000,0.000000000,0.000000000}{EJ 0.000000000,0.000000000,0.000000000,0.000000000,0.000000000,0.000000000}
LOCAL VAR jointtarget axis4_limit_n = j:{0.000000000,-0.000022699,-0.000082397,0.000000000,0.000000000,0.000000000}{EJ 0.000000000,0.000000000,0.000000000,0.000000000,0.000000000,0.000000000}

LOCAL VAR jointtarget axis5_limit_p = j:{0.000000000,-0.000022699,-0.000109863,0.000000000,0.000000000,0.000000000}{EJ 0.000000000,0.000000000,0.000000000,0.000000000,0.000000000,0.000000000}
LOCAL VAR jointtarget axis5_limit_n = j:{0.000000000,-0.000022699,-0.000109863,0.000000000,0.000000000,0.000000000}{EJ 0.000000000,0.000000000,0.000000000,0.000000000,0.000000000,0.000000000}

LOCAL VAR jointtarget axis6_limit_p = j:{0.000000000,-0.000022699,-0.000109863,0.000000000,0.000000000,0.000000000}{EJ 0.000000000,0.000000000,0.000000000,0.000000000,0.000000000,0.000000000}
LOCAL VAR jointtarget axis6_limit_n = j:{0.000000000,-0.000022699,-0.000109863,0.000000000,0.000000000,0.000000000}{EJ 0.000000000,0.000000000,0.000000000,0.000000000,0.000000000,0.000000000}

LOCAL VAR string axis_direct = ""

GLOBAL PROC main_axis()
    // function : program enter interface
    com_var_axis()
    axis_para_check_c()
    axis_para_check_a()
    axis_para_config()
    print()
ENDPROC

LOCAL PROC axis_para_check_c()
    // function : check the correctness of input configuration parameter
    IF((di_axis_init < 1) || (di_axis_init > 6))
        print("[ERROR] : di_axis_init = ", di_axis_init)
        print("    di_axis_init = 1/2/3/4/5/6")
        axis_para_choice()
    ENDIF

    IF((di_axis_end < 1) || (di_axis_end > 6))
        print("[ERROR] : di_axis_end = ", di_axis_end)
        print("    di_axis_end = 1/2/3/4/5/6")
        axis_para_choice()
    ENDIF

    IF(di_axis_init > di_axis_end)
        print("[ERROR] : (di_axis_init=", di_axis_init, ") > (di_axis_end=", di_axis_end, ")")
        EXIT
    ENDIF
ENDPROC

LOCAL PROC axis_para_check_a()
    // function : check the correctness of input configuration parameter
    IF((di_axis_mode[di_axis_init] < 0) || (di_axis_mode[di_axis_init] > 1))
        axis_para_action()
    ENDIF
ENDPROC

LOCAL PROC axis_para_choice()
    var int index = 1
    WHILE(index <= 6)
        print("    >>> ", index, " : means axis", index)
        index++
    ENDWHILE
    EXIT
ENDPROC

LOCAL PROC axis_para_action()
    print("[ERROR] : di_axis_mode[di_axis_init] = ", di_axis_mode[di_axis_init])
    print("    di_axis_mode[di_axis_init] = 0/1")
    print("    >>> 0 : means axis turn to negative limit")
    print("    >>> 1 : means axis turn to positive limit")
    EXIT
ENDPROC

LOCAL PROC axis_para_config()
    // function : input parameter configuration
    WHILE(di_axis_init < 7)
        Home
        IF(di_axis_mode[di_axis_init] == 0)
            axis_para_motion_n()
            axis_para_motion_p()
        ELSE
            axis_para_motion_p()
            axis_para_motion_n()
        ENDIF
        di_axis_init++
        IF(di_axis_init > di_axis_end)
            break
        ENDIF
    ENDWHILE
ENDPROC

LOCAL PROC axis_para_motion_n()
    di_axis_mode[di_axis_init] = 0
    axis_direct = "negative"
    print("[INFO] : axis", di_axis_init, " ; direction ", axis_direct)
    axis_di_axis_mode()
ENDPROC

LOCAL PROC axis_para_motion_p()
    di_axis_mode[di_axis_init] = 1
    axis_direct = "positive"
    print("[INFO] : axis", di_axis_init, " ; direction ", axis_direct)
    axis_di_axis_mode()
ENDPROC

LOCAL PROC axis_di_axis_mode()
    // function : perform action response
    axis_axis1()
    axis_axis2()
    axis_axis3()
    axis_axis4()
    axis_axis5()
    axis_axis6()
    axis_cjoint()
ENDPROC

LOCAL PROC axis_cjoint()
    // function : get the current position coordinates 
    print("    axis space status ：", CJointT())
    wait time_delay
ENDPROC

LOCAL PROC axis_axis1()
    // function : axis1 moves to the positive or negative limit positions
    IF(di_axis_init == 1)
        IF(di_axis_mode[di_axis_init] == 0)
            MoveAbsJ axis1_limit_n,v1000,z60,tool0
        ELSE
            MoveAbsJ axis1_limit_p,v1000,z60,tool0
        ENDIF
    ENDIF
ENDPROC

LOCAL PROC axis_axis2()
    // function : axis2 moves to the positive or negative limit positions
    IF(di_axis_init == 2)
        IF(di_axis_mode[di_axis_init] == 0)
            MoveAbsJ axis2_limit_n,v1000,z60,tool0
        ELSE
            MoveAbsJ axis2_limit_p,v1000,z60,tool0
        ENDIF
    ENDIF
ENDPROC

LOCAL PROC axis_axis3()
    // function : axis3 moves to the positive or negative limit positions
    IF(di_axis_init == 3)
        IF(di_axis_mode[di_axis_init] == 0)
            MoveAbsJ axis3_limit_n,v1000,z60,tool0
        ELSE
            MoveAbsJ axis3_limit_p,v1000,z60,tool0
        ENDIF
    ENDIF
ENDPROC

LOCAL PROC axis_axis4()
    // function : axis4 moves to the positive or negative limit positions
    IF(di_axis_init == 4)
        IF(di_axis_mode[di_axis_init] == 0)
            MoveAbsJ axis4_limit_n,v1000,z60,tool0
        ELSE
            MoveAbsJ axis4_limit_p,v1000,z60,tool0
        ENDIF
    ENDIF
ENDPROC

LOCAL PROC axis_axis5()
    // function : axis5 moves to the positive or negative limit positions
    IF(di_axis_init == 5)
        IF(di_axis_mode[di_axis_init] == 0)
            MoveAbsJ axis5_limit_n,v1000,z60,tool0
        ELSE
            MoveAbsJ axis5_limit_p,v1000,z60,tool0
        ENDIF
    ENDIF
ENDPROC

LOCAL PROC axis_axis6()
    // function : axis6 moves to the positive or negative limit positions
    IF(di_axis_init == 6)
        IF(di_axis_mode[di_axis_init] == 0)
            MoveAbsJ axis6_limit_n,v1000,z60,tool0
        ELSE
            MoveAbsJ axis6_limit_p,v1000,z60,tool0
        ENDIF
    ENDIF
ENDPROC

ENDMODULE