import 'package:injectable/injectable.dart';
import 'package:supa_chat/features/chat/domain/repository/chat_repository.dart';

@injectable
class SendMessageUseCase {
  final ChatRepository repo;
  SendMessageUseCase(this.repo);

  Future<void> call(String receiverId, String message) {
    return repo.sendMessage(receiverId, message);
  }
}