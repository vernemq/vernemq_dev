%% @hidden
-module(on_deliver_hook).
-include("vernemq_dev.hrl").

-callback on_deliver(UserName      :: username(),
                     SubscriberId  :: subscriber_id(),
                     QoS           :: qos(),
                     Topic         :: topic(),
                     Payload       :: payload(),
                     IsRetain      :: flag()) -> ok
                                                 | {ok, Payload    :: payload()}
                                                 | {ok, Modifiers  :: [msg_modifier()]}
                                                 | next.

-type msg_modifier() ::
        %% Rewrite the topic of the message.
        {topic, topic()}

        %% Rewrite the payload of the message.
      | {payload, payload()}

        %% Rewrite the QoS of the message.
      | {qos, qos()}

        %% Rewrite the retain flag of the message.
      | {retain, flag()}.


-export_type([msg_modifier/0]).
