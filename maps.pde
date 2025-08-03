HashMap<Integer, String> ack_map = new HashMap<Integer, String>();

enum StateRocket {
  IDLE,

    FUELING,
    MANUAL,

    SAFETY_PRESSURE,
    PURGE_PRESSURE,
    PURGE_LIQUID,

    SAFETY_PRESSURE_ACTIVE,

    READY,
    ARMED,
    LAUNCH,

    ABORT,

    FLIGHT,

    RECOVERY,

    state_count, //this needs to be the last state for size to work
}

enum StateFilling {
  IDLE,
    FUELING,
    MANUAL,

    FILL_He,
    FILL_N2O,
    PURGE_LINE,

    STOP,
    ABORT,

    READY,
    ARMED,
    FIRE,
    LAUNCH,

    state_count, //this needs to be the last state for size to work
}

enum StateIgnition {
  IDLE,
    FUELING,
    MANUAL,

    FILL_He,
    FILL_N2O,
    PURGE_LINE,

    STOP,
    ABORT,

    READY,
    ARMED,
    FIRE,
    LAUNCH,

    state_count, //this needs to be the last state for size to work
};

enum ManCommand {
  FLASH_LOG_START,
    FLASH_LOG_STOP,
    FLASH_IDS,
    FLASH_DUMP,

    VALVE_STATE,
    VALVE_MS,

    IMU_CALIBRATE,
    BAROMETER_CALIBRATE,
    KALMAN_CALIBRATE,

    LOADCELL_CALIBRATE,
    LOADCELL_TARE,

    TANK_TARE,

    manual_cmd_size,

    FLASH_LOG_START_ACK,
    FLASH_LOG_STOP_ACK,
    FLASH_IDS_ACK,
    FLASH_DUMP_ACK,
    VALVE_STATE_ACK,
    VALVE_MS_ACK,
    IMU_CALIBRATE_ACK,
    BAROMETER_CALIBRATE_ACK,
    KALMAN_CALIBRATE_ACK,
    LOADCELL_CALIBRATE_ACK,
    LOADCELL_TARE_ACK,
    TANK_TARE_ACK,
}

enum ValveToggle {
  TANK_TOP,
    TANK_BOTTOM,
    MAIN,
    N2O,
    HE,
    LINE_PURGE,
}

enum Command {
  //shared commands
  LOG,
    STATUS,
    ABORT,
    EXEC_PROG,
    STOP_PROG,
    FUELING,
    MANUAL,
    MANUAL_EXEC,
    READY,
    ARM,

    //FLIGHT computer commands
    ALLOW_LAUNCH,

    //FILLING station commands
    RESUME_PROG,
    FIRE_PYRO,

    //used to get the number of commands
    size,

    //ACKs
    STATUS_ACK,
    LOG_ACK,
    ABORT_ACK,
    EXEC_PROG_ACK,
    STOP_PROG_ACK,
    FUELING_ACK,
    MANUAL_ACK,
    MANUAL_EXEC_ACK,
    READY_ACK,
    ARM_ACK,
    ALLOW_LAUNCH_ACK,
    RESUME_PROG_ACK,
    FIRE_PYRO_ACK,
}

void maps() {
  boolean[] _bl1 = {true, true, false};
  prog_args.put("Safety Pressure", _bl1);
  boolean[] _bl2 = {true, true, false};
  prog_args.put("Purge Pressure", _bl2);
  boolean[] _bl3 = {false, false, true};
  prog_args.put("Purge Liquid", _bl3);
  boolean[] _bl4 = {true, false, false};
  prog_args.put("Fill He", _bl4);
  boolean[] _bl5 = {false, true, false};
  prog_args.put("Fill N2O", _bl5);
  boolean[] _bl6 = {true, false, false};
  prog_args.put("Purge Line", _bl6);

  ack_map.put(Command.LOG.ordinal(), "LOG_ACK");
  ack_map.put(Command.STATUS.ordinal(), "STATUS_ACK");
  ack_map.put(Command.ABORT.ordinal(), "ABORT_ACK");
  ack_map.put(Command.EXEC_PROG.ordinal(), "EXEC_PROG_ACK");
  ack_map.put(Command.STOP_PROG.ordinal(), "STOP_PROG_ACK");
  ack_map.put(Command.FUELING.ordinal(), "FUELING_ACK");
  ack_map.put(Command.MANUAL.ordinal(), "MANUAL_ACK");
  ack_map.put(Command.MANUAL_EXEC.ordinal(), "MANUAL_EXEC_ACK");
  ack_map.put(Command.READY.ordinal(), "READY_ACK");
  ack_map.put(Command.ARM.ordinal(), "ARM_ACK");
  ack_map.put(Command.ALLOW_LAUNCH.ordinal(), "ALLOW_LAUNCH_ACK");
  ack_map.put(Command.RESUME_PROG.ordinal(), "RESUME_PROG_ACK");
  ack_map.put(Command.FIRE_PYRO.ordinal(), "FIRE_PYRO_ACK");
}

enum FillingProgram {
  SAFETY_PRESSURE_PROG,
    PURGE_PRESSURE_PROG,
    PURGE_LIQUID_PROG,
    FILL_He_PROG,
    FILL_N2O_PROG,
    PURGE_LINE_PROG,
};
