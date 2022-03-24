%% @hidden
-module(on_register_hook).
-include("vernemq_dev.hrl").

%% called as an 'all' hook, return value is ignored
-callback on_register(Peer              :: peer(),
                      SubscriberId      :: subscriber_id(),
                      UserName          :: username(),
                      UserProperties    :: properties()) -> any().
