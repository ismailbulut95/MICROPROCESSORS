	LIST P =16F628A
	INCLUDE "P16F628A.INC"
	__CONFIG _XT_OSC & _WDT_OFF & _PWRTE_OFF & _MCLRE_OFF & _BODEN_OFF & _LVP_OFF & _CP_OFF

	CBLOCK h'20'
SAYAC1,SAYAC2,SAYAC3
	ENDC

	ORG h'00'
	
AYARLAMALAR
	CLRF PORTB
	CLRF PORTA
	BANKSEL TRISB	;BANK1'e gectik
	CLRF TRISB		;PORTB cikis belirlendi
	BCF TRISA,4
	BSF TRISA,5		;RA5 input
	BANKSEL PORTB	;BANKO'a gectik
	BSF PORTA,4 
DONGU
	BTFSC PORTA,5
	GOTO DONGU
	CALL GECIKME
KONTROL
	BTFSS PORTA,5
	BCF PORTA,4
	GOTO DONGU
GECIKME
	MOVLW d'15'
	MOVWF SAYAC1
DONGU1
	MOVLW d'255'
	MOVWF SAYAC2
DONGU2
	MOVLW d'255'
	MOVWF SAYAC3
DONGU3
	DECFSZ SAYAC3,F
	GOTO DONGU3
	DECFSZ SAYAC2,F
	GOTO DONGU2
	DECFSZ SAYAC1,F
	GOTO DONGU1
	RETURN
	END
