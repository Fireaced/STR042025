package body FSS_Interfaces is

   protected body Speed_IF is
      procedure Set(Value : in Speed_Samples_Type) is
      begin
         Current := Value;
      end Set;

      function Get return Speed_Samples_Type is
      begin
         return Current;
      end Get;
   end Speed_IF;

end FSS_Interfaces;