	LIST P =16F628A
	INCLUDE "P16F628A.INC"
	__CONFIG _XT_OSC & _WDT_OFF & _PWRTE_OFF & _MCLRE_OFF & _BODEN_OFF & _LVP_OFF & _CP_OFF

	CBLOCK h'20'
SAYAC,SAYI
	ENDC
	ORG h'00'	
AYARLAMALAR
	CLRF PORTB
	BANKSEL TRISB	;BANK1'e gectik
	CLRF TRISB		;PORTB cikis belirlendi
	BCF TRISA,4
	BSF TRISA,5
	BANKSEL PORTB	;BANKO'a gectik	
	CLRF SAYI
BASLA
	CLRF SAYAC
	MOVF SAYI,W
	CALL CEV_TABLOSU
	MOVWF PORTB
DONGU
	BTFSS PORTA,5
	GOTO KONTROL
	GOTO DONGU
KONTROL
	BTFSS PORTA,5
	GOTO KONTROL
	INCF SAYAC,F
	MOVLW d'3'
	SUBWF SAYAC,W
	BTFSS STATUS,Z
	GOTO DONGU		;
	GOTO CEVRIM
CEVRIM
	INCF SAYI,F
	MOVF SAYI,W
	SUBLW d'9'
	BTFSS STATUS,Z	
	GOTO BASLA
	BSF PORTA,4
	GOTO DEGISME
DEGISME
	MOVLW d'9'
	CALL CEV_TABLOSU
	MOVWF PORTB
	GOTO DEGISME
CEV_TABLOSU
	ADDWF PCL,F
	RETLW h'3F' ;0
	RETLW h'06' ;1
	RETLW h'5B' ;2
	RETLW h'4F' ;3
	RETLW h'66' ;4
	RETLW h'6D' ;5
	RETLW h'7D' ;6
	RETLW h'07' ;7
	RETLW h'7F' ;8
	RETLW h'6F' ;9
	END
