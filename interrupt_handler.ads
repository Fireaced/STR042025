with Ada.Interrupts;         -- necesario si otros paquetes usan interrupciones
with Ada.Interrupts.Names;   -- nombres de interrupciones del sistema

package Interrupt_Handler is

   type Mode_Type is (Normal, Mantenimiento, Ahorro);

   protected Mode_Manager is
      procedure Switch_Mode;
      function Current_Mode return Mode_Type;
   private
      Current : Mode_Type := Normal;
   end Mode_Manager;

   -- Handler declarado como procedimiento de librería
   procedure Button_Handler;

   -- Inicialización opcional (p. ej. configurar pin/mascara)
   procedure Initialize;

end Interrupt_Handler;