with Ada.Text_IO; use Ada.Text_IO;

package body Interrupt_Handler is

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

end Interrupt_Handler;