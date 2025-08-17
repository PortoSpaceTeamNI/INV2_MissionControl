enum RocketState {
  IDLE,
  FILLING,
  READY, //-> fuel ok, system ok, can arm 
  ARMED, // -> ready for launch (can trigger e-matches)
  FLIGHT,
  ABORT, //-> fuelling and flight aborted 
};

enum FillingState {
 // TODO: add filling sub states
};

enum FlightState {
    LAUNCH, // -> e-maches triggered
    ASCEND, // -> in flight
    APOGEE, // -> apogee detected
    DROGUE_CHUTE, // -> drogue chute open
    MAIN_CHUTE, // -> main chute open
    TOUCHDOWN, // -> landed
};
