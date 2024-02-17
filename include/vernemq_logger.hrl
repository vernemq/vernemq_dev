-ifndef(VERNEMQ_LOGGER_HRL).
-define(VERNEMQ_LOGGER_HRL, true).

-include_lib("kernel/include/logger.hrl").

-define(LOG_IF(Level, Condition, Format, Args),
    (Condition) == true andalso ?LOG(Level, Format, Args)).

-define(DEBUG_MSG(Format, Args),
    ?LOG_DEBUG(Format, Args)).

-define(INFO_MSG(Format, Args),
    ?LOG_INFO(Format, Args)).

-define(WARNING_MSG(Format, Args),
    ?LOG_WARNING(Format, Args)).

-define(ERROR_MSG(Format, Args),
    ?LOG_ERROR(Format, Args)).

-define(CRITICAL_MSG(Format, Args),
    ?LOG_CRITICAL(Format, Args)).

-endif.
