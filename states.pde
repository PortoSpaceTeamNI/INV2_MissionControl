enum State {
    IDLE,
    FILLING,
    SAFE_IDLE,
    FILLING_N2,
    PRE_PRESSURE,
    FILLING_N2O,
    POST_PRESSURE,
    READY,
    ARMED,
    IGNITION,
    LAUNCH,
    FLIGHT,
    RECOVERY,
    ABORT,
    state_count, //this needs to be the last state for size to work
};
