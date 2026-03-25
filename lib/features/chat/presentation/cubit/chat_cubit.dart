import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:supa_chat/features/chat/domain/usecase/get_message.dart';
import 'package:supa_chat/features/chat/domain/usecase/online_status.dart';
import 'package:supa_chat/features/chat/domain/usecase/send_message.dart';
import 'package:supa_chat/features/chat/presentation/cubit/chat_state.dart';

@injectable
class ChatCubit extends Cubit<ChatState> {
  final GetMessagesUseCase getMessages;
  final SendMessageUseCase sendMessage;
  final GetOnlineStatusUseCase getOnlineStatusUseCase;

  ChatCubit(
      this.getMessages,
      this.sendMessage,
      this.getOnlineStatusUseCase,
      ) : super(ChatInitial());

  StreamSubscription? _messagesSubscription;
  StreamSubscription? _onlineSubscription;

  Stream<bool>? onlineStream;

  void listen(String myId, String receiverId) {
    _messagesSubscription?.cancel();

    _messagesSubscription =
        getMessages(myId, receiverId).listen((messages) {
          emit(ChatLoaded(List.from(messages))); // ✅ new reference
        });
  }

  Future<void> send(String receiverId, String message) async {
    await sendMessage(receiverId, message);
  }

  void listenToOnlineStatus(String userId) {
    onlineStream = getOnlineStatusUseCase(userId);

    _onlineSubscription?.cancel();
    _onlineSubscription = onlineStream!.listen((status) {
      emit(OnlineStatusUpdated(status));
    });
  }

  @override
  Future<void> close() {
    _messagesSubscription?.cancel();
    _onlineSubscription?.cancel();
    return super.close();
  }
}