 class OBC {
   RocketState state = RocketState.IDLE;
   RocketSubState substate = RocketSubState.NONE;
   boolean sd_logging;
 };
 
 class HYDRA_UF {
   boolean vent_valve, pressurizing_valve;
   short probe_thermo1, probe_thermo2;
 };
 
 class HYDRA_LF {
   boolean main_valve, abort_valve;
   short probe_thermo1, probe_thermo2, probe_thermo3, chamber_temperature;
   short tank_pressure, chamber_pressure;
 };
 
 class HYDRA_FS {
   class N2 {
     boolean fill_valve, purge_valve;
     short pressure;
   };
   
   class N2O {
     boolean fill_valve, purge_valve;
     short temperature, pressure;
   };
   
   class QUICK_DC {
     boolean n2_valve, n2o_valve;
     short pressure;
   };
   
   N2 n2 = new N2();
   N2O n2o = new N2O();
   QUICK_DC quick_dc = new QUICK_DC();
 };
 
 class NAVIGATOR {
   class GPS {
     float latitude, longitude;
     byte sat_count;
     short altitude, horizontal_velocity;
   };
   
   class Kalman {
     short velocity_z, acceleration_z, altitude, max_altitude;
     short q1, q2, q3, q4; // quaternions
   };
   
   class IMU {
     short accel_x, accel_y, accel_z;
     short gyro_x, gyro_y, gyro_z;
     short mag_x, mag_y, mag_z;
   }
   
   short barometer_alt1, barometer_alt2;
   
   GPS gps = new GPS();
   Kalman kalman = new Kalman();
   IMU imu = new IMU();
 };
 
 class ELYTRA {
   boolean main_chute_ematch, drogue_chute_ematch;
 };
 
 class LIFT_R {
   short loadcell1, loadcell2, loadcell3;
   boolean main_ematch;
 };
 
 class LIFT_FS {
   short n2o_loadcell;
 };

OBC obc;
HYDRA_UF hydra_uf;
HYDRA_LF hydra_lf;
HYDRA_FS hydra_fs;
NAVIGATOR nav;
ELYTRA elytra;
LIFT_R lift_r;
LIFT_FS lift_fs;

void init_data_objects() {
  obc = new OBC();
  hydra_uf = new HYDRA_UF();
  hydra_lf = new HYDRA_LF();
  hydra_fs = new HYDRA_FS();
  nav = new NAVIGATOR();
  elytra = new ELYTRA();
  lift_r = new LIFT_R();
  lift_fs = new LIFT_FS();
}
