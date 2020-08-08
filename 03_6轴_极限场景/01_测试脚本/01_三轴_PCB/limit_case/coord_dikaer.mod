MODULE  coordinate_dikaer

LOCAL VAR robtarget dikaerx_limit_p = p:{{848.732388514,-0.000000000,-854.619077048},{0.000000000,0.706870840,0.000000000,0.707342643}}{cfg 0,0,0,0}{EJ 0.000000000,0.000000000,0.000000000,0.000000000,0.000000000,0.000000000}
LOCAL VAR robtarget dikaerx_limit_n = p:{{-559.131691654,-0.000000000,-854.718955301},{0.000000000,0.706834164,0.000000000,0.707379293}}{cfg 0,0,0,0}{EJ 0.000000000,0.000000000,0.000000000,0.000000000,0.000000000,0.000000000}

LOCAL VAR robtarget dikaery_limit_p = p:{{848.732388514,-0.000000000,-854.619077048},{0.000000000,0.706870840,0.000000000,0.707342643}}{cfg 0,0,0,0}{EJ 0.000000000,0.000000000,0.000000000,0.000000000,0.000000000,0.000000000}
LOCAL VAR robtarget dikaery_limit_n = p:{{-559.131691654,-0.000000000,-854.718955301},{0.000000000,0.706834164,0.000000000,0.707379293}}{cfg 0,0,0,0}{EJ 0.000000000,0.000000000,0.000000000,0.000000000,0.000000000,0.000000000}

LOCAL VAR robtarget dikaerz_limit_p = p:{{548.193199342,-0.000000000,-1139.705770198},{0.000000000,0.706952866,0.000000000,0.707260663}}{cfg 0,0,0,0}{EJ 0.000000000,0.000000000,0.000000000,0.000000000,0.000000000,0.000000000}
LOCAL VAR robtarget dikaerz_limit_n = p:{{547.549807125,0.000000000,328.327657453},{0.000000000,0.706449668,0.000000000,0.707763284}}{cfg 0,0,0,0}{EJ 0.000000000,0.000000000,0.000000000,0.000000000,0.000000000,0.000000000}

LOCAL VAR robtarget dikaera_limit_p = p:{{548.361043676,-0.000000000,-854.624990708},{-0.000000000,-0.136248618,0.000000000,0.990674676}}{cfg 0,0,0,0}{EJ 0.000000000,0.000000000,0.000000000,0.000000000,0.000000000,0.000000000}
LOCAL VAR robtarget dikaera_limit_n = p:{{548.409959522,-0.000000000,-854.567364927},{0.000000000,0.981997811,-0.000000000,-0.188892296}}{cfg 0,0,0,0}{EJ 0.000000000,0.000000000,0.000000000,0.000000000,0.000000000,0.000000000}

LOCAL VAR robtarget dikaerb_limit_p = p:{{548.361043676,-0.000000000,-854.624990708},{-0.000000000,-0.136248618,0.000000000,0.990674676}}{cfg 0,0,0,0}{EJ 0.000000000,0.000000000,0.000000000,0.000000000,0.000000000,0.000000000}
LOCAL VAR robtarget dikaerb_limit_n = p:{{548.409959522,-0.000000000,-854.567364927},{0.000000000,0.981997811,-0.000000000,-0.188892296}}{cfg 0,0,0,0}{EJ 0.000000000,0.000000000,0.000000000,0.000000000,0.000000000,0.000000000}

LOCAL VAR robtarget dikaerc_limit_p = p:{{548.361043676,-0.000000000,-854.624990708},{-0.000000000,-0.136248618,0.000000000,0.990674676}}{cfg 0,0,0,0}{EJ 0.000000000,0.000000000,0.000000000,0.000000000,0.000000000,0.000000000}
LOCAL VAR robtarget dikaerc_limit_n = p:{{548.409959522,-0.000000000,-854.567364927},{0.000000000,0.981997811,-0.000000000,-0.188892296}}{cfg 0,0,0,0}{EJ 0.000000000,0.000000000,0.000000000,0.000000000,0.000000000,0.000000000}

GLOBAL PROC main_dikaer()
    // function : program enter interface
    com_var_dikaer()
    dikaer_para_choice()
    dikaer_di_mode()
    print()
ENDPROC

LOCAL PROC dikaer_para_choice()
    var int dikaer_index = 1
    WHILE(dikaer_index <= 6)
        IF((di_dikaer_mode[dikaer_index] < 0) && (di_dikaer_mode[dikaer_index] > 6))
            print("[ERROR] : di_dikaer_mode[", dikaer_index, "] = ", di_dikaer_mode[dikaer_index])
            print("    di_dikaer_mode[", dikaer_index, "] = 0/1/2"
            print("    >>> 0 : means axis turn to negative limit")
            print("    >>> 1 : means axis turn to positive limit")
            print("    >>> 2 : means axis not responding")
            EXIT
        ENDIF
        dikaer_index++
    ENDWHILE
ENDPROC

LOCAL PROC dikaer_di_mode()
    // function : perform action response
    Home
    dikaer_motion_x()
    dikaer_motion_y()
    dikaer_motion_z()
    dikaer_motion_a()
    dikaer_motion_b()
    dikaer_motion_c()
ENDPROC

LOCAL PROC dikaer_crobt()
    // function : get the current position coordinates 
    print("    dikaer space status ：", CRobT())
    wait time_delay
ENDPROC

LOCAL PROC dikaer_motion_x()
    // function : moves to the positive or negative x limit positions
    IF(di_dikaer_mode[1] == 2)
        print("[INFO] : dikaer_x ; not response")
    ELSE
        IF(di_dikaer_mode[1] == 0)
            print("[INFO] : dikaer_x ; direction negative")
            MoveL dikaerx_limit_n,v1000,z50,tool0
            dikaer_crobt()
            
            di_dikaer_mode[1] == 1
            print("[INFO] : dikaer_x ; direction positive")
            MoveL dikaerx_limit_p,v1000,z50,tool0
            dikaer_crobt()
            Home
        ELSE
            print("[INFO] : dikaer_x ; direction positive")
            MoveL dikaerx_limit_p,v1000,z50,tool0
            dikaer_crobt()

            di_dikaer_mode[1] == 0
            print("[INFO] : dikaer_x ; direction negative")
            MoveL dikaerx_limit_n,v1000,z50,tool0
            dikaer_crobt()
            Home
        ENDIF
    ENDIF
ENDPROC

LOCAL PROC dikaer_motion_y()
    // function : moves to the positive or negative y limit positions
    IF(di_dikaer_mode[2] == 2)
        print("[INFO] : dikaer_y ; not response")
    ELSE
        IF(di_dikaer_mode[2] == 0)
            print("[INFO] : dikaer_y ; direction negative")
            MoveL dikaery_limit_n,v1000,z50,tool0
            dikaer_crobt()

            di_dikaer_mode[2] == 1
            print("[INFO] : dikaer_y ; direction positive")
            MoveL dikaery_limit_p,v1000,z50,tool0
            dikaer_crobt()
            Home
        ELSE
            print("[INFO] : dikaer_y ; direction positive")
            MoveL dikaery_limit_p,v1000,z50,tool0
            dikaer_crobt()

            di_dikaer_mode[2] == 0
            print("[INFO] : dikaer_y ; direction negative")
            MoveL dikaery_limit_n,v1000,z50,tool0
            dikaer_crobt()
            Home
        ENDIF
    ENDIF
ENDPROC

LOCAL PROC dikaer_motion_z()
    // function : moves to the positive or negative z limit positions
    IF(di_dikaer_mode[3] == 2)
        print("[INFO] : dikaer_z ; not response")
    ELSE
        IF(di_dikaer_mode[3] == 0)
            print("[INFO] : dikaer_z ; direction negative")
            MoveL dikaerz_limit_n,v1000,z50,tool0
            dikaer_crobt()
            
            di_dikaer_mode[3] == 1
            print("[INFO] : dikaer_z ; direction positive")
            MoveL dikaerz_limit_p,v1000,z50,tool0
            dikaer_crobt()
            Home
        ELSE
            print("[INFO] : dikaer_z ; direction positive")
            MoveL dikaerz_limit_p,v1000,z50,tool0
            dikaer_crobt()

            di_dikaer_mode[3] == 0
            print("[INFO] : dikaer_z ; direction negative")
            MoveL dikaerz_limit_n,v1000,z50,tool0
            dikaer_crobt()
            Home
        ENDIF
    ENDIF
ENDPROC

LOCAL PROC dikaer_motion_a()
    // function : moves to the positive or negative a limit positions
    IF(di_dikaer_mode[4] == 2)
        print("[INFO] : dikaer_a ; not response")
    ELSE
        IF(di_dikaer_mode[4] == 0)
            print("[INFO] : dikaer_a ; direction negative")
            MoveJ dikaera_limit_n,v500,z50,tool0
            dikaer_crobt()

            di_dikaer_mode[4] == 1
            print("[INFO] : dikaer_a ; direction positive")
            MoveJ dikaera_limit_p,v500,z50,tool0
            dikaer_crobt()
            Home
        ELSE
            print("[INFO] : dikaer_a ; direction positive")
            MoveJ dikaera_limit_p,v500,z50,tool0
            dikaer_crobt()

            di_dikaer_mode[4] == 0
            print("[INFO] : dikaer_a ; direction negative")
            MoveJ dikaera_limit_n,v500,z50,tool0
            dikaer_crobt()
            Home
        ENDIF
    ENDIF
ENDPROC

LOCAL PROC dikaer_motion_b()
    // function : moves to the positive or negative b limit positions
    IF(di_dikaer_mode[5] == 2)
        print("[INFO] : dikaer_b ; not response")
    ELSE
        IF(di_dikaer_mode[5] == 0)
            print("[INFO] : dikaer_b ; direction negative")
            MoveJ dikaerb_limit_n,v500,z50,tool0
            dikaer_crobt()

            di_dikaer_mode[5] == 1
            print("[INFO] : dikaer_b ; direction positive")
            MoveJ dikaerb_limit_p,v500,z50,tool0
            dikaer_crobt()
            Home
        ELSE
            print("[INFO] : dikaer_b ; direction positive")
            MoveJ dikaerb_limit_p,v500,z50,tool0
            dikaer_crobt()

            di_dikaer_mode[5] == 0
            print("[INFO] : dikaer_b ; direction negative")
            MoveJ dikaerb_limit_n,v500,z50,tool0
            dikaer_crobt()
            Home
        ENDIF
    ENDIF
ENDPROC

LOCAL PROC dikaer_motion_c()
    // function : moves to the positive or negative c limit positions
    IF(di_dikaer_mode[6] == 2)
        print("[INFO] : dikaer_c ; not response")
    ELSE
        IF(di_dikaer_mode[6] == 0)
            print("[INFO] : dikaer_c ; direction negative")
            MoveJ dikaerc_limit_n,v500,z50,tool0
            dikaer_crobt()

            di_dikaer_mode[6] == 1
            print("[INFO] : dikaer_c ; direction positive")
            MoveJ dikaerc_limit_p,v500,z50,tool0
            dikaer_crobt()
            Home
        ELSE
            print("[INFO] : dikaer_c ; direction positive")
            MoveJ dikaerc_limit_p,v500,z50,tool0
            dikaer_crobt()

            di_dikaer_mode[6] == 0
            print("[INFO] : dikaer_c ; direction negative")
            MoveJ dikaerc_limit_n,v500,z50,tool0
            dikaer_crobt()
            Home
        ENDIF
    ENDIF
ENDPROC

ENDMODULE