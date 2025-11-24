with fss;
with System;
with Interrupt_Handler;

procedure main is

   pragma Priority (System.Priority'First);

begin

   fss.Background;

end main;
