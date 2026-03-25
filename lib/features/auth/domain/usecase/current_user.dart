import 'package:injectable/injectable.dart';
import '../entity/user_entity.dart';
import '../repository/auth_repository.dart';

@injectable
class GetCurrentUserUseCase {
  final AuthRepository repository;

  GetCurrentUserUseCase(this.repository);

  Future<UserEntity?> call() {
    return repository.getCurrentUser();
  }
}