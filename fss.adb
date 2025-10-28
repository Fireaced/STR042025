with Kernel.Serial_Output; use Kernel.Serial_Output;
with Ada.Real_Time;        use Ada.Real_Time;
with System;               use System;


with Tools;                use Tools;
with devicesFSS_V1;        use devicesFSS_V1;


-- NO ACTIVAR ESTE PAQUETE MIENTRAS NO SE TENGA PROGRAMADA LA INTERRUPCION
-- Packages needed to generate button interrupts
-- with Ada.Interrupts.Names;
-- with Button_Interrupt; use Button_Interrupt;


package body fss is


 ----------------------------------------------------------------------
 --  Tipos/estado de modo de operación
 ----------------------------------------------------------------------
 type Mode_Type is (AutomaticMode, ManualMode);
 Current_Mode : Mode_Type := AutomaticMode;


<<<<<<< HEAD
  ----------------------------------------------------------------------
  ------------- procedimientos para probar los dispositivos 
  ------------- SE DEBERÁN QUITAR PARA EL PROYECTO
  ----------------------------------------------------------------------
  procedure Mode (modeInput : in String);
  procedure PositionAltitude;
  procedure Speed;
  procedure Collision;
  procedure Display;
  procedure Desvio_Automatico;

=======
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
>>>>>>> a099a7d (Version que compila)


 -----------------------------------------------------------------------
 ------------- declaration of protected objects
 -----------------------------------------------------------------------


 -- Aqui se declaran los objetos protegidos para los datos compartidos


 ----------------------------------------------------------------------
 ------------- procedimientos para probar los dispositivos
 ------------- SE DEBERÁN QUITAR PARA EL PROYECTO
 ----------------------------------------------------------------------
 procedure Mode (modeInput : in String);
 procedure PositionAltitude;
 procedure Speed;
 procedure Collision;
 procedure Display;


 procedure Mode (modeInput : in String) is
 begin
   if (modeInput = "Manual") then
     Current_Mode := ManualMode;
     Display_Message("Modo: Manual");
   elsif (modeInput = "Automatic") then
     Current_Mode := AutomaticMode;
     Display_Message("Modo: Automático");
   else
     Display_Message("Modo no reconocido");
   end if;
 end Mode;


 procedure Speed is
   Current_Power : Power_Samples_Type := 0;
   Current_Pp    : PilotPresence_Samples_Type := 1;
   Current_J     : Joystick_Samples_Type := (0, 0);


   Calculated_S  : Speed_Samples_Type := 0;
   Target_Pitch  : Pitch_Samples_Type := 0;
   Target_Roll   : Roll_Samples_Type  := 0;
 begin
   Read_Power (Current_Power);


   -- Velocidad = Power * 1.2 (kph). Convertimos explícitamente tipos.
   Calculated_S :=
     Speed_Samples_Type (
       Integer (Float (Integer (Current_Power)) * 1.2)
     );


   Read_Joystick (Current_J);
   Target_Pitch := Pitch_Samples_Type (Current_J(x));
   Target_Roll  := Roll_Samples_Type  (Current_J(y));


   if (Target_Pitch > 0 and Target_Roll > 0) then
     Calculated_S := Calculated_S + Speed_Samples_Type(200);
   elsif (Target_Pitch > 0) then
     Calculated_S := Calculated_S + Speed_Samples_Type(150);
   elsif (Target_Roll > 0) then
     Calculated_S := Calculated_S + Speed_Samples_Type(100);
   end if;


   if (Calculated_S >= Speed_Samples_Type(1000)) then
     Set_Speed(Speed_Samples_Type(1000));
     Light_2(On);
   elsif (Calculated_S <= Speed_Samples_Type(300)) then
     Set_Speed(Speed_Samples_Type(300));
     Light_2(On);
   else
     Set_Speed(Calculated_S);
   end if;
 end Speed;


 procedure PositionAltitude is
   Current_J      : Joystick_Samples_Type := (0, 0);
   Target_Pitch   : Pitch_Samples_Type := 0;
   Target_Roll    : Roll_Samples_Type  := 0;
   Aircraft_Pitch : Pitch_Samples_Type;
   Aircraft_Roll  : Roll_Samples_Type;


   Current_A      : Altitude_Samples_Type := Altitude_Samples_Type(8000);
   Clock          : Ada.Real_Time.Time := Ada.Real_Time.Clock;
   Delay_Interval : Ada.Real_Time.Time_Span := Ada.Real_Time.Milliseconds(300);  -- Ejemplo de espera
  
<<<<<<< HEAD
   procedure Desvio_Automatico is
   begin

   Set_Aircraft_Roll (Roll_Samples_Type (45));
   delay until Clock + Milliseconds (3000);
   Set_Aircraft_Roll (Roll_Samples_Type (0));

   end Desvio_Automatico;


   Procedure Collision is
      
   Current_Distance: Distance_Samples_Type := 0;
   Current_Speed: Speed_Samples_Type := 0;
   Time_Until_Collision: float := 0;
   Current_Pp: PilotPresence_Samples_Type := 1;
   Current_Light: Light_Samples_Type := 0;

   begin
      
   Read_Distance(Current_Distance);
   Current_Speed := Read_Speed;
   Current_Pp := Read_PilotPresence;
   Get_Light(Current_Light);
      
   Time_Until_Collision := Float(Current_Distance) / (Float(Current_Speed) * 1000.0 / 3600.0);
      
   if Current_Pp = 0 or Current_Light < 500 then
      if Time_Until_Collision < 15 then
         Alarm(4);
      end if;
      if Time_Until_Collision < 10 then
         Desvio_Automatico;
      end if;
   elsif Time_Until_Collision < 10 then
      Alarm(4);
      if Time_Until_Collision < 5 then
         Desvio_Automatico;
      end if;
   end if;
      
   end Collision;



  procedure Display is

    Current_A: Altitude_Samples_Type := Altitude_Samples_Type(8000);
    Current_Power: Power_Samples_Type := 0;
    Current_J: Joystick_Samples_Type := (0,0);
    Aircraft_Pitch: Pitch_Samples_Type; 
    Aircraft_Roll: Roll_Samples_Type;

  begin

    Current_A := Read_Altitude;
    Read_Power (Current_Pw);
    Read_Joystick (Current_J);
    Aircraft_Pitch := Read_Pitch;
    Aircraft_Roll := Read_Roll;

    Display_Altitude (Current_A);
    Display_Pilot_Power(Current_Power);
    Display_Speed(Speed_Samples_Type (float (Current_Power) * 1.2));
    Display_Joystick (Current_J);
    Display_Pitch (Aircraft_Pitch);
    Display_Roll (Aircraft_Roll);
    Display_Message("Message for the Pilot");

  end Display;

  -----------------------------------------------------------------------
  ------------- declaration of tasks 
  -----------------------------------------------------------------------

  -- Aqui se declaran las tareas que forman el STR

  task A is
    pragma priority (5);
  end A;
=======
begin
   -- Asignación explícita
   Aircraft_Pitch := Read_Pitch;
   Aircraft_Roll  := Read_Roll;
>>>>>>> a099a7d (Version que compila)


   Read_Joystick (Current_J);


   Target_Pitch := Pitch_Samples_Type (Current_J(x));
   Target_Roll  := Roll_Samples_Type  (Current_J(y));


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


   Current_A := Read_Altitude;


   if (Current_A <= 2500) then
     Light_1(On);


     if (Current_A <= 2000) then
       Set_Aircraft_Pitch (Pitch_Samples_Type(0));
       Set_Aircraft_Roll  (Roll_Samples_Type(0));
     else
       Set_Aircraft_Pitch (Target_Pitch);
       Set_Aircraft_Roll  (Target_Roll);


       if (Target_Roll > 35 or else Target_Roll < -35) then
         Display_Message ("Roll higher than +35/-35");
       end if;
     end if;


   elsif (Current_A >= 9500) then
     Light_1(On);


     if (Current_A >= 10000) then
       Set_Aircraft_Pitch (Pitch_Samples_Type(0));
       Set_Aircraft_Roll  (Roll_Samples_Type(0));
     else
       Set_Aircraft_Pitch (Target_Pitch);
       Set_Aircraft_Roll  (Target_Roll);


       if (Target_Roll > 35 or else Target_Roll < -35) then
         Display_Message ("Roll higher than +35/-35");
       end if;
     end if;


   else
     Set_Aircraft_Pitch (Target_Pitch);
     Set_Aircraft_Roll  (Target_Roll);


     if (Target_Roll > 35 or else Target_Roll < -35) then
       Display_Message ("Roll higher than +35/-35");
     end if;
   end if;


   -- Usar delay until para no violar "no_relative_delay"
   delay until (Clock + Delay_Interval);
end PositionAltitude;




 procedure Collision is
   Current_Distance       : Distance_Samples_Type := 0;
   Current_Speed          : Speed_Samples_Type    := 0;
   Time_Until_Collision   : Float := 0.0;
   Current_Pp             : PilotPresence_Samples_Type := 1;
   Current_Light          : Light_Samples_Type := 0;
   Delay_Interval : Ada.Real_Time.Time_Span := Ada.Real_Time.Milliseconds(300);
 begin
   Read_Distance(Current_Distance);
   Current_Speed := Read_Speed;
   Current_Pp    := Read_PilotPresence;
   Read_Light_Intensity(Current_Light);


   -- tiempo = distancia / velocidad (en m / (km/h -> m/s))
   Time_Until_Collision :=
     Float (Integer (Current_Distance)) /
     ( (Float (Integer (Current_Speed)) * 1000.0) / 3600.0 );


   if (Current_Pp = 0) or else (Current_Light < 500) then
     if Time_Until_Collision < 15.0 then
       Alarm(4);
     elsif Time_Until_Collision < 10.0 then
       -- Maniobra automática: alabeo 45º dcha durante 3 s
       Set_Aircraft_Roll(Roll_Samples_Type(45));
       delay until (Clock + Delay_Interval);
       Set_Aircraft_Roll(Roll_Samples_Type(0));
     end if;


   elsif Time_Until_Collision < 10.0 then
     Alarm(4);


   elsif Time_Until_Collision < 5.0 then
     Set_Aircraft_Roll(Roll_Samples_Type(45));
     delay until (Clock + Delay_Interval);
     Set_Aircraft_Roll(Roll_Samples_Type(0));
   end if;
 end Collision;


 procedure Display is
   Current_A     : Altitude_Samples_Type := Altitude_Samples_Type(8000);
   Current_Power : Power_Samples_Type := 0;
   Current_J     : Joystick_Samples_Type := (0, 0);
   Aircraft_Pitch: Pitch_Samples_Type;
   Aircraft_Roll : Roll_Samples_Type;
 begin
   Current_A := Read_Altitude;
   Read_Power (Current_Power);
   Read_Joystick (Current_J);
   Aircraft_Pitch := Read_Pitch;
   Aircraft_Roll  := Read_Roll;


   Display_Altitude (Current_A);
   Display_Pilot_Power (Current_Power);


   -- Velocidad mostrada = Power * 1.2 (conversión explícita)
   Display_Speed (
     Speed_Samples_Type (
       Integer (Float (Integer (Current_Power)) * 1.2)
     )
   );


   Display_Joystick (Current_J);
   Display_Pitch (Aircraft_Pitch);
   Display_Roll (Aircraft_Roll);
   Display_Message("Message for the Pilot");
 end Display;


 -----------------------------------------------------------------------
 ------------- declaration of tasks
 -----------------------------------------------------------------------


 -- Aqui se declaran las tareas que forman el STR


 task A is
   pragma Priority (5);
 end A;


 -----------------------------------------------------------------------
 ------------- body of tasks
 -----------------------------------------------------------------------


 -- Aqui se escriben los cuerpos de las tareas


 task body A is
 begin
   null;
 end A;


begin
 null;
end fss;










with Ada.Real_Time;        use Ada.Real_Time;
with System;               use System;


with Tools;                use Tools;
with devicesFSS_V1;        use devicesFSS_V1;


-- NO ACTIVAR ESTE PAQUETE MIENTRAS NO SE TENGA PROGRAMADA LA INTERRUPCION
-- Packages needed to generate button interrupts
-- with Ada.Interrupts.Names;
-- with Button_Interrupt; use Button_Interrupt;


package body fss is


 ----------------------------------------------------------------------
 --  Tipos/estado de modo de operación
 ----------------------------------------------------------------------
 type Mode_Type is (AutomaticMode, ManualMode);
 Current_Mode : Mode_Type := AutomaticMode;


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
 procedure Mode (modeInput : in String);
 procedure PositionAltitude;
 procedure Speed;
 procedure Collision;
 procedure Display;


 procedure Mode (modeInput : in String) is
 begin
   if (modeInput = "Manual") then
     Current_Mode := ManualMode;
     Display_Message("Modo: Manual");
   elsif (modeInput = "Automatic") then
     Current_Mode := AutomaticMode;
     Display_Message("Modo: Automático");
   else
     Display_Message("Modo no reconocido");
   end if;
 end Mode;


 procedure Speed is
   Current_Power : Power_Samples_Type := 0;
   Current_Pp    : PilotPresence_Samples_Type := 1;
   Current_J     : Joystick_Samples_Type := (0, 0);


   Calculated_S  : Speed_Samples_Type := 0;
   Target_Pitch  : Pitch_Samples_Type := 0;
   Target_Roll   : Roll_Samples_Type  := 0;
 begin
   Read_Power (Current_Power);


   -- Velocidad = Power * 1.2 (kph). Convertimos explícitamente tipos.
   Calculated_S :=
     Speed_Samples_Type (
       Integer (Float (Integer (Current_Power)) * 1.2)
     );


   Read_Joystick (Current_J);
   Target_Pitch := Pitch_Samples_Type (Current_J(x));
   Target_Roll  := Roll_Samples_Type  (Current_J(y));


   if (Target_Pitch > 0 and Target_Roll > 0) then
     Calculated_S := Calculated_S + Speed_Samples_Type(200);
   elsif (Target_Pitch > 0) then
     Calculated_S := Calculated_S + Speed_Samples_Type(150);
   elsif (Target_Roll > 0) then
     Calculated_S := Calculated_S + Speed_Samples_Type(100);
   end if;


   if (Calculated_S >= Speed_Samples_Type(1000)) then
     Set_Speed(Speed_Samples_Type(1000));
     Light_2(On);
   elsif (Calculated_S <= Speed_Samples_Type(300)) then
     Set_Speed(Speed_Samples_Type(300));
     Light_2(On);
   else
     Set_Speed(Calculated_S);
   end if;
 end Speed;


 procedure PositionAltitude is
   Current_J      : Joystick_Samples_Type := (0, 0);
   Target_Pitch   : Pitch_Samples_Type := 0;
   Target_Roll    : Roll_Samples_Type  := 0;
   Aircraft_Pitch : Pitch_Samples_Type;
   Aircraft_Roll  : Roll_Samples_Type;


   Current_A      : Altitude_Samples_Type := Altitude_Samples_Type(8000);
   Clock          : Ada.Real_Time.Time := Ada.Real_Time.Clock;
   Delay_Interval : Ada.Real_Time.Time_Span := Ada.Real_Time.Milliseconds(300);  -- Ejemplo de espera
  
begin
   -- Asignación explícita
   Aircraft_Pitch := Read_Pitch;
   Aircraft_Roll  := Read_Roll;


   Read_Joystick (Current_J);


   Target_Pitch := Pitch_Samples_Type (Current_J(x));
   Target_Roll  := Roll_Samples_Type  (Current_J(y));


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


   Current_A := Read_Altitude;


   if (Current_A <= 2500) then
     Light_1(On);


     if (Current_A <= 2000) then
       Set_Aircraft_Pitch (Pitch_Samples_Type(0));
       Set_Aircraft_Roll  (Roll_Samples_Type(0));
     else
       Set_Aircraft_Pitch (Target_Pitch);
       Set_Aircraft_Roll  (Target_Roll);


       if (Target_Roll > 35 or else Target_Roll < -35) then
         Display_Message ("Roll higher than +35/-35");
       end if;
     end if;


   elsif (Current_A >= 9500) then
     Light_1(On);


     if (Current_A >= 10000) then
       Set_Aircraft_Pitch (Pitch_Samples_Type(0));
       Set_Aircraft_Roll  (Roll_Samples_Type(0));
     else
       Set_Aircraft_Pitch (Target_Pitch);
       Set_Aircraft_Roll  (Target_Roll);


       if (Target_Roll > 35 or else Target_Roll < -35) then
         Display_Message ("Roll higher than +35/-35");
       end if;
     end if;


   else
     Set_Aircraft_Pitch (Target_Pitch);
     Set_Aircraft_Roll  (Target_Roll);


     if (Target_Roll > 35 or else Target_Roll < -35) then
       Display_Message ("Roll higher than +35/-35");
     end if;
   end if;


   -- Usar delay until para no violar "no_relative_delay"
   delay until (Clock + Delay_Interval);
end PositionAltitude;




 procedure Collision is
   Current_Distance       : Distance_Samples_Type := 0;
   Current_Speed          : Speed_Samples_Type    := 0;
   Time_Until_Collision   : Float := 0.0;
   Current_Pp             : PilotPresence_Samples_Type := 1;
   Current_Light          : Light_Samples_Type := 0;
   Delay_Interval : Ada.Real_Time.Time_Span := Ada.Real_Time.Milliseconds(300);
 begin
   Read_Distance(Current_Distance);
   Current_Speed := Read_Speed;
   Current_Pp    := Read_PilotPresence;
   Read_Light_Intensity(Current_Light);


   -- tiempo = distancia / velocidad (en m / (km/h -> m/s))
   Time_Until_Collision :=
     Float (Integer (Current_Distance)) /
     ( (Float (Integer (Current_Speed)) * 1000.0) / 3600.0 );


   if (Current_Pp = 0) or else (Current_Light < 500) then
     if Time_Until_Collision < 15.0 then
       Alarm(4);
     elsif Time_Until_Collision < 10.0 then
       -- Maniobra automática: alabeo 45º dcha durante 3 s
       Set_Aircraft_Roll(Roll_Samples_Type(45));
       delay until (Clock + Delay_Interval);
       Set_Aircraft_Roll(Roll_Samples_Type(0));
     end if;


   elsif Time_Until_Collision < 10.0 then
     Alarm(4);


   elsif Time_Until_Collision < 5.0 then
     Set_Aircraft_Roll(Roll_Samples_Type(45));
     delay until (Clock + Delay_Interval);
     Set_Aircraft_Roll(Roll_Samples_Type(0));
   end if;
 end Collision;


 procedure Display is
   Current_A     : Altitude_Samples_Type := Altitude_Samples_Type(8000);
   Current_Power : Power_Samples_Type := 0;
   Current_J     : Joystick_Samples_Type := (0, 0);
   Aircraft_Pitch: Pitch_Samples_Type;
   Aircraft_Roll : Roll_Samples_Type;
 begin
   Current_A := Read_Altitude;
   Read_Power (Current_Power);
   Read_Joystick (Current_J);
   Aircraft_Pitch := Read_Pitch;
   Aircraft_Roll  := Read_Roll;


   Display_Altitude (Current_A);
   Display_Pilot_Power (Current_Power);


   -- Velocidad mostrada = Power * 1.2 (conversión explícita)
   Display_Speed (
     Speed_Samples_Type (
       Integer (Float (Integer (Current_Power)) * 1.2)
     )
   );


   Display_Joystick (Current_J);
   Display_Pitch (Aircraft_Pitch);
   Display_Roll (Aircraft_Roll);
   Display_Message("Message for the Pilot");
 end Display;


 -----------------------------------------------------------------------
 ------------- declaration of tasks
 -----------------------------------------------------------------------


 -- Aqui se declaran las tareas que forman el STR


 task A is
   pragma Priority (5);
 end A;


 -----------------------------------------------------------------------
 ------------- body of tasks
 -----------------------------------------------------------------------


 -- Aqui se escriben los cuerpos de las tareas


 task body A is
 begin
   null;
 end A;


begin
 null;
end fss;