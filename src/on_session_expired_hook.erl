%% @hidden
-module(on_session_expired_hook).
-include("vernemq_dev.hrl").

%% called as an 'all' hook, return value is ignored
-callback on_session_expired(SubscriberId  :: subscriber_id()) -> any().
