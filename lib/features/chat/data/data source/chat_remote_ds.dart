import 'package:supa_chat/features/chat/data/models/message_model.dart';

abstract class ChatRemoteDs {
  Stream<List<MessageModel>> getMessages(
      String myId, String receiverId);

  Future<void> sendMessage(
      String receiverId, String message);

  Stream<bool> getOnlineStatus(String userId);
}