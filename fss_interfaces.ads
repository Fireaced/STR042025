with devicesFSS_V1; use devicesFSS_V1;

package FSS_Interfaces is


   ----------------------------------------------------------------------
   -- Protected object: Pitch Roll
   ----------------------------------------------------------------------

   protected Pitch_Roll_Data is
      procedure UpdatePitch (Pitch : in Pitch_Samples_Type; Collision: in Integer);
      procedure UpdateRoll (Roll  : in Roll_Samples_Type; Collision: in Integer);
      function Get_Pitch return Pitch_Samples_Type;
      function Get_Roll  return Roll_Samples_Type;
   private
      Current_Collision_Pitch : Integer := 0;
      Current_Collision_Roll : Integer := 0;
      Current_Pitch : Pitch_Samples_Type := 0;
      Current_Roll  : Roll_Samples_Type := 0;
   end Pitch_Roll_Data;

   ----------------------------------------------------------------------
   -- Protected object: Speed Altitud
   ----------------------------------------------------------------------

   protected Speed_Altitude_Data is
      procedure UpdateSpeed (Speed : in Speed_Samples_Type);
      procedure UpdateAltitude(Altitude  : in Altitude_Samples_Type);
      function Get_Speed return Speed_Samples_Type;
      function Get_Altitude  return Altitude_Samples_Type;
   private
      Current_Speed : Speed_Samples_Type := 0;
      Current_Altitude : Altitude_Samples_Type := 0;
   end Speed_Altitude_Data;
end FSS_Interfaces;