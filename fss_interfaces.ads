with devicesFSS_V1; use devicesFSS_V1;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;

package FSS_Interfaces is

   ----------------------------------------------------------------------
   -- Protected object: Selected Mode
   ----------------------------------------------------------------------

   protected Selected_Mode is
      procedure UpdateMode (Mode : in String);
      function Get_Mode return String;
   private
      Current_Mode : String := "Manual";
   end Selected_Mode;


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

   ----------------------------------------------------------------------
   -- Protected object: Display
   ----------------------------------------------------------------------

   protected Status_Record is
      procedure SetAltitude(Altitude : in Altitude_Samples_Type);
      function GetAltitude return Altitude_Samples_Type;
      procedure SetJoystick(Joystick : in Joystick_Samples_Type);
      function GetJoystick return Joystick_Samples_Type;
      procedure SetPitch(Pitch : in Pitch_Samples_Type);
      function GetPitch return Pitch_Samples_Type;
      procedure SetRoll(Roll : in Roll_Samples_Type);
      function GetRoll return Roll_Samples_Type;
      procedure SetSpeed(Speed : in Speed_Samples_Type);
      function GetSpeed return Speed_Samples_Type;
      procedure SetPower(Power : in Power_Samples_Type);
      function GetPower return Power_Samples_Type;
      procedure SetMessage(Message : in String);
      function GetMessage return String;
   private
      Current_Altitude : Altitude_Samples_Type := 0;
      Current_Joystick : Joystick_Samples_Type := (0, 0);
      Current_Pitch : Pitch_Samples_Type := 0;
      Current_Roll : Roll_Samples_Type := 0;
      Current_Speed : Speed_Samples_Type := 0;
      Current_Power : Power_Samples_Type := 0;
      Current_Message : Unbounded_String := To_Unbounded_String("");
   end Status_Record;
end FSS_Interfaces;