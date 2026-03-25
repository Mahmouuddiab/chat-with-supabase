import 'package:supa_chat/features/chat/domain/entity/message_etity.dart';

abstract class ChatRepository {
  Stream<List<MessageEntity>> getMessages(String myId, String receiverId);

  Future<void> sendMessage(String receiverId, String message);

  Stream<bool> getUserOnlineStatus(String userId);
}