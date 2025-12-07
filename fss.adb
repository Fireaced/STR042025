with Kernel.Serial_Output; use Kernel.Serial_Output;
with Ada.Real_Time; use Ada.Real_Time;
with System; use System;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;

with Tools; use Tools;
with devicesFSS_V1; use devicesFSS_V1;
with FSS_Interfaces; use FSS_Interfaces;

-- NO ACTIVAR ESTE PAQUETE MIENTRAS NO SE TENGA PROGRAMADA LA INTERRUPCION
-- Packages needed to generate button interrupts       
-- with Ada.Interrupts.Names;
-- with Button_Interrupt; use Button_Interrupt;

-- Alejandro García Hidalgo, Roberto Valentín Lago, Diego Espinosa García, Alvaro Pintado Budia

-- Tarea A (Tarea Posición - Altitud), Tarea B (Tarea Velocidad)
-- Objetos protegidos en el fichero fss_interfaces (Pitch_Roll_Data para compartir los valores del alabeo y cabeceo)

package body fss is
  ----------------------------------------------------------------------
  ------------- procedure exported 
  ----------------------------------------------------------------------
  procedure Background is
  begin
    loop
      null;
    end loop;
  end Background;
  
  ----------------------------------------------------------------------

  -----------------------------------------------------------------------
  ------------- declaration of protected objects 
  -----------------------------------------------------------------------

  -- Aqui se declaran los objetos protegidos para los datos compartidos  


  ----------------------------------------------------------------------
  ------------- procedimientos para probar los dispositivos 
  ------------- SE DEBERÁN QUITAR PARA EL PROYECTO
  ----------------------------------------------------------------------
  procedure PositionAltitude;
  procedure Speed;
  procedure Collision;
  procedure Display;
  procedure Desvio_Automatico;


  procedure Mode (modeInput : in String) is
  begin
    if (modeInput = "Manual") then
      Selected_Mode.UpdateMode("Manual");
      Put_line("Manual Mode");
    elsif (modeInput = "Automatic") then
      Selected_Mode.UpdateMode("Automatic");
      Put_line("Automatic Mode");
    end if;
  end Mode;

  procedure Speed is

    Current_Power: Power_Samples_Type := 0;
    Current_Pp: PilotPresence_Samples_Type := 1;

    Calculated_S: Speed_Samples_type := 0;
    Target_Pitch: Pitch_Samples_Type := 0;
    Target_Roll: Roll_Samples_Type := 0; 
    

  begin

    Read_Power (Current_Power);
    Calculated_S := Speed_Samples_Type (float (Current_Power) * 1.2);

    Target_Pitch := Pitch_Roll_Data.Get_Pitch;
    Target_Roll := Pitch_Roll_Data.Get_Roll;

    if (Target_Pitch > 0 and Target_Roll > 0) then
      Calculated_S := Calculated_S + (Speed_Samples_Type (200));
    elsif (Target_Pitch > 0) then
      Calculated_S := Calculated_S + (Speed_Samples_Type (150));
    elsif (Target_Roll > 0) then
      Calculated_S := Calculated_S + (Speed_Samples_Type (100));
    end if;

    if (Calculated_S >= 1000) then
      Calculated_S := Speed_Samples_Type (1000);
      Light_2(On);
    elsif (Calculated_S <= 300) then
      Calculated_S := Speed_Samples_Type (300);
      Light_2(On);
    else
      Speed_Altitude_Data.UpdateSpeed (Calculated_S);
      Set_Speed(Calculated_S);
    end if;

    Status_Record.SetPower(Current_Power);
    Status_Record.SetSpeed(Calculated_S);

  end Speed;

  procedure PositionAltitude is

    Current_J: Joystick_Samples_Type := (0,0);
    Current_Pitch: Pitch_Samples_Type := 0;
    Current_Roll: Roll_Samples_Type := 0;
    Target_Pitch: Pitch_Samples_Type := 0;
    Target_Roll: Roll_Samples_Type := 0;
    
    Current_A: Altitude_Samples_Type := Altitude_Samples_Type(8000);

  begin

    Read_Joystick (Current_J);

    Current_Pitch := Read_Pitch;
    Current_Roll := Read_Roll;

    Target_Pitch := Pitch_Samples_Type (Current_J(x)) + Current_Pitch;
    Target_Roll := Roll_Samples_Type (Current_J(y)) + Current_Roll;

    if (Target_Pitch > 30) then
      Target_Pitch := 30;
    elsif (Target_Pitch < -30) then
      Target_Pitch := -30;
    end if;

    if (Target_Roll > 45) then
      Target_Roll := 45;
    elsif (Target_Roll < -45) then
      Target_Roll := -45;
    end if;

    Current_A := Speed_Altitude_Data.Get_Altitude;

    if (Current_A <= 2500) then
      Light_1(On);

      if (Current_A <= 2000) then
        Target_Pitch := Pitch_Samples_Type (0);
        Target_Roll := Roll_Samples_Type (0);
      else
        if (Target_Roll > 35 or Target_Roll < -35) then
          Status_Record.SetMessage("Roll higher than +35/-35");
        end if;
      end if;
    elsif (Current_A >= 9500) then
      Light_1(On);

      if (Current_A >= 10000) then
        Target_Pitch := Pitch_Samples_Type (0);
        Target_Roll := Roll_Samples_Type (0);
      else
        if (Target_Roll > 35 or Target_Roll < -35) then
          Status_Record.SetMessage("Roll higher than +35/-35");
        end if;
      end if;
    
    else
      if (Target_Roll > 35 or Target_Roll < -35) then
          Status_Record.SetMessage("Roll higher than +35/-35");
        end if;
    end if;

    Pitch_Roll_Data.UpdatePitch(Target_Pitch, 0);
    Pitch_Roll_Data.UpdateRoll(Target_Roll, 0);
    Set_Aircraft_Pitch (Target_Pitch);
    Set_Aircraft_Roll (Target_Roll);

    Status_Record.SetAltitude(Current_A);
    Status_Record.SetJoystick(Current_J);
    Status_Record.SetPitch(Target_Pitch);
    Status_Record.SetRoll(Target_Roll);

  end PositionAltitude;
  
  procedure Desvio_Automatico is
  begin

    Set_Aircraft_Roll (Roll_Samples_Type (45));
    Pitch_Roll_Data.UpdateRoll(Roll_Samples_Type (45), 1);
    Status_Record.SetRoll (Roll_Samples_Type (0));
    delay until Clock + Milliseconds (3000);
    Set_Aircraft_Roll (Roll_Samples_Type (0));
    Pitch_Roll_Data.UpdateRoll(Roll_Samples_Type (0), 1);
    Status_Record.SetRoll (Roll_Samples_Type (0));

  end Desvio_Automatico;


  procedure Collision is
    Current_Distance    : Distance_Samples_Type := 0;
    Current_Speed       : Speed_Samples_Type    := 0;
    Time_Until_Collision : Float := 0.0;
    Current_Pp          : PilotPresence_Samples_Type := 1;
    Current_Light       : Light_Samples_Type := 0;
  begin
    Read_Distance(Current_Distance);
    Current_Speed := Speed_Altitude_Data.Get_Speed;
    Current_Pp    := Read_PilotPresence;
    Read_Light_Intensity(Current_Light);

    Time_Until_Collision :=
        Float(Integer(Current_Distance)) / (Float(Integer(Current_Speed)) * 1000.0 / 3600.0);

    if Current_Pp = 0 or else Float(Current_Light) < 500.0 then
        if Time_Until_Collision < 15.0 then
            Alarm(4);
        end if;
        if Time_Until_Collision < 10.0 then
            Desvio_Automatico;
        end if;
    elsif Time_Until_Collision < 10.0 then
        Alarm(4);
        if Time_Until_Collision < 5.0 then
            Desvio_Automatico;
        end if;
    end if;
  end Collision;




  procedure Display is
  begin
      Display_Altitude (Status_Record.GetAltitude);
      Display_Pilot_Power(Status_Record.GetPower);
      Display_Speed(Status_Record.GetSpeed);
      Display_Joystick (Status_Record.GetJoystick);
      Display_Pitch (Status_Record.GetPitch);
      Display_Roll (Status_Record.GetRoll);
      Display_Message(Status_Record.GetMessage);
  end Display;
  -----------------------------------------------------------------------
  ------------- declaration of tasks 
  -----------------------------------------------------------------------

  -- Aqui se declaran las tareas que forman el STR

  task body A is 
  begin
    loop
      if(Selected_Mode.Get_Mode = "Automatic") then
         Start_Activity ("Position-Altitude Executing:");
         PositionAltitude;
         Finish_Activity ("Position-Altitude Ended:");
         delay until Clock + Milliseconds (200);
      end if;
    end loop;
  end A;

  task body B is 
  begin
    loop
      if(Selected_Mode.Get_Mode = "Automatic") then
         Start_Activity("Speed Executing:");
         Speed;
         Finish_Activity ("Speed Ended:");
         delay until Clock + Milliseconds (300);
      end if;
    end loop;
  end B;

   task body Manual is
   begin
    if(Selected_Mode.Get_Mode = "Manual") then
      Put_line("----- Manual Task -----");
    end if;
  end Manual;

begin
  null;
end fss;