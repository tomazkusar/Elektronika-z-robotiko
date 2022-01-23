$regfile = "m328pdef.dat"
$crystal = 16000000     '16Mhz
$hwstack = 200
$swstack = 200
$framesize = 300
$baud = 115200
$include "ArduinoNANO.bas"

dim i as byte

do
   If AnA0 < 500 then goto utripaj
loop

utripaj:
   do
      for i = 0 to 255
         PWMD6  = i
         waitms 10
      next i

      for i = 255 to 0 step  -1
         PWMD6 = I                                              'pin D6
         waitms 10                                              'pin d5
      next i


   loop

   end

