enum Command {
    NONE,
    STATUS,
    ABORT,
    STOP,
    ARM,
    FIRE,
    FILL_EXEC,
    MANUAL_EXEC,
    ACK,
    NACK,  
    count
};

enum ManCommand {
    SD_LOG_START,
    SD_LOG_STOP,
    SD_STATUS,
    VALVE_STATE,
    VALVE_MS,
    count
};
