@digitos_display

@ 1 : 0001 0011
@ 2 : 0010 0011
@ 3 : 0011 0011
@ 4 : 0100 0011
@ 5 : 0101 0011
@ 6 : 0110 0011
@ 7 : 0111 0011
@ 8 : 1000 0011
@ 9 : 1001 0011




@
@ ===================================================== Setar Dig 01 =====================================================
@

.macro set_1
    @set_display 1, 0, 0, 1, 1
    rs_on
    db7_off
    db6_off
    db5_on
    db4_on
    enable

    @rs, d7, d6, d5, d4
    @set_display 1, 0, 0, 0, 1
    rs_on
    db7_off
    db6_off
    db5_off
    db4_on
    enable
    
.endm




@
@ ===================================================== Setar Dig 02 =====================================================
@

.macro set_2
	
	@set_display 1, 0, 0, 1, 1
    rs_on
    db7_off
    db6_off
    db5_on
    db4_on
    enable

    @rs, d7, d6, d5, d4
    @set_display 1, 0, 0, 1, 0
    rs_on
    db7_off
    db6_off
    db5_on
    db4_off
    enable
.endm




@
@ ===================================================== Setar Dig 03 =====================================================
@

.macro set_3
	
	@set_display 1, 0, 0, 1, 1
    rs_on
    db7_off
    db6_off
    db5_on
    db4_on
    enable

    @rs, d7, d6, d5, d4
    @set_display 1, 0, 0, 1, 1
    rs_on
    db7_off
    db6_off
    db5_on
    db4_on
    enable


.endm




@
@ ===================================================== Setar Dig 04 =====================================================
@

.macro set_4
	
	@set_display 1, 0, 0, 1, 1
    rs_on
    db7_off
    db6_off
    db5_on
    db4_on
    enable

    @rs, d7, d6, d5, d4
    @set_display 1, 0, 1, 0, 0
    rs_on
    db7_off
    db6_on
    db5_off
    db4_off
    enable
.endm




@
@ ===================================================== Setar Dig 05 =====================================================
@

.macro set_5
	
	@set_display 1, 0, 0, 1, 1
    rs_on
    db7_off
    db6_off
    db5_on
    db4_on
    enable

    @rs, d7, d6, d5, d4
    @set_display 1, 0, 1, 0, 1
    rs_on
    db7_off
    db6_on
    db5_on
    db4_off
    enable
.endm




@
@ ===================================================== Setar Dig 06 =====================================================
@

.macro set_6
	
	@set_display 1, 0, 0, 1, 1
    rs_on
    db7_off
    db6_off
    db5_on
    db4_on
    enable

    @rs, d7, d6, d5, d4
    @set_display 1, 0, 1, 1, 0
    rs_on
    db7_off
    db6_on
    db5_on
    db4_off
    enable
.endm




@
@ ===================================================== Setar Dig 07 =====================================================
@

.macro set_7
	
	@set_display 1, 0, 0, 1, 1
    rs_on
    db7_off
    db6_off
    db5_on
    db4_on
    enable

    @rs, d7, d6, d5, d4
    @set_display 1, 0, 1, 1, 1
    rs_on
    db7_off
    db6_on
    db5_on
    db4_on
    enable
.endm




@
@ ===================================================== Setar Dig 08 =====================================================
@

.macro set_8
	
	@set_display 1, 0, 0, 1, 1
    rs_on
    db7_off
    db6_off
    db5_on
    db4_on
    enable

    @rs, d7, d6, d5, d4
    @set_display 1, 1, 0, 0, 0
    rs_on
    db7_on
    db6_off
    db5_off
    db4_off
    enable
.endm




@
@ ===================================================== Setar Dig 09 =====================================================
@

.macro set_9
	
	@set_display 1, 0, 0, 1, 1
    rs_on
    db7_off
    db6_off
    db5_on
    db4_on
    enable

    @rs, d7, d6, d5, d4
    @set_display 1, 1, 0, 0, 1
    rs_on
    db7_on
    db6_off
    db5_off
    db4_on
    enable
.endm