HashMap<String, boolean[]> prog_param_map = new HashMap<String, boolean[]>();

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
  boolean[] _bl1 = {false, false, false, false};
  prog_param_map.put("None", _bl1);
  boolean[] _bl2 = {true, false, false, false};
  prog_param_map.put("Fill COPV", _bl2);
  boolean[] _bl3 = {true, true, false, false};
  prog_param_map.put("Pre Pressurize", _bl3);
  boolean[] _bl4 = {true, true, true, true};
  prog_param_map.put("Fill N2O", _bl4);
  boolean[] _bl5 = {true, true, false, false};
  prog_param_map.put("Post Pressurize", _bl5);
}

enum FillingProgram {
  FILL_PROGRAM_NONE,
  FILL_PROGRAM_COPV,
  FILL_PROGRAM_N_PRE,
  FILL_PROGRAM_N2O,
  FILL_PROGRAM_N_POST,
};
