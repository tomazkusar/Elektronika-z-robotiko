$regfile = "m328pdef.dat"
$crystal = 16000000     '16Mhz
$baud = 115200
$include "ArduinoNANO.bas"

utripaj:
   do
      D13 = 1
      waitms 500
      D13 = 0
      waitms 500
   loop

end
