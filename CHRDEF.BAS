 ### JOYSTICK VERSION ###
 4  HIMEM: 16384::D$ =  CHR$ (13) +  CHR$ (4): PRINT D$"BLOAD CHRDEF.SHP" : CALL 759: PRINT D$"BLOAD I"                                                   
 5 DF = 24576:MAUS = 4:CH = 36:CV = 37:PB =  - 16287:PR0 = 640                  
 6  HGR2 : HOME : HCOLOR= 3: HPLOT 0,0 TO 279,0 TO 279,191 TO 0,191 TO 0,0: HTAB 16: VTAB 2: INVERSE : PRINT  SPC( 24): PRINT : HTAB 16: PRINT "  F O N T  E D I T O R  ": HTAB 16: PRINT  SPC( 24): PRINT : NORMAL               
 7  HPLOT 105,8 TO 105,69 TO 272,69 TO 272,8: HPLOT 105,75 TO 272,75 TO 272,105 TO 105,105 TO 105,75: HPLOT 260,75 TO 260,105                            
 8  SCALE= 1: ROT= 32: DRAW 4 AT 269,98: ROT= 0: DRAW 4 AT 263,82               
 9  VTAB 22: HTAB 6: PRINT "New  Load  Save  Zoom  Store  Quit";: HPLOT 69,167 TO 98,167 TO 98,176 TO 69,176 TO 69,167: HPLOT 34,167 TO 56,167 TO 56,176 TO 34,176 TO 34,167                                                      
 10  GOSUB 300                                                                  
 11  HPLOT 244,167 TO 273,167 TO 273,176 TO 244,176 TO 244,167                  
 20  VTAB 16: HTAB 16: PRINT "Clear": HPLOT 104,119 TO 140,119 TO 140,128       
 TO 104,128 TO 104,119                                                          
 30  HTAB 17: VTAB 8: PRINT "Zeichenh|he:"                                      
 40  HPLOT 147,118 TO 272,118 TO 272,147 TO 147,147 TO 147,118                  
 50  HTAB 25: VTAB 17: PRINT "Cancel   OK"                                      
 60  HCOLOR= 2: GOSUB 380: HCOLOR= 3                                            
 70  DIM MX%(6,25),MSB%(25)                                                     
 80  VTAB 1: HTAB 27: PRINT "Version 2.00j";                                    
 100  REM ****HAUPTROUTINE****                                                  
 101  REM * Joystick-Abfrage *                                                  
 102  REM                                                                       
 107  XDRAW 2 AT XOLD + 1,YOLD + 1                                              
 110 X =  PDL (0):Y =  PDL (1):S = ( PEEK (PB) > 127)                           
 120 X =  INT (X * 1.2): IF X > 275 THEN X = 275                                
 130 Y =  INT (Y * .8): IF Y > 183 THEN Y = 183                                 
 135  IF S THEN 200                                                             
 140  IF (XOLD <  > X) OR (YOLD <  > Y) THEN  XDRAW 2 AT XOLD + 1,YOLD + 1: XDRAW 2 AT X + 1,Y + 1:SP =  INT ((X - 18) / 6):ZL =  INT ((Y - 12) / 6)                                                                              
 190  IF (XOLD <  > X) OR (YOLD <  > Y) THEN XOLD = X:YOLD = Y                  
 195  GOTO 110                                                                  
 200  REM ****Verzweigungs-****                                                 
 201  REM *      Routine      *                                                 
 202  REM                                                                       
 210  RESTORE : FOR I = 1 TO 15                                                 
 220  READ X1,Y1,X2,Y2                                                          
 230  IF X > X1 AND Y > Y1 AND X < X2 AND Y < Y2 THEN  GOTO 290                 
 240  NEXT                                                                      
 249  REM ###Error!###                                                          
 250  PRINT  CHR$ (7);: GOTO 110                                                
 290  ON I GOTO 6000,4000,4100,4300,4360,4400,4450,4500,4600,4700,4800,4900,4920,410,4250                                                                
 299  REM ***Draw Mdl 3 Boxes***                                                
 300  HCOLOR= 3: IF  NOT F% THEN  HCOLOR= 2                                     
 305  HPLOT 111,167 TO 140,167 TO 140,176 TO 111,176 TO 111,167: HPLOT 153,167 TO 182,167 TO 182,176 TO 153,176 TO 153,167: HPLOT 195,167 TO 231,167 TO 231,176 TO 195,176 TO 195,167: HCOLOR= 3: RETURN                          
 309  REM ***Draw Drawing Box***                                                
 310 CRN = CSIZE * 6 + 12                                                       
 320  HPLOT 16,8 TO 65,8 TO 65,CRN + 4 TO 16,CRN + 4 TO 16,8                    
 330  HPLOT 82,30 TO 92,30 TO 92,30 + CSIZE + 3 TO 82,30 + CSIZE + 3 TO 82,30                                                                            
 340  VTAB 12: HTAB 17: IF F% THEN  PRINT "Zeichencode: ";ZC                    
 350  RETURN                                                                    
 360  REM ***Invert***                                                          
 365 HC = 7 *  PEEK (CH):HL = 8 *  PEEK (CV)                                    
 370  FOR J = HC TO HC + N * 7 STEP 7: XDRAW 3 AT J,HL: NEXT J: RETURN          
 380  REM ***Cancel-Rand***                                                     
 390  HPLOT 167,127 TO 210,127 TO 210,136 TO 167,136 TO 167,127: HPLOT 223,127 TO 252,127 TO 252,136 TO 223,136 TO 223,127                               
 400  RETURN                                                                    
 410  REM ***Cancel/OK***                                                       
 420  IF  NOT F2% THEN  PRINT  CHR$ (7): GOTO 4999                              
 422  CALL PR0                                                                  
 425 OK = 0                                                                     
 430  IF X < 210 THEN  HTAB 26: VTAB 17:N = 4:OK = 0                            
 440  IF X > 223 THEN  HTAB 33: VTAB 17:N = 3:OK = 1                            
 445  HCOLOR= 2: GOSUB 380: HCOLOR= 3                                           
 450  GOSUB 360: GOSUB 360: ON F2% GOTO 4547,4647                               
 2000  REM **Clear Subroutine**                                                 
 2010  FOR ZL = 0 TO CSIZE - 1                                                  
 2020  GOSUB 4200: ROT= 16: HCOLOR= 0: DRAW 5 AT 71,6 * ZL + 12:MSB%(ZL) = 0: ROT= 0                                                                     
 2027  FOR J = 0 TO 6                                                           
 2030 MX%(J,ZL) = 0                                                             
 2040  NEXT J,ZL                                                                
 2045  VTAB 5: HTAB 13: PRINT " ";                                              
 2050  HCOLOR= 3: RETURN                                                        
 4000  REM ***Wasserlinie***                                                    
 4010  IF  NOT F% OR Y > CRN - 2 THEN  PRINT  CHR$ (7): GOTO 4999               
 4020  ROT= 16: XDRAW 5 AT 15,6 *  INT (Y / 6) + 3                              
 4099  ROT= 0: GOTO 4999                                                        
 4100  REM ***Schiebungspfeile***                                               
 4110  IF  NOT F% OR Y > CRN THEN  PRINT  CHR$ (7): GOTO 4999                   
 4120  ROT= 16: XDRAW 5 AT 71,6 *  INT (Y / 6): ROT= 0                          
 4125  GOSUB 4200                                                               
 4130 MSB%(ZL) = ( NOT MSB%(ZL))                                                
 4140  FOR I = 0 TO 6: HCOLOR= 3 * MX%(I,ZL) + 4 * MSB%(ZL): DRAW 1 AT 6 * I + 18 + 3 * MSB%(ZL),6 * ZL + 12: NEXT I                                     
 4150  HPLOT 90,32 + ZL: HCOLOR= 3                                              
 4199  GOTO 4999                                                                
 4200  REM ***Clear Dot Line***                                                 
 4210  HCOLOR= 0                                                                
 4220  FOR I = 0 TO 6: DRAW 1 AT 6 * I + 18 + 3 * MSB%(ZL),6 * ZL + 12: NEXT I                                                                           
 4230  HCOLOR= 3: RETURN                                                        
 4250  REM ***Clear Dot Array***                                                
 4255  CALL PR0: VTAB 16: HTAB 16:N = 4: GOSUB 360                              
 4260  GOSUB 2000                                                               
 4270  VTAB 16: HTAB 16:N = 4: GOSUB 360: GOTO 4999                             
 4300  REM ***ZCode Numerisch***                                                
 4305  IF  NOT F% THEN  PRINT  CHR$ (7);: GOTO 4999                             
 4310  CALL PR0: XDRAW 2 AT XOLD + 1,YOLD + 1                                   
 4320  VTAB 12: HTAB 30: INPUT "";G$: IF G$ = "" THEN 4340                      
 4325 ZC =  VAL (G$): IF ZC = 0 AND  ASC (G$) <  > 48 THEN ZC =  ASC (G$) + 128                                                                          
 4330  IF ZC < 0 OR ZC > 255 THEN 4320                                          
 4340  VTAB 12: HTAB 30: PRINT  SPC( 8): HTAB 30: PRINT ZC                      
 4347  XDRAW 2 AT XOLD + 1,YOLD + 1                                             
 4350  GOTO 4999                                                                
 4360  REM ***Zeichenh|he eingeben***                                           
 4361  IF F% OR F2% THEN  PRINT  CHR$ (7): GOTO 4999                            
 4362  CALL PR0                                                                 
 4365  XDRAW 2 AT XOLD + 1,YOLD + 1                                             
 4370  HTAB 30: VTAB 8: PRINT  SPC( 9)                                          
 4375  HTAB 30: INPUT "";G$: IF G$ = "" THEN 4370                               
 4380 CSIZE =  VAL (G$): IF CSIZE <  = 0 OR CSIZE > 25 THEN 4370                
 4385 F% = 1: GOSUB 300: GOSUB 310                                              
 4387  XDRAW 2 AT XOLD + 1,YOLD + 1                                             
 4390  GOTO 4999                                                                
 4400  REM ***Click Up***                                                       
 4405  IF  NOT F% THEN  PRINT  CHR$ (7);: GOTO 4999                             
 4410  XDRAW 5 AT 263,82:ZC = ZC + 1: IF ZC > 255 THEN ZC = 0                   
 4420  CALL PR0: VTAB 12: HTAB 30: PRINT ZC"  ": XDRAW 5 AT 263,82: GOTO 4999                                                                            
 4450  REM ***Click Down***                                                     
 4455  IF  NOT F% THEN  PRINT  CHR$ (7);: GOTO 4999                             
 4460  ROT= 32: XDRAW 5 AT 269,98:ZC = ZC - 1: IF ZC < 0 THEN ZC = 255          
 4470  CALL PR0: VTAB 12: HTAB 30: PRINT ZC"  ": XDRAW 5 AT 269,98: ROT=0: GOTO 4999                                                                    
 4500  REM ***Load***                                                           
 4505  CALL PR0: VTAB 22: HTAB 11:N = 3: GOSUB 360                              
 4519  XDRAW 2 AT XOLD + 1,YOLD + 1                                             
 4520  VTAB 6: HTAB 17: INPUT "File: ";G$: IF G$ = "" AND F$ = "" THEN 4520                                                                              
 4530  IF G$ <  > "" THEN F$ = G$                                               
 4535  IF  RIGHT$ (F$,4) <  > ".CHR" THEN F$ = F$ + ".CHR"                      
 4540  VTAB 6: HTAB 23: PRINT  SPC( 15): HTAB 24: PRINT F$                      
 4544  XDRAW 2 AT XOLD + 1,YOLD + 1                                             
 4545 F2% = 1:F% = 0: GOSUB 380: GOTO 4999                                      
 4547 F2% = 0: IF  NOT OK THEN 4590                                             
 4549  GOSUB 2000: HCOLOR= 0: GOSUB 310: HCOLOR= 3                              
 4550  PRINT D$"BLOAD"F$",A"DF                                                  
 4560 CSIZE =  PEEK (DF)                                                        
 4570  VTAB 8: HTAB 30: PRINT  SPC( 8): HTAB 30: PRINT CSIZE                    
 4580 F% = 1: GOSUB 300: GOSUB 310                                              
 4590  VTAB 22: HTAB 11:N = 3: GOSUB 360: GOTO 4999                             
 4600  REM ***Save***                                                           
 4605  IF  NOT F% THEN  PRINT  CHR$ (7);: GOTO 4999                             
 4610  CALL PR0: VTAB 22: HTAB 17:N = 3: GOSUB 360                              
 4619  XDRAW 2 AT XOLD + 1,YOLD + 1                                             
 4620  VTAB 6: HTAB 17: INPUT "File: ";G$: IF G$ = "" AND F$ = "" THEN 4520                                                                              
 4630  IF G$ <  > "" THEN F$ = G$                                               
 4635  IF  RIGHT$ (F$,4) <  > ".CHR" THEN F$ = F$ + ".CHR"                      
 4640  VTAB 6: HTAB 23: PRINT  SPC( 15): HTAB 24: PRINT F$                      
 4644  XDRAW 2 AT XOLD + 1,YOLD + 1                                             
 4645 F2% = 2:F% = 0: GOSUB 380: GOTO 4999                                      
 4647 F2% = 0:F% = 1: GOSUB 300: IF  NOT OK THEN 4690                           
 4650  PRINT D$"BSAVE"F$",A"DF",L"256 * CSIZE + 1                               
 4690  VTAB 22: HTAB 17:N = 3: GOSUB 360: GOTO 4999                             
 4700  REM ***Zoom***                                                           
 4705  IF  NOT F% THEN  PRINT  CHR$ (7);: GOTO 4999                             
 4710  CALL PR0: VTAB 22: HTAB 23:N = 3: GOSUB 360                              
 4715  GOSUB 2000                                                               
 4720  FOR ZL = 0 TO CSIZE - 1                                                  
 4730 BY =  PEEK (DF + ZL + 1 + CSIZE * ZC)                                     
 4735 MSB%(ZL) = (BY > 127):BY = BY - 128 * MSB%(ZL): HCOLOR= 3 * MSB%(ZL): ROT= 16: DRAW 5 AT 71,6 * ZL + 12: ROT= 0                                    
 4740  FOR SP = 6 TO 0 STEP  - 1                                                
 4750 MX%(SP,ZL) = (BY > (2 ^ SP - 1)):BY = BY - 2 ^ SP * MX%(SP,ZL)            
 4755  HCOLOR= 3 * MX%(SP,ZL) + 4 * MSB%(ZL): DRAW 1 AT 6 * SP + 18 + 3 * MSB%(ZL),6 * ZL + 12: HPLOT 84 + SP,32 + ZL                                    
 4760  NEXT SP,ZL                                                               
 4790  VTAB 22: HTAB 23:N = 3: GOSUB 360: GOTO 4999                             
 4800  REM ***Store***                                                          
 4805  IF  NOT F% THEN  PRINT  CHR$ (7);: GOTO 4999                             
 4810  CALL PR0: VTAB 22: HTAB 29:N = 4: GOSUB 360                              
 4820  FOR ZL = 0 TO CSIZE - 1                                                  
 4822 BY = 0                                                                    
 4825  FOR SP = 0 TO 6                                                          
 4830 BY = BY + 2 ^ SP * MX%(SP,ZL)                                             
 4835  NEXT SP                                                                  
 4840 BY = BY + 128 * MSB%(ZL)                                                  
 4845  POKE DF + ZL + 1 + CSIZE * ZC,BY                                         
 4850  NEXT ZL                                                                  
 4890  VTAB 22: HTAB 29:N = 4: GOSUB 360: GOTO 4999                             
 4900  REM ***Quit***                                                           
 4905  IF F2% THEN  PRINT  CHR$ (7): GOTO 4999                                  
 4910  CALL PR0: VTAB 22: HTAB 36: INVERSE : PRINT "Quit": NORMAL : PRINT CHR$ (12): PRINT "Auf Wiedersehen bis zum n{chsten Mal!": END                 
 4920  REM ***New***                                                            
 4925  IF F2% THEN  PRINT  CHR$ (7): GOTO 4999                                  
 4927  CALL PR0                                                                 
 4930  VTAB 22: HTAB 6:N = 2: GOSUB 360                                         
 4935  GOSUB 2000                                                               
 4940 F% = 0: HCOLOR= 0: GOSUB 310: HCOLOR= 3: GOSUB 300                        
 4950  VTAB 12: HTAB 17: PRINT  SPC( 16)                                        
 4990  VTAB 22: HTAB 6: GOSUB 360: GOTO 4999                                    
 4999 D$ =  CHR$ (13) +  CHR$ (4): PRINT D$"PR#0": GOTO 110                     
 5100  REM "Zeichen-Feld"                                                       
 5110  DATA  18,12,60,162                                                       
 5200  REM "Wasserlinie"                                                        
 5210  DATA    8,12,18,162                                                      
 5250  REM "Schiebungspfeile"                                                   
 5260  DATA   60,12,80,162                                                      
 5300  REM "Zeichencode Numerisch"                                              
 5310  DATA 105,75,260,105                                                      
 5350  REM "Zeichenh|he"                                                        
 5360  DATA 105,32,272,69                                                       
 5400  REM "Code Click Up"                                                      
 5410  DATA 260,75,272,90                                                       
 5500  REM "Click Down"                                                         
 5510  DATA 260,90,272,105                                                      
 5600  REM  "Load,Save,Zoom,Store,Quit,New"                                     
 5610  DATA 69,167,98,176                                                       
 5620  DATA 111,167,140,176                                                     
 5630  DATA 153,167,182,176                                                     
 5640  DATA 195,167,231,176                                                     
 5650  DATA 244,167,273,176                                                     
 5660  DATA 34,167,56,176                                                       
 5700  REM "Cancel/OK"                                                          
 5710  DATA 167,127,252,136                                                     
 5900  REM "Clear Dot Array"                                                    
 5910  DATA 104,119,140,128                                                     
 6000  REM *****Punkt-Setz/R}cksetz-Rout*****                                   
 6010  IF  NOT F% OR Y > CRN - 2 THEN  PRINT  CHR$ (7): GOTO 4999               
 6020  XDRAW 1 AT 6 *  INT (X / 6) + 3 * MSB%(ZL),6 *  INT (Y / 6)              
 6030 MX%(SP,ZL) = ( NOT MX%(SP,ZL))                                            
 6040  HCOLOR= 3 * MX%(SP,ZL) + 4 * MSB%(ZL)                                    
 6050  HPLOT 84 + SP,32 + ZL: HCOLOR= 3                                         
 6999  GOTO 4999


### MAUS VERSION ###
 4  HIMEM: 16384::D$ =  CHR$ (13) +  CHR$ (4): PRINT D$"BLOAD CHRDEF.SHP" : CALL 759: PRINT D$"BLOAD I" : GOSUB 8000 : REM SeekMouse

 100  REM ****HAUPTROUTINE****                                                  
 101  REM *   Maus-Abfrage   *
 105  GOSUB 1000 : REM (Maus einschalten)
 102  REM                                                                       
 107  XDRAW 2 AT XOLD + 1,YOLD + 1                                              
 110 INPUT "";X,Y,S                        
 120 X =  INT (X / 2): IF X > 275 THEN X = 275                                
 130 Y =  INT (Y / 3): IF Y > 183 THEN Y = 183                                 
 135  IF ABS(S) < 3 THEN 200                                                             
 140  IF (XOLD <  > X) OR (YOLD <  > Y) THEN  XDRAW 2 AT XOLD + 1,YOLD + 1: XDRAW 2 AT X + 1,Y + 1:SP =  INT ((X - 18) / 6):ZL =  INT ((Y - 12) / 6)                                                                              
 190  IF (XOLD <  > X) OR (YOLD <  > Y) THEN XOLD = X:YOLD = Y                  
 195  GOTO 110
 
 1000  REM *** Init Mouse ***
 1010  PRINT D$"PR#"MAUS: PRINT CHR$(1):PRINT D$"PR$0"
 1020  PRINT D$"IN$"MAUS
 1030  RETURN
 
 8000 M1 = 49164:M2 = 49403
 8010  FOR I = 1 TO 7                                                           
 8020  IF  PEEK (M1 + 256 * I) = 32 AND  PEEK (M2 + 256 * I) = 214 THEN 8040                                                                             
 8030  NEXT I: HOME : VTAB 10: HTAB 7: PRINT "Oh graus, wo ist die Maus?!": VTAB 22: END                                                                 
 8040  RETURN                                                                   

