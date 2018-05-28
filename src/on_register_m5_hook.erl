-module(on_register_m5_hook).
-include("vernemq_dev.hrl").

%% called as an 'all' hook, return value is ignored
-callback on_register_m5(Peer          :: peer(),
                         SubscriberId  :: subscriber_id(),
                         UserName      :: username(),
                         Properties    :: properties()) -> any().
