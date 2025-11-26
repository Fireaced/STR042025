with Interrupt_Handler;
with tools;
package body FSS_Interfaces is

   protected body Selected_Mode is
      procedure UpdateMode (Mode : in String) is
      begin
         Current_Mode := Mode;
      end UpdateMode;

      function Get_Mode return String is
      begin
         return Current_Mode;
      end Get_Mode;
   end Selected_Mode;

   protected body Pitch_Roll_Data is

      procedure UpdatePitch (Pitch : in Pitch_Samples_Type; Collision: in Integer)  is
      begin
         if (Collision == 1) then
            Current_Collision_Pitch := 1;
            Current_Pitch  := Pitch;
         elsif (Current_Collision_Pitch == 0) then
            Current_Pitch := Pitch;
         end if;
      end UpdatePitch;

      procedure UpdateRoll (Roll  : in Roll_Samples_Type; Collision: in Integer) is
      begin
         if (Collision == 1) then
            Current_Collision_Roll := 1;
            Current_Roll  := Roll;
         elsif (Current_Collision_Roll == 0) then
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

      procedure SetJoystick(Joystick : in Joystick_Samples_Type) is
      begin
         Current_Joystick := Joystick;
      end SetJoystick;

      procedure SetPitch(Pitch : in Pitch_Samples_Type) is
      begin
         Current_Pitch := Pitch;
      end SetPitch;

      procedure SetRoll(Roll : in Roll_Samples_Type) is
      begin
         Current_Roll := Roll;
      end SetRoll;

      procedure SetSpeed(Speed : in Speed_Samples_Type) is
      begin
         Current_Speed := Speed;
      end SetSpeed;

      procedure SetPower(Power : in Power_Samples_Type) is
      begin
         Current_Power := Power;
      end SetPower;

      procedure SetMessage(Message : in String) is
      begin
         Current_Message := To_Unbounded_String(Message);
      end SetMessage;

      procedure ShowDisplay is
      begin
         Display_Altitude (Current_Altitude);
         Display_Pilot_Power(Current_Power);
         Display_Speed(Current_Speed);
         Display_Joystick (Current_Joystick);
         Display_Pitch (Current_Pitch);
         Display_Roll (Current_Roll);
         Display_Message(To_String(Current_Message));
      end ShowDisplay;

   end Status_Record;
end FSS_Interfaces;