package body Interrupt_Handler is

   -- Creamos el objeto protegido local dentro del body
   Mode_Manager : Mode_Manager_Type;

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

   task body Sporadic_Task is
   begin
      loop
         -- aquí usarías Mode_Manager.Switch_Mode y Current_Mode
         null;
      end loop;
   end Sporadic_Task;

end Interrupt_Handler;