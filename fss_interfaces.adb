with tools;
package body FSS_Interfaces is

   protected body Selected_Mode is
      procedure UpdateMode (Mode : in String) is
      begin
         Current_Mode := To_Unbounded_String(Mode);
      end UpdateMode;

      function Get_Mode return String is
      begin
         return To_String(Current_Mode);
      end Get_Mode;
   end Selected_Mode;

   protected body Selected_Mode is
      procedure UpdateMode (Mode : in String) is
      begin
         Current_Mode := To_Unbounded_String(Mode);
      end UpdateMode;

      function Get_Mode return String is
      begin
         return To_String(Current_Mode);
      end Get_Mode;
   end Selected_Mode;

   protected body Pitch_Roll_Data is

      procedure UpdatePitch (Pitch : in Pitch_Samples_Type; Collision: in Integer)  is
      procedure UpdatePitch (Pitch : in Pitch_Samples_Type; Collision: in Integer)  is
      begin
         if (Collision = 1) then
            Current_Collision_Pitch := 1;
            Current_Pitch  := Pitch;
         elsif (Current_Collision_Pitch = 0) then
            Current_Pitch := Pitch;
         end if;
      end UpdatePitch;

      procedure UpdateRoll (Roll  : in Roll_Samples_Type; Collision: in Integer) is
      begin
         if (Collision = 1) then
            Current_Collision_Roll := 1;
            Current_Roll  := Roll;
         elsif (Current_Collision_Roll = 0) then
            Current_Roll := Roll;
         end if;
      end UpdateRoll;

      function Get_Pitch return Pitch_Samples_Type is
      begin
         return Current_Pitch;
      end Get_Pitch;

      function Get_Roll return Roll_Samples_Type is
      begin
         return Current_Roll;
      end Get_Roll;

   end Pitch_Roll_Data;

   protected body Speed_Altitude_Data is

      procedure UpdateSpeed (Speed : in Speed_Samples_Type) is
      begin
         Current_Speed := Speed;
      end UpdateSpeed;

      procedure UpdateAltitude (Altitude  : in Altitude_Samples_Type) is
      begin
         Current_Altitude := Altitude;
      end UpdateAltitude;

      function Get_Speed return Speed_Samples_Type is
      begin
         return Current_Speed;
      end Get_Speed;

      function Get_Altitude return Altitude_Samples_Type is
      begin
         return Current_Altitude;
      end Get_Altitude;

   end Speed_Altitude_Data;

   protected body Status_Record is

      procedure SetAltitude(Altitude : in Altitude_Samples_Type) is
      begin
         Current_Altitude := Altitude;
      end SetAltitude;

      function GetAltitude return Altitude_Samples_Type is
      begin
         return Current_Altitude;
      end GetAltitude;

      procedure SetJoystick(Joystick : in Joystick_Samples_Type) is
      begin
         Current_Joystick := Joystick;
      end SetJoystick;

      function GetJoystick return Joystick_Samples_Type is
      begin
         return Current_Joystick;
      end GetJoystick;

      procedure SetPitch(Pitch : in Pitch_Samples_Type) is
      begin
         Current_Pitch := Pitch;
      end SetPitch;

      function GetPitch return Pitch_Samples_Type is
      begin
         return Current_Pitch;
      end GetPitch;

      procedure SetRoll(Roll : in Roll_Samples_Type) is
      begin
         Current_Roll := Roll;
      end SetRoll;

      function GetRoll return Roll_Samples_Type is
      begin
         return Current_Roll;
      end GetRoll;

      procedure SetSpeed(Speed : in Speed_Samples_Type) is
      begin
         Current_Speed := Speed;
      end SetSpeed;

      function GetSpeed return Speed_Samples_Type is
      begin
         return Current_Speed;
      end GetSpeed;

      procedure SetPower(Power : in Power_Samples_Type) is
      begin
         Current_Power := Power;
      end SetPower;

      function GetPower return Power_Samples_Type is
      begin
         return Current_Power;
      end GetPower;

      procedure SetMessage(Message : in String) is
      begin
         Current_Message := To_Unbounded_String(Message);
      end SetMessage;

      function GetMessage return String is
      begin
         return To_String(Current_Message);
      end GetMessage;

   end Status_Record;

   protected body Status_Record is

      procedure SetAltitude(Altitude : in Altitude_Samples_Type) is
      begin
         Current_Altitude := Altitude;
      end SetAltitude;

      function GetAltitude return Altitude_Samples_Type is
      begin
         return Current_Altitude;
      end GetAltitude;

      procedure SetJoystick(Joystick : in Joystick_Samples_Type) is
      begin
         Current_Joystick := Joystick;
      end SetJoystick;

      function GetJoystick return Joystick_Samples_Type is
      begin
         return Current_Joystick;
      end GetJoystick;

      procedure SetPitch(Pitch : in Pitch_Samples_Type) is
      begin
         Current_Pitch := Pitch;
      end SetPitch;

      function GetPitch return Pitch_Samples_Type is
      begin
         return Current_Pitch;
      end GetPitch;

      procedure SetRoll(Roll : in Roll_Samples_Type) is
      begin
         Current_Roll := Roll;
      end SetRoll;

      function GetRoll return Roll_Samples_Type is
      begin
         return Current_Roll;
      end GetRoll;

      procedure SetSpeed(Speed : in Speed_Samples_Type) is
      begin
         Current_Speed := Speed;
      end SetSpeed;

      function GetSpeed return Speed_Samples_Type is
      begin
         return Current_Speed;
      end GetSpeed;

      procedure SetPower(Power : in Power_Samples_Type) is
      begin
         Current_Power := Power;
      end SetPower;

      function GetPower return Power_Samples_Type is
      begin
         return Current_Power;
      end GetPower;

      procedure SetMessage(Message : in String) is
      begin
         Current_Message := To_Unbounded_String(Message);
      end SetMessage;

      function GetMessage return String is
      begin
         return To_String(Current_Message);
      end GetMessage;

   end Status_Record;
end FSS_Interfaces;