@digitos_display

@ 0 : 0011 0000
@ 1 : 0011 0001
@ 2 : 0011 0010
@ 3 : 0011 0011
@ 4 : 0011 0100
@ 5 : 0011 0101
@ 6 : 0011 0110
@ 7 : 0011 0111
@ 8 : 0011 1000
@ 9 : 0011 1001


@
@ ===================================================== Padrão =====================================================
@

.macro padrao_setar_numero
    @set_display 1, 0, 0, 1, 1
    rs_on
    db7_off
    db6_off
    db5_on
    db4_on
    enable
.endm


.macro set_nums
    .ltorg
    set_0
    set_1
    set_2
    set_3
    set_4
    set_5
    set_6
    set_7
    set_8
    set_9
    .ltorg
.endm


@
@ ===================================================== Setar Dig 0 =====================================================
@

.macro set_0
    padrao_setar_numero

    @rs, d7, d6, d5, d4
    @set_display 1, 0, 0, 0, 0
    rs_on
    db7_off
    db6_off
    db5_off
    db4_off
    enable    
.endm




@
@ ===================================================== Setar Dig 01 =====================================================
@

.macro set_1
    padrao_setar_numero

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
	padrao_setar_numero

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
	padrao_setar_numero

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
	padrao_setar_numero

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
	padrao_setar_numero

    @rs, d7, d6, d5, d4
    @set_display 1, 0, 1, 0, 1
    rs_on
    db7_off
    db6_on
    db5_off
    db4_on
    enable
.endm




@
@ ===================================================== Setar Dig 06 =====================================================
@

.macro set_6
	padrao_setar_numero

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
	padrao_setar_numero

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
	.ltorg
	padrao_setar_numero

    @rs, d7, d6, d5, d4
    @set_display 1, 1, 0, 0, 0
    rs_on
    db7_on
    db6_off
    db5_off
    db4_off
    enable
    .ltorg
.endm




@
@ ===================================================== Setar Dig 09 =====================================================
@

.macro set_9
	padrao_setar_numero

    @rs, d7, d6, d5, d4
    @set_display 1, 1, 0, 0, 1
    rs_on
    db7_on
    db6_off
    db5_off
    db4_on
    enable
.endm

