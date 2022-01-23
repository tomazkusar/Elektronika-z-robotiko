$regfile = "m328pdef.dat"
$crystal = 16000000     '16Mhz
$include "ArduinoNANO.bas"
pullupa0 = 1
   do
      if A0 = 0 then
         D13 = 1
      else
         D13 = 0
      end if
   loop
   end