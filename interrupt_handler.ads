with Ada.Interrupts;
with Ada.Interrupts.Names;

package Interrupt_Handler is

   type Mode_Type is (Manual, Automatic);

   ---------------------------------------
   -- Manejador de modos
   ---------------------------------------
   protected Mode_Manager_Type is
      procedure Switch_Mode;
      function Current_Mode return Mode_Type;
   private
      Current : Mode_Type := Manual;
   end Mode_Manager_Type;

   ---------------------------------------
   -- Objeto protegido de interrupciones
   ---------------------------------------
   protected Interrupts is
      pragma Priority (10);

      procedure Button_Handler;
      pragma Attach_Handler
        (Button_Handler, Ada.Interrupts.Names.External_Interrupt_2);

      entry Wait_Event;
   private
      Pending : Boolean := False;
   end Interrupts;

   ---------------------------------------
   -- Tarea esporádica
   ---------------------------------------
   task Sporadic_Task is
      pragma Priority (5);
   end Sporadic_Task;

   procedure Initialize;

end Interrupt_Handler;