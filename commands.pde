enum Command {
    NONE,
    STATUS,
    ABORT,
    STOP,
    READY,
    ARM,
    FIRE,
    LAUNCH_OVERRIDE,
    FILL_EXEC,
    FILL_RESUME,
    MANUAL_EXEC,
    ACK,
};

enum ManCommand {
    SD_LOG_START,
    SD_LOG_STOP,
    SD_STATUS,
    VALVE_STATE,
    VALVE_MS,
    ACK
};
