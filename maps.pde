HashMap<String, boolean[]> prog_param_map = new HashMap<String, boolean[]>();

enum RocketState {
    IDLE,
    ABORT,
    FILL_N2,
    PRE_PRESSURIZE,
    FILL_OX,
    POST_PRESSURIZE,
    ARMED,
    IGNITION,
    LAUNCH,
    BOOST,
    COAST,
    DROGUE_DESCENT,
    MAIN_DESCENT,
    TOUCHDOWN,
    _STATE_COUNT,
}

enum ValveToggle {
  PRESSURIZING_TOGGLE, 
  VENT_TOGGLE, 
  ABORT_TOGGLE, 
  MAIN_TOGGLE, 
  N2O_FILL_TOGGLE, 
  N2O_PURGE_TOGGLE, 
  N2_FILL_TOGGLE, 
  N2_PURGE_TOGGLE, 
  N2O_QUICK_DC_TOGGLE,
  N2_QUICK_DC_TOGGLE, 
  
}

void maps() {
  boolean[] _bl1 = {false, false, false, false, false};
  prog_param_map.put("None", _bl1);
  boolean[] _bl2 = {true, true, true, true, false};
  prog_param_map.put("Safe Idle", _bl2);
  boolean[] _bl3 = {true, true, false, false, false};
  prog_param_map.put("Fill N2", _bl3);
  boolean[] _bl4 = {true, true, false, false, false};
  prog_param_map.put("Pre Pressurize", _bl4);
  boolean[] _bl5 = {true, true, true, true, true};
  prog_param_map.put("Fill N2O", _bl5);
  boolean[] _bl6 = {true, true, false, false, false};
  prog_param_map.put("Post Pressurize", _bl6);
}

enum FillingProgram {
  FILL_PROGRAM_NONE,
  FILL_PROGRAM_N2,
  FILL_PROGRAM_N_PRE,
  FILL_PROGRAM_N2O,
  FILL_PROGRAM_N_POST,
};
