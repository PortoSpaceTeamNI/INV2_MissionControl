HashMap<String, boolean[]> prog_args = new HashMap<String, boolean[]>();

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



enum ValveToggle {
  TANK_TOP,
    TANK_BOTTOM,
    MAIN,
    N2O,
    HE,
    LINE_PURGE,
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
}

enum FillingProgram {
  FILL_PROGRAM_NONE,
  FILL_PROGRAM_COPV,
  FILL_PROGRAM_N_PRE,
  FILL_PROGRAM_N2O,
  FILL_PROGRAM_N_POST,
};
