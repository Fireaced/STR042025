with devicesFSS_V1; use devicesFSS_V1;

package FSS_Interfaces is


   ----------------------------------------------------------------------
   -- Protected object: Pitch Roll
   ----------------------------------------------------------------------

   protected Pitch_Roll_Data is
      procedure UpdatePitch (Pitch : in Pitch_Samples_Type);
      procedure UpdateRoll (Roll  : in Roll_Samples_Type);
      function Get_Pitch return Pitch_Samples_Type;
      function Get_Roll  return Roll_Samples_Type;
   private
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

   ----------------------------------------------------------------------
   -- Protected object: Display
   ----------------------------------------------------------------------

   protected Status_Record is
      procedure SetAltitude(Altitude : in Altitude_Samples_Type);
      procedure SetJoystick(Joystick : in Joystick_Samples_Type);
      procedure SetPitch(Pitch : in Pitch_Samples_Type);
      procedure SetRoll(Roll : in Roll_Samples_Type);
      procedure SetSpeed(Speed : in Speed_Samples_Type);
      procedure SetPower(Power : in Power_Samples_Type);
      procedure SetMessage(Message : in String);
      procedure ShowDisplay;
   private
      Current_Altitude : Altitude_Samples_Type := 0;
      Current_Joystick : Joystick_Samples_Type := (0, 0);
      Current_Pitch : Pitch_Samples_Type := 0;
      Current_Roll : Roll_Samples_Type := 0;
      Current_Speed : Speed_Samples_Type := 0;
      Current_Power : Power_Samples_Type := 0;
      Current_Message : String := "";
   end Status_Record;
end FSS_Interfaces;