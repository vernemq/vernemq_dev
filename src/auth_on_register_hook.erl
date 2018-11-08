%% @hidden
-module(auth_on_register_hook).
-include("vernemq_dev.hrl").

%% called as an all_till_ok hook
-callback auth_on_register(Peer          :: peer(),
                           SubscriberId  :: subscriber_id(),
                           UserName      :: username(),
                           Password      :: password(),
                           CleanSession  :: flag()) -> ok
                                                           | {ok, [reg_modifiers()]}
                                                           | {error, invalid_credentials | any()}
                                                           | next.
-type reg_modifiers()   ::
        %% Change the mountpoint for the session.
        {mountpoint, mountpoint()}

        %% Change the if the session should be clean or not.
      | {clean_session, flag()}

        %% Set the maximum message size the client is allowed to
        %% publish.
      | {max_message_size, non_neg_integer()}

        %% Override the global shared subscription policy for this
        %% session.
      | {shared_subscription_policy, shared_sub_policy()}

        %% Override the global maximum number of online messages for
        %% this session.
      | {max_online_messages, non_neg_integer()}

        %% Override the global maximum number of offline messages
        %% for this session.
      | {max_offline_messages, non_neg_integer()}.

-export_type([reg_modifiers/0]).
