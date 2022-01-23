$regfile = "m328pdef.dat"
$crystal = 16000000     '16Mhz
$hwstack = 200
$swstack = 200
$framesize = 300
$baud = 115200
$include "ArduinoNANO.bas"
config portd = output
config portb = output
config portc = input

dim interval1 as dword
interval1 = 3000 'sekunda
dim cas1 as dword
cas1 = msec
dim temp1 as dword

dim interval2 as dword
interval2 = 500 'sekunda
dim cas2 as dword
cas2 = msec
dim temp2 as dword

dim interval3 as dword
interval3 = 250 'sekunda
dim cas3 as dword
cas3 = msec
dim temp3 as dword

do

   temp1 = msec - cas1
   if  temp1 > interval1 then
      cas1  = msec
      toggle portd.2
   end if

    temp2 = msec - cas2
   if  temp2 > interval2 then
      cas2  = msec
      toggle portd.3
   end if

     temp3 = msec - cas3
   if  temp3 > interval3 then
      cas3  = msec
      toggle portd.4
   end if
loop


end


Timer2_isr:
   Load Timer2 , Timer2reload
   Msec = Msec + 1
return

