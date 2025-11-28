with Ada.Interrupts;         -- necesario si otros paquetes usan interrupciones
with Ada.Interrupts.Names;   -- nombres de interrupciones del sistema

package Interrupt_Handler is

   type Mode_Type is (Manual, Automatic);

   protected Mode_Manager is
      procedure Switch_Mode;
      function Current_Mode return Mode_Type;
   private
      Current : Mode_Type := Manual;
   end Mode_Manager;

   -- Handler declarado como procedimiento de librería
   protected Interrupts is
      procedure Button_Handler;
   end Interrupts;

   -- Inicialización opcional (p. ej. configurar pin/mascara)
   procedure Initialize;

end Interrupt_Handler;