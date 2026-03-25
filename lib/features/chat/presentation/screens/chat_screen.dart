import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supa_chat/core/di/di.dart';
import 'package:supa_chat/features/chat/presentation/cubit/chat_cubit.dart';
import 'package:supa_chat/features/chat/presentation/cubit/chat_state.dart';
import 'package:supa_chat/features/chat/presentation/widgets/chat_app_bar.dart';
import 'package:supa_chat/features/chat/presentation/widgets/chat_input.dart';
import 'package:supa_chat/features/chat/presentation/widgets/message_bubble.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ChatScreen extends StatefulWidget {
  final String receiverId;
  final String receiverName;

  const ChatScreen({
    super.key,
    required this.receiverId,
    required this.receiverName,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final ScrollController scrollController = ScrollController();
  var cubit = getIt<ChatCubit>();
  late String myId;

  @override
  void initState() {
    super.initState();

    myId = Supabase.instance.client.auth.currentUser!.id;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final cubit = context.read<ChatCubit>();
      cubit.listen(myId, widget.receiverId);
      cubit.listenToOnlineStatus(widget.receiverId);
    });
  }

  void scrollToBottom() {
    if (scrollController.hasClients) {
      scrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ChatCubit>();

    return Scaffold(
      appBar: ChatAppBar(
        receiverName: widget.receiverName,
        cubit: cubit,
      ),
      body: Column(
        children: [
          /// Messages
          Expanded(
            child: BlocConsumer<ChatCubit, ChatState>(
              bloc: cubit,
              listener: (context, state) {
                if (state is ChatLoaded) {
                  scrollToBottom();
                }
              },
              builder: (context, state) {
                if (state is ChatLoaded) {
                  return ListView.builder(
                    controller: scrollController,
                    reverse: true,
                    padding: const EdgeInsets.all(10),
                    itemCount: state.messages.length,
                    itemBuilder: (context, index) {
                      final msg = state.messages[index];

                      return MessageBubble(
                        message: msg,
                        isMe: msg.senderId == myId,
                      );
                    },
                  );
                }

                return const Center(child: CircularProgressIndicator());
              },
            ),
          ),

          /// Input
          ChatInput(
            onSend: (text) {
              context.read<ChatCubit>().send(widget.receiverId, text);
            },
          ),
        ],
      ),
    );
  }
}