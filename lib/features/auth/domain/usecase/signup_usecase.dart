import 'package:injectable/injectable.dart';
import 'package:supa_chat/features/auth/domain/entity/user_entity.dart';
import 'package:supa_chat/features/auth/domain/repository/auth_repository.dart';

@injectable
class SignUpUseCase {
  final AuthRepository repository;

  SignUpUseCase(this.repository);

  Future<UserEntity> call({
    required String name,
    required String email,
    required String password,
  }) {
    return repository.signUp(
      name: name,
      email: email,
      password: password,
    );
  }
}