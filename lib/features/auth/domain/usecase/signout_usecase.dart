import 'package:injectable/injectable.dart';
import 'package:supa_chat/features/auth/domain/repository/auth_repository.dart';

@injectable
class SignOutUseCase {
  AuthRepository repository;
  SignOutUseCase(this.repository);
  Future<void> call()=> repository.signOut();
}