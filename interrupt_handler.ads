package Interrupt_Handler is

   type Mode_Type is (Manual, Automatic);

   protected Mode_M_Type is
      procedure Switch_Mode;
      function Current_Mode return Mode_Type;
   private
      Current : Mode_Type := Manual;
   end Mode_M_Type;

   Mode_Manager : Mode_M_Type;

end Interrupt_Handler;