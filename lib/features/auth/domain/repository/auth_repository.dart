import 'package:supa_chat/features/auth/domain/entity/user_entity.dart';

abstract class AuthRepository {
  Future<UserEntity> signUp({
    required String name,
    required String email,
    required String password,
  });

  Future<UserEntity> signIn({
    required String email,
    required String password,
  });

  Future<void> signOut();

  Future<UserEntity?> getCurrentUser();
}