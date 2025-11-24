with Ada.Interrupts;
with Ada.Interrupts.Names;
with Kernel.Serial_Output;    -- opcional: cuidado en ISR
with System; use System;

package body Interrupt_Handler is

   ----------------------------------------------------
   -- Protected object que contiene la lógica de modo --
   ----------------------------------------------------
   protected body Mode_Manager is

      procedure Switch_Mode is
      begin
         case Current is
            when Normal      => Current := Mantenimiento;
            when Mantenimiento => Current := Ahorro;
            when Ahorro       => Current := Normal;
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
   procedure Button_Handler is
   begin
      -- MUY IMPORTANTE: el código del ISR debe ser breve.
      -- Llamamos a una operación protegida para hacer el trabajo seguro.
      Mode_Manager.Switch_Mode;

      -- NO hacer I/O pesado (Put_Line) aquí: puede fallar o bloquear.
      -- Si quieres traza, mejor poner una bandera y que otra tarea haga el I/O.
   end Button_Handler;

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