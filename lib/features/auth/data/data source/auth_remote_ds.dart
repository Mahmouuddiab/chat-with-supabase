import 'package:supa_chat/features/auth/data/models/user_model.dart';

abstract class AuthRemoteDs {
  Future<UserModel> signUp({
    required String name,
    required String email,
    required String password,
  });

  Future<UserModel> signIn({
    required String email,
    required String password,
  });

  Future<void> signOut();

  Future<UserModel?> getCurrentUser();
}