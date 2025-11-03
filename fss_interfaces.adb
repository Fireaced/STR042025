package body FSS_Interfaces is

   protected body Pitch_Roll_Data is

      procedure Update (Pitch : in Pitch_Samples_Type;
                        Roll  : in Roll_Samples_Type) is
      begin
         Current_Pitch := Pitch;
         Current_Roll  := Roll;
      end Update;

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
      end UpdateAltitud;

      function Get_Speed return Speed_Samples_Type is
      begin
         return Current_Speed;
      end Get_Speed;

      function Get_Altitude return Altitude_Samples_Type is
      begin
         return Current_Altitude;
      end Get_Altitude;

   end Speed_Altitude_Data;
end FSS_Interfaces;