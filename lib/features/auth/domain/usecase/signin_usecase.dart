import 'package:injectable/injectable.dart';
import 'package:supa_chat/features/auth/domain/entity/user_entity.dart';
import 'package:supa_chat/features/auth/domain/repository/auth_repository.dart';

@injectable
class SignInUseCase {
  final AuthRepository repository;

  SignInUseCase(this.repository);

  Future<UserEntity> call({
    required String email,
    required String password,
  }) {
    return repository.signIn(
      email: email,
      password: password,
    );
  }
}