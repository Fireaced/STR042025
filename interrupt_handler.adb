with Ada.Interrupts;
with Ada.Interrupts.Names;
with Interrupt_Handler;
with Kernel.Serial_Output;    -- opcional: cuidado en ISR
with System; use System;
with fss; use fss;

package body Interrupt_Handler is

   ----------------------------------------------------
   -- Protected object que contiene la lógica de modo --
   ----------------------------------------------------
   protected body Mode_Manager is

      procedure Switch_Mode is
      begin
         case Current is
            when Manual      => Current := Automatic; Mode ("Automatic");
            when Automatic => Current := Manual; Mode ("Manual");
         end case;
      end Switch_Mode;

      function Current_Mode return Mode_Type is
      begin
         return Current;
      end Current_Mode;

   end Mode_Manager;

   ---------------------------------------------
   -- Procedimiento que actuará como ISR (rápido)
   ---------------------------------------------
   protected body Interrupts is
      procedure Button_Handler is
      begin
         Mode_Manager.Switch_Mode;
      end Button_Handler;
   end Interrupts;

   -- Asociamos el handler a la interrupción física.
   pragma Attach_Handler (Button_Handler, Ada.Interrupts.Names.External_Interrupt_2);

   -- Inicialización: desmascarar, configurar pin, etc.
   procedure Initialize is
   begin
      -- Aquí puedes llamar a rutinas de bajo nivel para configurar el pin
      -- y dejar la interrupción habilitada. Si Force_External_Interrupt_2 ya
      -- gestiona los registros, quizá no necesites nada.
      null;
   end Initialize;

end Interrupt_Handler;