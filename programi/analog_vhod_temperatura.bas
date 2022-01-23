$regfile = "m328pdef.dat"
$crystal = 16000000     '16Mhz
$baud = 9600
$include "ArduinoNANO.bas"

pullupa0 = 1

dim povisana_temp as byte 'uvedemo novo spremenljivko
povisana_temp = 0        'njeno vrednost nastavimo na 0

   bitwait A0, reset
   do
      If AnA2  > 500 then povisana_temp = 1
      if povisana_temp = 1 then
       d11 = 1
      else
       d11 = 0
      end if
   loop
   end
