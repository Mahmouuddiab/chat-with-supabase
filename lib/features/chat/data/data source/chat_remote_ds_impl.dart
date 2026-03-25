import 'package:injectable/injectable.dart';
import 'package:supa_chat/features/chat/data/models/message_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'chat_remote_ds.dart';

@LazySingleton(as: ChatRemoteDs)
class ChatRemoteDsImpl implements ChatRemoteDs {
  final SupabaseClient client;

  ChatRemoteDsImpl(this.client);

  @override
  Stream<List<MessageModel>> getMessages(
      String myId, String receiverId) {
    return client
        .from('messages')
        .stream(primaryKey: ['id'])
        .order('created_at', ascending: false)
        .map((data) {
      return data
          .map((e) => MessageModel.fromJson(e))
          .where((msg) =>
      (msg.senderId == myId &&
          msg.receiverId == receiverId) ||
          (msg.senderId == receiverId &&
              msg.receiverId == myId))
          .toList();
    });
  }

  @override
  Future<void> sendMessage(
      String receiverId, String message) async {
    final user = client.auth.currentUser;

    await client.from('messages').insert({
      'sender_id': user!.id,
      'receiver_id': receiverId,
      'message': message,
    });
  }

  @override
  Stream<bool> getOnlineStatus(String userId) {
    return client
        .from('users')
        .stream(primaryKey: ['id'])
        .map((data) {
      final user = data.firstWhere(
            (e) => e['id'] == userId,
        orElse: () => {},
      );
      return user['is_online'] ?? false;
    });
  }
}