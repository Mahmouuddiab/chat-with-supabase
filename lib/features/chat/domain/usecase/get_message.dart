import 'package:injectable/injectable.dart';
import 'package:supa_chat/features/chat/domain/entity/message_etity.dart';
import 'package:supa_chat/features/chat/domain/repository/chat_repository.dart';

@injectable
class GetMessagesUseCase {
  final ChatRepository repo;
  GetMessagesUseCase(this.repo);

  Stream<List<MessageEntity>> call(
      String myId, String receiverId) {
    return repo.getMessages(myId, receiverId);
  }
}