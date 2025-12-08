
with Ada.Real_Time; use Ada.Real_Time;
with devicesfss_v1; use devicesfss_v1;

package Testing_1 is

    ---------------------------------------------------------------------
    ------ Access time for devices
    ---------------------------------------------------------------------
    WCET_Distance: constant Ada.Real_Time.Time_Span := Ada.Real_Time.Milliseconds(5);
    WCET_Light: constant Ada.Real_Time.Time_Span := Ada.Real_Time.Milliseconds(5);
    
    WCET_Joystick: constant Ada.Real_Time.Time_Span := Ada.Real_Time.Milliseconds(5);
    WCET_PilotPresence: constant Ada.Real_Time.Time_Span := Ada.Real_Time.Milliseconds(5);
    WCET_PilotButton: constant Ada.Real_Time.Time_Span := Ada.Real_Time.Milliseconds(5);
    
    WCET_Power: constant Ada.Real_Time.Time_Span := Ada.Real_Time.Milliseconds(4);
    
    WCET_Speed: constant Ada.Real_Time.Time_Span := Ada.Real_Time.Milliseconds(7);
    WCET_Altitude: constant Ada.Real_Time.Time_Span := Ada.Real_Time.Milliseconds(18);

    WCET_Pitch: constant Ada.Real_Time.Time_Span := Ada.Real_Time.Milliseconds(20);
    WCET_Roll: constant Ada.Real_Time.Time_Span := Ada.Real_Time.Milliseconds(18);

    WCET_Display: constant Ada.Real_Time.Time_Span := Ada.Real_Time.Milliseconds(15);
    WCET_Alarm: constant Ada.Real_Time.Time_Span := Ada.Real_Time.Milliseconds(5);

    ---------------------------------------------------------------------
    ------ SCENARIO ----------------------------------------------------- 
    ---------------------------------------------------------------------
    -- Initial_Altitude: Altitude_Samples_Type := 8000;
    
    ---------------------------------------------------------------------
    ------ DISTANCE OK---------------------------------------------------
    cantidad_datos_Distancia: constant := 200;
    type Indice_Secuencia_Distancia is mod cantidad_datos_Distancia;
    type tipo_Secuencia_Distancia is array (Indice_Secuencia_Distancia) of Distance_Samples_Type;

    Distance_Simulation: tipo_Secuencia_Distancia :=  -- next sample every 100ms.
            ( 5555,5555,5555,5555,5555, 5555,5555,5555,5555,5555,   -- 1s.
              5555,5555,5555,5555,5555, 5555,5555,5555,5555,5555,   -- 2s.
              5555,5555,5555,5555,5555, 5555,5555,5555,5555,5555,   -- 3s.
              4440,4440,4440,4440,4440, 4440,4440,4440,4440,4440,   -- 4s.  ! objeto detectado
              4440,4440,4440,4440,4440, 4440,4440,4440,4440,4440,   -- 5s.
              3330,3330,3330,3330,3330, 3330,3330,3330,3330,3330,   -- 6s.
              3000,3000,3000,3000,3000, 3000,3000,3000,3000,3000,   -- 7s.
              2400,2400,2400,2400,2400, 2400,2400,2400,2400,2400,   -- 8s.  !!! objeto proximo
              1999,1999,1999,1999,1999, 1999,1999,1999,1999,1999,   -- 9s.
              0990,0990,0990,0990,0990, 0990,0990,0990,0990,0990,   -- 10s.
              0411,0411,0411,0411,0411, 0411,0411,0411,0411,0411,   -- 11s. !!!! peligro colisión
              5555,5555,5555,5555,5555, 5555,5555,5555,5555,5555,   -- 12s.
              5555,5555,5555,5555,5555, 5555,5555,5555,5555,5555,   -- 13s.
              5555,5555,5555,5555,5555, 5555,5555,5555,5555,5555,   -- 14s.
              5555,5555,5555,5555,5555, 5555,5555,5555,5555,5555,   -- 15s. 
              5555,5555,5555,5555,5555, 5555,5555,5555,5555,5555,   -- 16s.
              5555,5555,5555,5555,5555, 5555,5555,5555,5555,5555,   -- 17s.
              5555,5555,5555,5555,5555, 5555,5555,5555,5555,5555,   -- 18s.
              5555,5555,5555,5555,5555, 5555,5555,5555,5555,5555,   -- 19s.
              5555,5555,5555,5555,5555, 5555,5555,5555,5555,5555);  -- 20s.
                   
    ---------------------------------------------------------------------
    ------ LIGHT OK------------------------------------------------------

    cantidad_datos_Light: constant := 200;
    type Indice_Secuencia_Light is mod cantidad_datos_Light;
    type tipo_Secuencia_Light is array (Indice_Secuencia_Light) of Light_Samples_Type;

    Light_Intensity_Simulation: tipo_Secuencia_Light :=  -- 1 muestra cada 100ms.
(
  700,700,700,700,700, 700,700,700,700,700,   -- 1s.
  700,700,700,700,700, 700,700,700,700,700,   -- 2s.
  700,700,700,700,700, 700,700,700,700,700,   -- 3s.
  700,700,700,700,700, 700,700,700,700,700,   -- 4s.
  700,700,700,700,700, 700,700,700,700,700,   -- 5s.
  700,700,700,700,700, 700,700,700,700,700,   -- 6s.
  700,700,700,700,700, 700,700,700,700,700,   -- 7s.

  300,300,300,300,300, 300,300,300,300,300,   -- 8s. ★ Baja visibilidad (activa Req. 5.5)

  700,700,700,700,700, 700,700,700,700,700,   -- 9s.
  700,700,700,700,700, 700,700,700,700,700,   -- 10s.
  700,700,700,700,700, 700,700,700,700,700,   -- 11s.
  700,700,700,700,700, 700,700,700,700,700,   -- 12s.
  700,700,700,700,700, 700,700,700,700,700,   -- 13s.
  700,700,700,700,700, 700,700,700,700,700,   -- 14s.
  700,700,700,700,700, 700,700,700,700,700,   -- 15s.
  700,700,700,700,700, 700,700,700,700,700,   -- 16s.
  700,700,700,700,700, 700,700,700,700,700,   -- 17s.
  700,700,700,700,700, 700,700,700,700,700,   -- 18s.
  700,700,700,700,700, 700,700,700,700,700,   -- 19s.
  700,700,700,700,700, 700,700,700,700,700    -- 20s.
);
    ---------------------------------------------------------------------
    ------ JOYSTICK OK---------------------------------------------------

    cantidad_datos_Joystick: constant := 200;
    type Indice_Secuencia_Joystick is mod cantidad_datos_Joystick;
    type tipo_Secuencia_Joystick is array (Indice_Secuencia_Joystick) 
                                             of Joystick_Samples_Type;

    Joystick_Simulation: tipo_Secuencia_Joystick :=  -- 1 muestra cada 100 ms
(
  -- 1s: Vuelo estable
  ( 5,  3),( 5,  3),( 4,  2),( 3,  1),( 2,  0),
  ( 3, -1),( 4, -1),( 3,  0),( 2,  1),( 1,  2),

  -- 2s: Vuelo estable
  ( 2,  2),( 2,  2),( 3,  1),( 3,  0),( 2, -1),
  ( 2,  1),( 1,  1),( 0,  0),( 1, -1),( 2, -2),

  -- 3s: Inicio aproximación
  ( 5,  3),( 5,  3),( 6,  2),( 7,  1),( 8,  0),
  (10, -1),(10,  0),(10,  1),(10,  2),(10,  3),

  -- 4s: Obstáculo detectado
  (12,  2),(12,  3),(14,  2),(14,  1),(15,  0),
  (16, -1),(17, -1),(17,  0),(16,  1),(15,  1),

  -- 5s: Riesgo creciente
  (18,  3),(18,  3),(18,  2),(17,  1),(17, -1),
  (18, -2),(19, -2),(18, -1),(17,  0),(17,  1),

  -- 6s: TTC < 15
  (20, 10),(20, 10),(20, 11),(19, 12),(18, 15),
  (18, 18),(17, 21),(16, 20),(15, 18),(14, 16),

  -- 7s: TTC < 10 — cerca del desvío automático
  (25, 25),(25, 25),(24, 27),(23, 30),(22, 32),
  (21, 34),(20, 36),(18, 35),(17, 33),(16, 31),

  -- 8s: Baja visibilidad → alarmas anticipadas
  (20, 25),(20, 25),(19, 23),(18, 18),(17, 15),
  (16, 12),(15, 10),(14,  8),(13,  5),(12,  3),

  -- 9s: Piloto ausente → alarmas más agresivas
  (10,  3),(10,  2),( 9,  1),( 8,  0),( 7, -1),
  ( 6, -2),( 5, -2),( 4, -1),( 4,  0),( 5,  1),

  -- 10s: Riesgo severo (TTC < 5)
  (15,  8),(15,  6),(14,  5),(13,  4),(12,  3),
  (10,  2),( 8,  1),( 6,  0),( 4, -1),( 2, -2),

  -- 11s: TTC < 2 — debe estar en modo manual para evitar desvío
  ( 5,  5),( 5,  4),( 4,  3),( 3,  2),( 3,  1),
  ( 2,  0),( 1, -1),( 1, -1),( 2,  0),( 2,  1),

  -- 12s: Recuperación tras riesgo
  ( 0,  0),( 1,  1),( 2,  1),( 2,  0),( 1, -1),
  ( 0, -1),( 0,  0),( 1,  1),( 2,  2),( 3,  2),

  -- 13s: Modo manual activo
  (-5,  3),(-5,  3),(-4,  2),(-3,  2),(-3,  2),
  (-4,  1),(-5,  0),(-5, -1),(-4, -1),(-3,  0),

  -- 14s: Modo manual continúa
  (-7,  2),(-7,  2),(-8,  1),(-8,  0),(-8, -1),
  (-7, -2),(-6, -2),(-6, -1),(-5,  0),(-4,  1),

  -- 15s: Modo manual estable
  (-3,  2),(-3,  2),(-2,  1),(-2,  0),(-2, -1),
  (-1, -1),( 0,  0),( 0,  1),( 1,  1),( 2,  1),

  -- 16s: Recuperación
  ( 3,  1),( 3,  1),( 3,  2),( 4,  2),( 5,  2),
  ( 5,  1),( 5,  0),( 4,  0),( 3,  0),( 2,  0),

  -- 17s: Estable
  ( 1,  1),( 1,  1),( 1,  2),( 2,  2),( 2,  1),
  ( 1,  0),( 1, -1),( 1, -1),( 2,  0),( 2,  1),

  -- 18s: Estable
  ( 1,  3),( 1,  3),( 2,  1),( 3,  0),( 1, -3),
  ( 1,  3),( 1,  3),( 2,  1),( 3,  0),( 1, -3),

  -- 19s: Estable
  ( 1,  3),( 1,  3),( 2,  1),( 3,  0),( 1, -3),
  ( 1,  3),( 1,  3),( 2,  1),( 3,  0),( 1, -3),

  -- 20s: Estable final
  ( 1,  3),( 1,  3),( 2,  1),( 3,  0),( 1, -3),
  ( 1,  3),( 1,  3),( 2,  1),( 3,  0),( 1, -3)
);
                 
    ---------------------------------------------------------------------
    ------ POWER OK------------------------------------------------------
    cantidad_datos_Power: constant := 200;
    type Indice_Secuencia_Power is mod cantidad_datos_Power;
    type tipo_Secuencia_Power is array (Indice_Secuencia_Power) of Power_Samples_Type;

    Power_Simulation: tipo_Secuencia_Power :=  -- 1 muestra cada 100ms.
(
  -- 1s: normal
  800,800,800,800,800, 800,800,800,800,800,

  -- 2s: normal
  800,800,800,800,800, 800,800,800,800,800,

  -- 3s: inicio descenso (LUZ 2 off)
  800,800,800,800,800, 700,700,700,700,700,

  -- 4s: power baja → velocidad baja → LUZ 2 ON
  600,600,600,600,600, 600,600,600,600,600,

  -- 5s: power más baja aún → LUZ 2 ON
  500,500,500,500,500, 500,500,500,500,500,

  -- 6s: salto brusco → velocidad alta → LUZ 2 ON
  900,900,900,900,900, 900,900,900,900,900,

  -- 7s: muy alta
  950,950,950,950,950, 950,950,950,950,950,

  -- 8s: máxima estable permitida → LUZ 2 ON
  1000,1000,1000,1000,1000, 1000,1000,1000,1000,1000,

  -- 9s: mantenemos el máximo (evitando 1020 que es ilegal)
  1000,1000,1000,1000,1000, 1000,1000,1000,1000,1000,

  -- 10s: mantenemos alta (LUZ 2 ON)
  900,900,900,900,900, 900,900,900,900,900,

  -- 11s: recuperación
  800,800,800,800,800, 800,800,800,800,800,

  -- 12s: estable sin luz
  800,800,800,800,800, 800,800,800,800,800,

  -- 13s: estable sin luz
  800,800,800,800,800, 800,800,800,800,800,

  -- 14s: estable sin luz
  800,800,800,800,800, 800,800,800,800,800,

  -- 15s: estable sin luz
  800,800,800,800,800, 800,800,800,800,800,

  -- 16s: subidita breve → LUZ 2 ON
  900,900,900,900,900, 900,900,900,900,900,

  -- 17s: variación que alterna luz ON/OFF
  900,900,900,900,900, 700,500,400,300,300,

  -- 18s: power muy baja → LUZ 2 ON fuerte
  200,200,200,200,200, 150,150,150,150,150,

  -- 19s: valores muy bajos pero dentro de rango
  200,200,200,200,180, 180,180,150,150,150,

  -- 20s: recuperación final
  800,800,800,800,800, 800,800,800,800,800
);


    ---------------------------------------------------------------------
    ------ PILOT'S PRESENCE ---------------------------------------------

    cantidad_datos_PilotPresence: constant := 200;
    type Indice_Secuencia_PilotPresence is mod cantidad_datos_PilotPresence;
    type tipo_Secuencia_PilotPresence is array (Indice_Secuencia_PilotPresence) of PilotPresence_Samples_Type;

    PilotPresence_Simulation: tipo_Secuencia_PilotPresence :=  -- 1 muestra cada 100ms.
(
  -- 1s: piloto presente
  1,1,1,1,1, 1,1,1,1,1,
  -- 2s: piloto presente
  1,1,1,1,1, 1,1,1,1,1,
  -- 3s: piloto presente
  1,1,1,1,1, 1,1,1,1,1,
  -- 4s: primeras ausencias breves
  1,1,1,0,1, 1,0,1,1,1,
  -- 5s: presencia estable
  1,1,1,1,1, 1,1,1,1,1,
  -- 6s: presencia estable
  1,1,1,1,1, 1,1,1,1,1,
  -- 7s: ausencias breves
  1,0,1,0,1, 1,1,1,1,1,
  -- 8s: visibilidad baja → mantenemos piloto presente para aislar efecto
  1,1,1,1,1, 1,1,1,1,1,
  -- 9s: piloto ausente → activa alarmas anticipadas
  0,0,0,0,0, 0,0,0,0,0,
  -- 10s: piloto ausente → desvío automático anticipado
  0,0,0,0,0, 0,0,0,0,0,
  -- 11s: mantenemos ausencia → TTC extremadamente bajo + ausencia
  0,0,0,0,0, 0,0,0,0,0,
  -- 12s: recuperación → piloto presente
  1,1,1,1,1, 1,1,1,1,1,
  -- 13s: presente
  1,1,1,1,1, 1,1,1,1,1,
  -- 14s: presente
  1,1,1,1,1, 1,1,1,1,1,
  -- 15s: pequeñas ausencias para probar robustez
  1,1,0,1,0, 1,1,1,1,1,
  -- 16s: presente
  1,1,1,1,1, 1,1,1,1,1,
  -- 17s: presente
  1,1,1,1,1, 1,1,1,1,1,
  -- 18s: presente
  1,1,1,1,1, 1,1,1,1,1,
  -- 19s: presente
  1,1,1,1,1, 1,1,1,1,1,
  -- 20s: presente
  1,1,1,1,1, 1,1,1,1,1
);
                   
    ---------------------------------------------------------------------
    ------ PILOT'S BUTTON -----------------------------------------------

    cantidad_datos_PilotButton: constant := 200;
    type Indice_Secuencia_PilotButton is mod cantidad_datos_PilotButton;
    type tipo_Secuencia_PilotButton is array (Indice_Secuencia_PilotButton) of PilotButton_Samples_Type;

    PilotButton_Simulation: tipo_Secuencia_PilotButton :=  -- 1 muestra cada 100ms.
(
  -- 1s: Automático (sin pulsaciones)
  0,0,0,0,0, 0,0,0,0,0,
  -- 2s: Un pulso ligero → cambia a MANUAL (0→1)
  0,0,0,0,0, 1,0,0,0,0,
  -- 3s: Volvemos a AUTOMÁTICO (otra pulsación 0→1)
  0,0,0,0,0, 1,0,0,0,0,
  -- 4s: Automático (estable)
  0,0,0,0,0, 0,0,0,0,0,
  -- 5s: Pulsos aislados pero que NO cambian de modo (evitamos 0→1)
  1,1,1,1,0, 0,0,0,0,0,
  -- 6s: Automático (TTC < 15)
  0,0,0,0,0, 0,0,0,0,0,
  -- 7s: Automático (TTC < 10 — debe permitir desvío)
  0,0,0,0,0, 0,0,0,0,0,
  -- 8s: Automático (baja visibilidad)
  0,0,0,0,0, 0,0,0,0,0,
  -- 9s: Automático (piloto ausente)
  0,0,0,0,0, 0,0,0,0,0,
  -- 10s:  CAMBIO A MANUAL justo antes del TTC ultra bajo
  1,1,1,1,1, 1,1,1,1,1,
  -- 11s: Modo manual sostenido → NO debe ejecutarse desvío automático
  1,1,1,1,1, 1,1,1,1,1,
  -- 12s:  Volvemos a AUTOMÁTICO (pulso 0→1)
  0,0,0,0,0, 1,0,0,0,0,
  -- 13s: Automático estable
  0,0,0,0,0, 0,0,0,0,0,
  -- 14s: Automático estable
  0,0,0,0,0, 0,0,0,0,0,
  -- 15s: Automático estable
  0,0,0,0,0, 0,0,0,0,0,
  -- 16s: Automático estable
  0,0,0,0,0, 0,0,0,0,0,
  -- 17s: Automático estable
  0,0,0,0,0, 0,0,0,0,0,
  -- 18s: Automático estable
  0,0,0,0,0, 0,0,0,0,0,
  -- 19s: Automático estable
  0,0,0,0,0, 0,0,0,0,0,
  -- 20s: Automático estable
  0,0,0,0,0, 0,0,0,0,0
);

end Testing_1;


