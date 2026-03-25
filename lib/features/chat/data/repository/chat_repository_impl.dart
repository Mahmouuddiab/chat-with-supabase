import 'package:injectable/injectable.dart';
import 'package:supa_chat/features/chat/domain/entity/message_etity.dart';
import 'package:supa_chat/features/chat/domain/repository/chat_repository.dart';
import '../data source/chat_remote_ds.dart';

@Injectable(as: ChatRepository)
class ChatRepositoryImpl implements ChatRepository {
  final ChatRemoteDs remote;

  ChatRepositoryImpl(this.remote);

  @override
  Stream<List<MessageEntity>> getMessages(
      String myId, String receiverId) {
    return remote.getMessages(myId, receiverId);
  }

  @override
  Future<void> sendMessage(
      String receiverId, String message) {
    return remote.sendMessage(receiverId, message);
  }

  @override
  Stream<bool> getUserOnlineStatus(String userId) {
    return remote.getOnlineStatus(userId);
  }
}