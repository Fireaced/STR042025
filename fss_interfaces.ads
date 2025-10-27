with devicesFSS_V1; use devicesFSS_V1;

package FSS_Interfaces is

   ----------------------------------------------------------------------
   -- Protected object: Velocidad
   ----------------------------------------------------------------------
   protected Speed_IF is
      procedure Set(Value : in Speed_Samples_Type);
      function Get return Speed_Samples_Type;
   private
      Current : Speed_Samples_Type := 0;
   end Speed_IF;

end FSS_Interfaces;