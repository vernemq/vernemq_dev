%% @hidden
-module(on_deliver_hook).
-include("vernemq_dev.hrl").

-callback on_deliver(UserName      :: username(),
                     SubscriberId  :: subscriber_id(),
                     Topic         :: topic(),
                     Payload       :: payload()) -> ok
                                                    | {ok, Payload    :: payload()}
                                                    | {ok, Modifiers  :: [msg_modifier()]}
                                                    | next.

-type msg_modifier() ::
        %% Rewrite the topic of the message.
        {topic, topic()}

        %% Rewrite the payload of the message.
      | {payload, payload()}.


-export_type([msg_modifier/0]).
