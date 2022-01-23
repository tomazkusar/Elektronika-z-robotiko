$regfile = "m328pdef.dat"
$crystal = 16000000     '16Mhz
$include "ArduinoNANO.bas"
   do
      if A0 = 0 and A1 = 1 then
      waitms 100
         D13 = 0
         D11 = 1
         D12 = 0
      elseif A0 = 1 and A1 = 0 then
      waitms 100
         D11 = 0
         D12 = 1
         D13 = 0
      elseif A1 = 0 and A0 = 0 then
       waitms 100
         D11 = 0
         D12 = 0
         D13 = 1
      else
         D11 = 0
         D12 = 0
         D13 = 0
      end if
   loop
   end
