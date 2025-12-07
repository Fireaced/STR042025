with Ada.Interrupts;
with Ada.Interrupts.Names;
with Ada.Text_IO; use Ada.Text_IO;
with FSS_Interfaces; use FSS_Interfaces;

package body Interrupt_Handler is

   ---------------------------
   -- Mode manager body
   ---------------------------
   protected body Mode_Manager_Type is
      procedure Switch_Mode is
      begin
         case Current is
            when Manual    => Current := Automatic;
            when Automatic => Current := Manual;
         end case;
      end Switch_Mode;

      function Current_Mode return Mode_Type is
      begin
         return Current;
      end Current_Mode;
   end Mode_Manager_Type;

   ---------------------------
   -- Interrupt handler body
   ---------------------------
   protected body Interrupts is

      procedure Button_Handler is
      begin
         Pending := True;         -- abre barrera
         Mode_Manager.Switch_Mode;
      end Button_Handler;

      entry Wait_Event when Pending is
      begin
         Pending := False;        -- cierra barrera
      end Wait_Event;

   end Interrupts;

   -------------------------
   -- Sporadic task body --
   -------------------------
   task body Sporadic_Task is
   begin
      loop
         Interrupts.Wait_Event;  -- espera interrupción

         Put_Line ("Interrupción recibida. Modo actual: "
                   & Mode_Manager.Current_Mode'Image);
      end loop;
   end Sporadic_Task;

   procedure Initialize is
   begin
      null;
   end Initialize;

end Interrupt_Handler;