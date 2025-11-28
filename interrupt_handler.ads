with Ada.Interrupts;

package Interrupt_Handler is

   type Mode_Type is (Manual, Automatic);

   protected type Mode_Manager_Type is
      procedure Switch_Mode;
      function Current_Mode return Mode_Type;
   private
      Current : Mode_Type := Automatic;
   end Mode_Manager_Type;

   protected type Interrupts_Type is
      procedure Button_Handler;
   end Interrupts_Type;

   -- Declaración de los objetos globales
   Mode_Manager : Mode_Manager_Type;
   Interrupts   : Interrupts_Type;

   procedure Initialize;

end Interrupt_Handler;