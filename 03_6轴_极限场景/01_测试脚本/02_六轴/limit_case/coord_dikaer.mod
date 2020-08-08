MODULE  coordinate_dikaer

LOCAL VAR robtarget dikaerx_limit_p = p:{{581.657185240,-0.000344233,863.736977845},{0.708695062,0.000003654,0.705514924,0.000003251}}{cfg -1,0,0,0}{EJ 0.000000000,0.000000000,0.000000000,0.000000000,0.000000000,0.000000000}
LOCAL VAR robtarget dikaerx_limit_n = p:{{87.317128997,0.000035644,863.736742993},{0.708694733,0.000004173,0.705515255,0.000004496}}{cfg 0,0,0,0}{EJ 0.000000000,0.000000000,0.000000000,0.000000000,0.000000000,0.000000000}

LOCAL VAR robtarget dikaery_limit_p = p:{{258.262224172,456.966101935,863.525893507},{0.708487505,0.000093329,0.705723341,0.000116155}}{cfg 0,-1,0,0}{EJ 0.000000000,0.000000000,0.000000000,0.000000000,0.000000000,0.000000000}
LOCAL VAR robtarget dikaery_limit_n = p:{{258.231929192,-449.675180406,863.587693730},{0.708557953,0.000091039,0.705652615,0.000072651}}{cfg -1,0,-1,0}{EJ 0.000000000,0.000000000,0.000000000,0.000000000,0.000000000,0.000000000}

LOCAL VAR robtarget dikaerz_limit_p = p:{{258.262333096,0.000415137,1031.724032346},{0.708614906,-0.000001221,0.705595432,0.000005860}}{cfg -1,0,-1,0}{EJ 0.000000000,0.000000000,0.000000000,0.000000000,0.000000000,0.000000000}
LOCAL VAR robtarget dikaerz_limit_n = p:{{258.217377496,-0.000228629,750.528233930},{0.708650242,0.000001890,0.705559943,0.000003488}}{cfg -1,0,-1,0}{EJ 0.000000000,0.000000000,0.000000000,0.000000000,0.000000000,0.000000000}

LOCAL VAR robtarget dikaera_limit_p = p:{{258.215371664,-0.007064939,863.701500202},{0.708453602,-0.015952693,0.705397526,-0.015916542}}{cfg -1,0,3,0}{EJ 0.000000000,0.000000000,0.000000000,0.000000000,0.000000000,0.000000000}
LOCAL VAR robtarget dikaera_limit_n = p:{{258.217536486,-0.008130492,863.701646013},{0.708536961,0.011932033,0.705472992,0.011868384}}{cfg 0,-1,-4,0}{EJ 0.000000000,0.000000000,0.000000000,0.000000000,0.000000000,0.000000000}

LOCAL VAR robtarget dikaerb_limit_p = p:{{258.203172516,0.000023506,863.672622912},{0.077490416,-0.000007927,0.996993097,-0.000002229}}{cfg 0,-1,-1,0}{EJ 0.000000000,0.000000000,0.000000000,0.000000000,0.000000000,0.000000000}
LOCAL VAR robtarget dikaerb_limit_n = p:{{258.214885345,0.000239876,863.716519194},{0.788691086,-0.000000964,0.614789696,-0.000000948}}{cfg 0,-1,0,0}{EJ 0.000000000,0.000000000,0.000000000,0.000000000,0.000000000,0.000000000}

LOCAL VAR robtarget dikaerc_limit_p = p:{{258.263967207,0.025889139,863.561884948},{0.487611441,-0.511883762,0.486289043,0.513549476}}{cfg -1,1,-1,0}{EJ 0.000000000,0.000000000,0.000000000,0.000000000,0.000000000,0.000000000}
LOCAL VAR robtarget dikaerc_limit_n = p:{{258.263372995,0.017699583,863.586130868},{-0.446435989,-0.548176424,-0.444830795,0.549839141}}{cfg 0,-2,0,0}{EJ 0.000000000,0.000000000,0.000000000,0.000000000,0.000000000,0.000000000}

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