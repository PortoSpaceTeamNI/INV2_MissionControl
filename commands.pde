enum Command {
    NONE,
    STOP,
    STATUS_REQ,
    STATUS_REP,
    ABORT,
    READY,
    ARM,
    FIRE,
    LAUNCH_OVERRIDE,
    FILL_EXEC,
    FILL_RESUME,
    MANUAL_ENABLE,
    MANUAL_EXEC,
    ACK
};

enum ManCommand {
    SD_LOG_START,
    SD_LOG_STOP,
    SD_STATUS,
    VALVE_STATE,
    VALVE_MS,
    LOADCELL_TARE,
    TANK_TARE, // (?)
    ACK
};
