%% @hidden
-module(on_message_drop_hook).
-include("vernemq_dev.hrl").

%% called as an 'all'-hook, return value is ignored
-callback on_message_drop(SubscriberId  :: subscriber_id(),
                          Promise       :: fun(() -> {topic(), qos(), payload(), map()} | error),
                          Reason        :: expired
                                         | queue_full
                                         | max_packet_size_exceeded) -> any().
