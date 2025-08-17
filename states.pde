enum RocketState {
  IDLE,
  FILLING,
  READY, //-> fuel ok, system ok, can arm 
  ARMED, // -> ready for launch (can trigger e-matches)
  FLIGHT,
  ABORT, //-> fuelling and flight aborted 
};

enum RocketSubState {
    NONE,
    FILLING_COPV,
    PRE_PRESSURIZING,
    FILLING_N2O,
    POST_PRESSURIZING,
    LAUNCH, // -> e-maches triggered
    ASCEND, // -> in flight
    APOGEE, // -> apogee detected
    DROGUE_CHUTE, // -> drogue chute open
    MAIN_CHUTE, // -> main chute open
    TOUCHDOWN, // -> landed
};
