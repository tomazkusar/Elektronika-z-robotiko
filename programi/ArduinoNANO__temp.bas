'Authors: Tomaz Kusar
'Date: 22.1.2022
'name: ArduinoNANO.bas
'Version 1.0

'include file for Arduino NANO -
'
'
'*******************************************************************************
'===========================================================

const Timer2_counter_enabled = 0                           'ce omogocimo timer2 v funkciji casovnika

Const Gor = 1                                               'tudi za tipke
Const Dol = 0                                             '

Const Pwm_D6_D5_enabled = 1   'PWM na prikljuckih D5 in D6     TEGA UPORABI - priporoceno
Const Pwm_B1_B2_enabled = 0   'PWM na prikljuckih B1 in B2     Ce slucajno potrebujes vec, uporabi se tega
Const Pwm_D3_B3_enabled = 0   'PWM na prikljuckih B3 in D3     tega uporabi v skrajni sili, ampak potem timer2 ne uporabljaj kot stevca
'-----------------------------------------------------------+
'-LCD
Const Lcd_enabled = 0                                       'Print "text"
'-----------------------------------------------------------+
Config Submode = New
$nocompile                                                  'da se kompajla samo, ce je vkljuèen iz drugega programa, sam file pa se ne kompajla
'===========================================================+
'konfiguracija analogno digitalnega petvornika              |
'-----------------------------------------------------------+
Config Adc = Single , Prescaler = Auto , Reference = avcc   'Reference = Off  , Aref (moras prikljucit ref nap. na Aref prikljucek), AVCC (ne rabis nic)
Start Adc                                                   '
Enable Interrupts                                           '
'-----------------------------------------------------------+
'===========================================================+
'konfiguracija LCDja                                        |
'-----------------------------------------------------------+
#if Lcd_enabled = 1                                         '
   Config Lcdpin = Pin , Db4 = Portb.5 , Db5 = Portb.1 , Db6 = Portb.4 , Db7 = Portb.0 , E = Portb.2 , Rs = Portb.3
   Config Lcd = 16 * 1a                                     '
   Initlcd                                                  '
   Waitus 4                                                 '
#endif

Dim Msec As dword 'spremenljivka za stetje milisekund
config portd = output
config portb = output
config portc = input                                               '
'-----------------------------------------------------------+
'konfiguracija Tipk                                         |
'-----------------------------------------------------------+                                            '
   A0 Alias Pinc.0                                          '                                          '
   A1 Alias Pinc.1                                          '                                          '
   A2 Alias Pinc.2                                          '                                            '
   A3 Alias Pinc.3                                          '                                              '
   A4 Alias Pinc.4                                          '                                                     '                                           '
   A5 Alias Pinc.5
   'pull_up nastaviš na 1, da ustvariš pull up vezavo (po potrebi)                                       '
   pullupA0 Alias PORTC.0
   pullupA1 ALias PORTC.1
   pullupA2 Alias PORTC.2
   pullupA3 Alias PORTC.3
   pullupA4 Alias PORTC.4
   pullupA5 Alias PORTC.5
'===========================================================+
'imena pinov na vmesniku Arduino NANO
D0 alias PORTD.0
D1 alias PORTD.1
D2 alias PORTD.2
D3 alias PORTD.3
D4 alias PORTD.4
D5 alias PORTD.5
D6 alias PORTD.6
D7 alias PORTD.7

D8 alias PORTb.0
D9 alias PORTb.1
D10 alias PORTb.2
D11 alias PORTb.3
D12 alias PORTb.4
D13 alias PORTb.5

AnA0 alias getadc(0)
AnA1 alias getadc(1)
anA2 alias getadc(2)
anA3 alias getadc(3)
anA4 alias getadc(4)
anA5 alias getadc(5)
anA6 alias getadc(6)
anA7 alias getadc(7)

'==========================================================+

'Arduino NANO ima možnost PWM-ja na šestih prikljuekih in sicer: B1, B2, B3, D3, D5, D6
'Za PWM na prikljuekih B1 in B2 moramo omogoeit Timer1 (Easovnik 1). Za PWM na prikljuekih
'D3 in B3 moramo omogoeit timer2 in za PWM na prikljuekih D5 in D6 moramo omogoeit Timer0.

'Timer1 je 16 bitni, zato imamo možnost nastavit 8, 9 ali 10 bitni PWM. V našem primeru smo nastavili 8-bitni PWM
'Timer0 in Timer2 sta 8-bitna, zato te nastavitve nimata.

'ce uporabljamo LCD; potem prikljuèkov B NE moremo uporabljati za PWM

'primer kode za PWM, vrednost I = [0 - 255]

'Pwm1a = I                                             'OC1A = pin B1
'Pwm1b = I                                             'OC1B = pin B2
'Pwm2b = I                                             'OC2B = pin D3
'Pwm2a = I                                             'OC2A = pin B3
'Pwm0a = I                                             'OC0A = pin D6
'Pwm0b = I                                             'OC0B = pin D5

#if Pwm_D6_D5_enabled
   Config Timer0 = Pwm , Compare_a_pwm = Clear_up , Compare_b_pwm = Clear_up , Prescale = 1       '8-bitni timer
   PWMD6 alias Pwm0a
   PWMD5 alias Pwm0b
#endif


#if Pwm_B1_B2_enabled
   Config Timer1 = Pwm , Pwm = 8 , Compare_a_pwm = Clear_up , Compare_b_pwm = Clear_up , Prescale = 1       '16-bitni timer
   PWMB1 alias Pwm1a
   PWMB2 alias Pwm1b
#endif


#if Pwm_D3_B3_enabled
   Config Timer2 = Pwm , Compare_a_pwm = Clear_up , Compare_b_pwm = Clear_up , Prescale = 1       '8-bitni timer
   PWMD3 alias Pwm2b
   PWMB3 alias Pwm2a
#endif

'*************************************************************************
'konfiguracija timerja, ki steje milisekundne intervale
#if Timer2_counter_enabled
   const Timer2Reload = 15        'na 1ms
   config timer2=timer,prescale = 1024
   load timer2 , Timer2Reload
   on ovf2 Timer2_isr
   enable ovf2
   start timer2
   enable interrupts
#endif
'****************
'ce uporabljas timer, za stetje milisekund, spodnje 3 vrstice kopiraj povsem na konec porgrama

 'Timer2_isr:
   'Load Timer2 , Timer2reload
   'Msec = Msec + 1
'return

'**************************************************************************

 'Koda za komparator napetosti na prikljuckih D6(+input) in D7(-input)
 'ce je napetost na D6 > d7 je aco bit v 1
 'primer kode:
 'Portb.5 = Acsr.aco