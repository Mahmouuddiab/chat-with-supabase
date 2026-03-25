import 'package:injectable/injectable.dart';
import 'package:supa_chat/features/auth/data/models/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'auth_remote_ds.dart';

@LazySingleton(as: AuthRemoteDs)
class AuthRemoteDsImpl implements AuthRemoteDs {
  final SupabaseClient client;

  AuthRemoteDsImpl(this.client);

  @override
  Future<UserModel> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final response = await client.auth.signInWithPassword(
        email: email,
        password: password,
      );

      final user = response.user;

      if (user == null) {
        throw Exception('Login failed: user is null');
      }

      return UserModel(
        id: user.id,
        email: user.email ?? '',
        name: user.userMetadata?['name'] ?? '',
      );
    } catch (e) {
      throw Exception('Login error: $e');
    }
  }

  @override
  Future<void> signOut() async {
    await client.auth.signOut();
  }

  @override
  Future<UserModel> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      /// 1️⃣ Create Auth user
      final response = await client.auth.signUp(
        email: email,
        password: password,
      );

      final user = response.user;

      if (user == null) {
        throw Exception('Sign up failed: user is null');
      }

      /// Debug
      print('✅ Auth User Created: ${user.id}');

      /// 2️⃣ Insert into profiles table
      await client.from('profiles').insert({
        'id': user.id,
        'name': name,
        'email': email,
      });

      print('✅ Profile inserted successfully');

      return UserModel(
        id: user.id,
        email: email,
        name: name,
      );
    } catch (e) {
      throw Exception('Sign up error: $e');
    }
  }

  @override
  Future<UserModel?> getCurrentUser() async {
    final user = client.auth.currentUser;

    if (user == null) return null;

    return UserModel(
      id: user.id,
      email: user.email ?? '',
      name: user.userMetadata?['name'] ?? '',
    );
  }
}