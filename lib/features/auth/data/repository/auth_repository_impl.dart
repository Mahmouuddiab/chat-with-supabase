import 'package:injectable/injectable.dart';
import 'package:supa_chat/features/auth/data/models/user_model.dart';
import 'package:supa_chat/features/auth/domain/entity/user_entity.dart';
import 'package:supa_chat/features/auth/domain/repository/auth_repository.dart';
import '../data source/auth_remote_ds.dart';

@Injectable(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDs remote;

  AuthRepositoryImpl(this.remote);

  @override
  Future<UserEntity> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    final user = await remote.signUp(
      name: name,
      email: email,
      password: password,
    );

    return UserModel(
      id: user.id,
      email: user.email,
      name: name,
    );
  }

  @override
  Future<UserEntity> signIn({
    required String email,
    required String password,
  }) async {
    final user = await remote.signIn(
      email: email,
      password: password,
    );

    return UserModel(
      id: user.id,
      email: user.email,
      name: user.name,
    );
  }

  @override
  Future<void> signOut() {
    return remote.signOut();
  }

  @override
  Future<UserEntity?> getCurrentUser() async {
    final user = await remote.getCurrentUser();
    return user;
  }

}