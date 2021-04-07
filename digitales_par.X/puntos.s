

    
;DARWIN HERRAN      2420191021
;JEISSON BETANCOURT 2420191017
    
    
PROCESSOR 16F877A

#include <xc.inc>

; CONFIGURATION WORD PG 144 datasheet
CONFIG CP=OFF ; PFM and Data EEPROM code protection disabled
CONFIG DEBUG=OFF ; Background debugger disabled
CONFIG WRT=OFF
CONFIG CPD=OFF
CONFIG WDTE=OFF ; WDT Disabled; SWDTEN is ignored
CONFIG LVP=ON ; Low voltage programming enabled, MCLR pin, MCLRE ignored
CONFIG FOSC=XT
CONFIG PWRTE=ON
CONFIG BOREN=OFF
PSECT udata_bank0   
    
PSECT udata_bank0
max:
 DS 1 ;reserve 1 byte for max
tmp:
 DS 1 ;reserve 1 byte for tmp
PSECT resetVec,class=CODE,delta=2
INISYS:
    
    ;CAMBIO A BANCO 1
    BCF STATUS, 6
    BSF STATUS, 5 ; Bank1
   ;Declarando ENTRADAS 
   BSF TRISB, 3 ; IN de BOMBA AGUA 
   BSF TRISC, 0 ; IN S1
   BSF TRISC, 1 ; IN S2
   BSF TRISB, 4 ; IN SENSOR TEMPERATURA 
    
    ;Declarando SALIDAS
    BCF TRISD,2 ; out  LED YELLOW  
    BCF TRISD,0 ; OUT  LED GREEN  
    BCF TRISD,4 ; OUT  LED RED 
    
    BCF STATUS, 5 ;BNK 0
 
    MAIN:
    ;PUNTO1
    BTFSS PORTB,3 
    GOTO ON 
    goto OFF
     
    ON:
    BSF PORTD,2
    GOTO P2
    
    OFF: 
    BCF PORTD,2
    GOTO P2 
    
    ; PUNTO2 
    P2:
    BTFSS PORTB,4 
    GOTO ON1 
    goto OFF1
     
    ON1:
     BSF PORTD,4
     GOTO MAIN 
    
    OFF1: 
    BCF PORTD,4
    GOTO MAIN 
    
    
    ;PUNTO3
   ;!A
    MOVF    PORTC,0    ;puertoB a w
    ANDLW   0b00000001 ;mascara para s0
    MOVWF   0x21,1     ;guardar s0 en 0x21
    COMF    0x21,1     ;complemento  0x21
    MOVF    0x21,0
    MOVWF   PORTD,0
   
     
    END
   


    




