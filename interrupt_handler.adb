with Ada.Interrupts;
with Ada.Interrupts.Names;

package body Interrupt_Handler is

   -------------------------------
   -- Mode_Manager_Type (body) --
   -------------------------------
   protected body Mode_Manager_Type is

      procedure Switch_Mode is
      begin
         case Current is
            when Manual     => Current := Automatic;
            when Automatic  => Current := Manual;
         end case;
      end Switch_Mode;

      function Current_Mode return Mode_Type is
      begin
         return Current;
      end Current_Mode;

   end Mode_Manager_Type;

   ----------------------------
   -- Interrupts_Type (body) --
   ----------------------------
   protected body Interrupts_Type is

      procedure Button_Handler is
      begin
         Mode_Manager.Switch_Mode;
      end Button_Handler;

   end Interrupts_Type;

   ---------------------------------------------------------
   -- AHORA SÍ: entity name = Interrupts.Button_Handler   --
   ---------------------------------------------------------
   pragma Attach_Handler
     (Interrupts.Button_Handler,
      Ada.Interrupts.Names.External_Interrupt_2);

   procedure Initialize is
   begin
      null;
   end Initialize;

end Interrupt_Handler;