import 'package:injectable/injectable.dart';
import 'package:supa_chat/features/chat/domain/repository/chat_repository.dart';

@injectable
class GetOnlineStatusUseCase {
  final ChatRepository repo;
  GetOnlineStatusUseCase(this.repo);

  Stream<bool> call(String userId) {
    return repo.getUserOnlineStatus(userId);
  }
}