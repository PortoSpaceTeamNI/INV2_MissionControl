

class RocketData {
  byte state = 0;
  boolean flash_running;
  class Valves {
    boolean purge_top,
      purge_bot,
      chamber;
  }
  class Tank {
    short pressure_top,
      pressure_bot,
      temp_top,
      temp_bot;
  }
  short chamber_pressure;
  class GPS {
    byte satellite_count;
    short altitude;
    float latitude,
      longitude;
    short horizontal_velocity;
  }
  short barometer_altitude;
  class IMU {
    short accel_x,
      accel_y,
      accel_z,
      gyro_x,
      gyro_y,
      gyro_z,
      mag_x,
      mag_y,
      mag_z;
  }
  class Kalman {
    short altitude,
      max_altitude,
      vel_z,
      acel_z;
    int q1,
      q2,
      q3,
      q4;
  }
  class Parachute {
    short main_ematch,
      drogue_ematch;
  }

  // initializations
  Valves valves = new Valves();
  Tank tank = new Tank();
  GPS gps = new GPS();
  IMU imu = new IMU();
  Kalman kalman = new Kalman();
  Parachute parachute = new Parachute();

  String getState() {
    return StateRocket.values()[state].toString();
  }
  AskData[] man_ask = {
    AskData.rocket_flags_state,
    AskData.tank_pressures,
    AskData.tank_temps,
    AskData.gps_data,
    AskData.barometer_altitude,
    AskData.imu_data,
    AskData.kalman_data,
    AskData.parachutes_ematches
  };
  AskData[] fill_ask = {
    AskData.rocket_flags_state,
    AskData.tank_pressures,
    AskData.tank_temps,
  };
  AskData[] launch_ask = {
    AskData.rocket_flags_state,
    AskData.tank_pressures,
    AskData.gps_data,
    AskData.kalman_data,
    AskData.parachutes_ematches,
  };
}

class FillingData {
  byte state = 0;
  boolean flash_running;
  class He {
    short pressure,
      temperature;
    boolean valve;
  }
  class N2O {
    short pressure,
      temperature,
      loadcell;
    boolean valve;
  }
  class Line {
    short pressure,
      temperature;
    boolean valve;
  }
  short rs_press;
  String getState() {
    return StateFilling.values()[state].toString();
  }

  AskData[] man_ask = {
    AskData.fill_station_state,
    AskData.fill_pressures,
    AskData.fill_temps,
    AskData.nitro_loadcell,
  };

  AskData[] fill_ask = {
    AskData.fill_station_state,
    AskData.fill_pressures,
    AskData.fill_temps,
    AskData.nitro_loadcell,
  };

  AskData[] launch_ask = new AskData[0];

  // initializations
  He he = new He();
  N2O n2o = new N2O();
  Line line = new Line();
}

class IgnitionData {
  byte state = 0;
  short chamber_trigger_temp;
  short main_ematch;

  String getState() {
    return StateIgnition.values()[state].toString();
  }

  AskData[] man_ask = {
    AskData.ignition_station_state,
    AskData.chamber_trigger_temp,
    AskData.main_ematch,
  };

  AskData[] fill_ask = new AskData[0];

  AskData[] launch_ask = {
    AskData.ignition_station_state,
    AskData.chamber_trigger_temp,
    AskData.main_ematch,
  };
}

RocketData rocket_data;
FillingData filling_data;
IgnitionData ignition_data;

void init_data_objects() {
  rocket_data = new RocketData();
  filling_data = new FillingData();
  ignition_data = new IgnitionData();
}
