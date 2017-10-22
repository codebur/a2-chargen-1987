*********************************
* CHARACTER GENERATOR           *
* FOR HGR SCREEN                *
* APPLE // BASED VERSION 4.02   *
* (C) 1989 BY URS HOCHSTRASSER  *
*                               *
* PARAMETERS:                   *
* -CHAR DEF ADDR       IN $8006 *
* -TEXT WINDOW BOTTOM  IN $0023 *
* -HGR PAGE            IN $8008 *
*   $20 FOR P.1, $40 FOR P.2    *
* -PROTOCFLAG          IN $8009 *
* -BOLD FLAG           IN $800A *
* -UNDERLINE FLAG      IN $800B *
* -80 COLUMN FLAG      IN $800E *
* -RGB FLAG (0=DEFLT)  IN $8014 *
*   1= COLOR SHIFT ENABLED      *
* -HILINE MODE FLAG    IN $8015 *
* -INDEPNDNT MODE FLAG IN $8016 *
* -INVFLG              IN $8017 *
* -CV1                 IN $8018 *
* -CV2                 IN $8019 *
*                               *
* VERSION 2.2: FASTER CALCADR   *
*                               *
*********************************

* FOR RAM ONLY *

          ORG $8000

INVERSE   EQU $3F
FLASH     EQU $80
NORMAL    EQU $FF

CTRB      EQU $82
BACKSPC   EQU $88
CTRI      EQU $89
LF        EQU $8A
FF        EQU $8C
CR        EQU $8D
CTRN      EQU $8E
CTRP      EQU $90
DC1       EQU $91
DC2       EQU $92
SPC       EQU $A0
DEL       EQU $FF

WNDLFT    EQU $20
WNDWDTH   EQU $21
WNDTOP    EQU $22
WNDBTM    EQU $23
CH        EQU $24
CH80      EQU $57B       ;OURCH
CV        EQU $25
BASL      EQU $28
BASH      EQU $29
BAS2L     EQU $2A
BAS2H     EQU $2B
INVFLG    EQU $32
CSWL      EQU $36
CSWH      EQU $37
KSWL      EQU $38
KSWH      EQU $39
HCOLOR    EQU $E4

          JMP HOOK
          RTS
          NOP
          NOP

CHRDEF1   DA $8500
PAGE      HEX 40
PROTOC    DFB 0
BOLD      DFB 0
UNDERL    DFB 0
FONTTBL   DA 0
EXT80     DFB 0
INT80     DFB 0
OUT       DA $FDF0
IN        DA $FD1B
RGB       DFB 0
HILINE    DFB 0
INDEP     DFB 0
INVFL2    DFB 0
CV1       DFB 0
CV2       DFB 0
CH1       DFB 0
CHRSIZE   DFB 8
HBASL     DA 0
XTEMP     DFB 0
XT2       DFB 0
ACCU      DFB 0
ACCU2     DFB 0
X         DFB 0
Y         DFB 0
SAV28     DFB 0
SAV29     DFB 0
SAV2A     DFB 0
SAV2B     DFB 0
X3        DFB 0
Y3        DFB 0
A3        DFB 0
CH2       DFB 0

*** HOOK ***
HOOK      LDA #0         ;INIT INTERNAL 80COL FLAG
          STA INT80
          LDA EXT80      ;LOOK WHAT THE USER WANTS
          BEQ NO80       ;40 COL
EXTRAM?   LDA 0          ;IS THERE AUX RAM?
          STA A3
          LDA #$AA
          STA 0
          STA RWAUX0
          LDA 0
          CMP #$AA
          BEQ NOEXT      ;NO DHIRES POSSIBLE...
          LDA #1         ;80 COL
          STA INT80
NOEXT     STA RWMAIN0
          LDA A3
          STA 0
NO80      LDA #<START    ;INSTALL I/O VECTORS
          STA CSWL
          LDA #>START
          STA CSWH
          LDA #<RSTART
          STA KSWL
          LDA #>RSTART
          STA KSWH
          LDA PROCHK     ;FOR PRODOS...
          CMP #76        ;...AND DOS 3.3
          BEQ PRODOS
DOS33     JSR DOS
          JMP HOOK6
PRODOS    LDA BSCHK      ;BASIC.SYSTEM?
          CMP #76
          BNE HOOK6
          JSR PCONNECT   ;YEAH, SO CONNECT THAT BUGGER
HOOK6     BIT SINGLE     ;FOR IIGS WITH RGB
          LDA RGB
          BNE HOOK7
          BIT DOUBLE
HOOK7     LDA INT80
          BEQ HOOK4
          LDA #$20       ;FORCE PAGE #1 FOR DHIRES
          STA PAGE
HOOK4     LDA PAGE
          CMP #$40
          BNE HOOK1
          BIT PAGE2
          JMP HOOK2
HOOK1     BIT PAGE1
HOOK2     BIT HIRES
          BIT NOMIX
          BIT GRAPH
          STA STORE40
          STA DISP40
          LDA INT80
          BEQ HOOK5
          STA STORE80
          STA DISP80
          BIT DOUBLE
          LDA WNDWDTH
          CMP #$28
          BNE HOOK5
          LDA #$50
          STA WNDWDTH
HOOK5     LDA #0         ;RESET TEXT MODES
          STA BOLD
          STA PROTOC
          STA UNDERL
          LDA #$7F
          STA HCOLOR     ;INIT TO WHITE
          RTS

*** UNHOOK*** (REMOVED)

*** BLINK CURSOR ***
RSTART    STX X3
          STY Y3
          JSR INVERT
R1        LDA KBD
          BPL R1
          BIT KBDSTRB
          PHA
          JSR INVERT
          PLA
          LDX X3
          LDY Y3
          RTS

*** SAVE28***
SAVE28    LDA BASL
          STA SAV28
          LDA BASH
          STA SAV29
          LDA BAS2L
          STA SAV2A
          LDA BAS2H
          STA SAV2B
          RTS

*** REST28 ***
REST28    LDA SAV28
          STA BASL
          LDA SAV29
          STA BASH
          LDA SAV2A
          STA BAS2L
          LDA SAV2B
          STA BAS2H
          RTS

* BASE ADDRESS TABLE:
BASADR    HEX 0000800000018001
          HEX 0002800200038003
          HEX 2800A8002801A801
          HEX 2802A8022803A803
          HEX 5000D0005001D001
          HEX 5002D0025003D003

DOS       EQU $03EA
PCONNECT  EQU $9A8D
PROCHK    EQU $BF00
BSCHK     EQU $BE00
KBD       EQU $C000
STORE40   EQU $C000
STORE80   EQU $C001
RWMAIN0   EQU $C008
RWAUX0    EQU $C009
KBDSTRB   EQU $C010
DISP40    EQU $C00C
DISP80    EQU $C00D
GRAPH     EQU $C050
TEXT      EQU $C051
NOMIX     EQU $C052
PAGE1     EQU $C054
PAGE2     EQU $C055
HIRES     EQU $C057
DOUBLE    EQU $C05E
SINGLE    EQU $C05F
SW80      EQU $C060
INTERPR   EQU $E006
STOADV    EQU $FBF0
HOME      EQU $FC58
SCROLL    EQU $FC70
IOSAVE    EQU $FF4A
IOREST    EQU $FF3F
BASCALC   EQU $FBC1
BELL1     EQU $FBD9

*** SUBROUTINE CALCLINE ***
* IN: CURSOR LINE IN X
* OUT: HGR.Y IN CV1
* USES: A

CALCLINE  LDA HILINE     ;TEST HILINE FLAG
          BEQ CALCL3
          RTS
CALCL3    LDA #0
          STX XTEMP
          LDX CHRSIZE
CALCL2    BEQ CALCL1     ;ST FLGS
          CLC
          ADC XTEMP
          DEX
          JMP CALCL2
CALCL1    STA CV1
          RTS

*** SUBROUTINE HBASCALC ***
* IN: HGR.Y IN A
* OUT: HIRES BASADR IN HBASL,H

*---------OFF SCREEN?
HBASCALC  CMP #$C0
          BCS HBAS1      ;Y:LEAVE
          PHA
*---------CF APPLE REF.MAN. P.21
          LSR            ;Y/8:BOX
          LSR
          AND #$FE
*---------CALC TEXT BASE ADDRESS
          STX XT2
          TAX
          LDA BASADR,X
          STA HBASL
          LDA BASADR+1,X
          CLC
*---------ADD CONST FOR HGR PAGE
          ADC PAGE
          STA HBASL+1
          LDX XT2
          PLA
*---------CALC LINE ADDR IN BOX
          AND #7
          ASL
          ASL
          CLC
          ADC HBASL+1
          STA HBASL+1
*---------CARRY IS ERROR FLAG
HBAS1     RTS

*** SUBROUTINE HSCROLL ***

HSCR10    LDY WNDWDTH
          LDA INT80
          BEQ HSCR7
          TYA
          LSR
          TAY
HSCR7     DEY
          RTS

HSCR6     JSR HSCR10
SCFROM    LDA (BAS2L),Y
          STA (BASL),Y
          DEY
          BPL SCFROM
          RTS

HSCR8     JSR HSCR10
          LDA #0
HSCR2     STA (BASL),Y
          DEY
          BPL HSCR2
          RTS

HSCROLL   JSR SCROLL
          JSR SAVE28
          LDX WNDTOP
          JSR CALCLINE
          LDX CV1
HSCR1     TXA
          PHA
          JSR HBASCALC
          LDA HBASL
          STA BASL
          LDA HBASL+1
          STA BASH
          PLA
          CLC
          ADC CHRSIZE
          JSR HBASCALC
          LDA HBASL
          STA BAS2L
          LDA HBASL+1
          STA BAS2H
          JSR HSCR6
          LDA INT80
          BEQ HSCR5
          BIT PAGE2
          JSR HSCR6
          BIT PAGE1
HSCR5     INX
          CPX CV2
          BCC HSCR1
          LDX CV
          JSR CALCLINE
          LDX CV1
*---------VOR AUFRUF:JSR SAVE28
HSCR3     TXA
          JSR HBASCALC
          LDA HBASL
          STA BASL
          LDA HBASL+1
          STA BASH
          JSR HSCR8
          LDA INT80
          BEQ HSCR4
          BIT PAGE2
          JSR HSCR8
          BIT PAGE1
HSCR4     INX
          CPX CV2
          BCC HSCR3
          JSR REST28
          RTS

*** SUBROUTINE HHOME ***

HHOME     LDX WNDTOP
          JSR CALCLINE
          LDX CV1
          JSR SAVE28
          JSR HSCR3
          JSR HOME
          JMP END1

*** SUBROUTINE INVERT ***

INVERT    JSR SAVE28
          LDX CV
          LDY CH
          LDA INT80
          BEQ INV4
          TYA
          LSR
          BCS INV5
          BIT PAGE2
INV5      TAY
INV4      JSR CALCLINE
          LDX #0
INV3      CLC
          TXA
          ADC CV1
          JSR HBASCALC
          LDA HBASL
          STA BASL
          LDA HBASL+1
          STA BASH
INV1      LDA (BASL),Y
          EOR #$7F
INV2      STA (BASL),Y
          INX
          CPX CHRSIZE
          BCC INV3
          JSR REST28
          LDA INT80
          BEQ INV6
          BIT PAGE1
INV6      RTS

*** SUBROUTINE TOGGLE ***

TOGGLE    CMP #CTRB
          BNE NOBO
          LDA #1
          STA BOLD
          LDA ACCU
NOBO      CMP #CTRI
          BNE NOUN
          LDA #1
          STA UNDERL
          LDA ACCU
NOUN      CMP #CTRP
          BNE NOPR
          LDA #1
          STA PROTOC
          LDA ACCU
NOPR      CMP #CTRN
          BNE NONO
          LDA #0
          STA BOLD
          STA UNDERL
          LDA ACCU
NONO      RTS

HHOM2     JMP HHOME
BELL1A    JSR BELL1
          JMP END1
HCR1      JMP HCR
HLF1      JMP HLF
SCROLL1   JSR HSCROLL
          JMP NOSCROLL

BS        DEC CH
          BPL UP1
          LDA WNDWDTH
          STA CH
          DEC CH
UP        LDA WNDTOP
          CMP CV
          BCS UP1
          DEC CV
UP1       JMP END1

**** MAIN PROGRAM ****

START     STA ACCU
          STX X
          STY Y
*NEW CODE START
          CMP #DEL
          BNE NODEL
          LDA PROTOC
          BEQ NODEL
          LDA #0
          STA PROTOC
          JMP END1
*END NEW CODE
NODEL     LDA INVFLG
          CMP #FLASH
          BCS NORM?
          LDX #$FF
          STX INVFL2
NORM?     CMP #NORMAL
          BNE STRT1
          LDX #0
          STX INVFL2
STRT1     LDX WNDBTM
          JSR CALCLINE
          STA CV2
          LDA PROTOC
          BNE STORADV
          LDA ACCU
          JSR TOGGLE
          CMP #SPC
          BCS STORADV
          TAY
          BPL STORADV
          CMP #CR
          BEQ HCR1
          CMP #LF
          BEQ HLF1
          CMP #FF
          BEQ HHOM2
          CMP #BACKSPC
          BNE BELL1A
          JSR BS
          JMP END1
NOSCROLL  LDA ACCU
STORADV   JSR SAVE28
          LDA CHRDEF1
          STA BASL
          LDA CHRDEF1+1
          STA BASH
          LDY #0
          LDA (BASL),Y
          STA CHRSIZE
          INC BASL
          BNE CHRDEF
          INC BASH
CHRDEF    LDA ACCU
CHRD1     STA ACCU2
          LDX CHRSIZE
*---------CALC ADDR OF CHRDEF TBL
CALCADR   LDA #0
          LDX #8
CALCAD1   ASL
          ROL ACCU2
          BCC CALCAD2
          CLC
          ADC CHRSIZE
          BCC CALCAD2
          INC ACCU2
CALCAD2   DEX
          BNE CALCAD1
          CLC
          ADC BASL
          STA BASL
          LDA ACCU2
          ADC BASH
          STA BASH
          LDX CV
          JSR CALCLINE
DRAW      LDY #0
DRAW1     CLC
          TYA
          ADC CV1
          JSR HBASCALC
          LDA CH
          LDX INT80
          BEQ DRAW8
          LSR
          BCS DRAW8
          BIT PAGE2
DRAW8     STA CH2
          CLC
          ADC WNDLFT
          ADC HBASL
          STA BAS2L
          LDA HBASL+1
          STA BAS2H
DRAW2     LDA (BASL),Y
          STY XTEMP
          LDX BOLD
          BEQ DRAW6
          STA A3
          ASL
          AND #$7F
          ORA A3
DRAW6     LDX INVFL2
*---------IF ZERO NOT INVERSE
          BEQ DRAW5
          EOR #$7F
DRAW5     LDY #0
          AND HCOLOR     ;NEW...
DRAW3     STA (BAS2L),Y
          LDY XTEMP
          INY
          CPY CHRSIZE
          BCC DRAW1
          LDA UNDERL
          BEQ DRAW7
          LDA #$7F
          LDY #0
          EOR (BAS2L),Y
          STA (BAS2L),Y
DRAW7     JSR REST28
          LDA CV
          JSR BASCALC
          ADC WNDLFT
          STA BASL
          LDA ACCU
          LDY CH2
          STA (BASL),Y
          LDA INT80
          BEQ ADVANCE
          BIT PAGE1
ADVANCE   INC CH
          LDA CH
          CMP WNDWDTH
          BCS HCR
          JMP END1
HCR       LDA #0
          STA CH
HLF       INC CV
          LDA CV
          CMP WNDBTM
          BCS LF1
          JMP END1
LF1       DEC CV
          JSR HSCROLL
END1      LDA ACCU
          LDY Y
          LDX X
          RTS
          END