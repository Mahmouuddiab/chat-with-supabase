import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:supa_chat/features/auth/domain/usecase/current_user.dart';
import 'package:supa_chat/features/auth/domain/usecase/signin_usecase.dart';
import 'package:supa_chat/features/auth/domain/usecase/signout_usecase.dart';
import 'package:supa_chat/features/auth/domain/usecase/signup_usecase.dart';
import 'auth_state.dart';

@injectable
class AuthCubit extends Cubit<AuthState> {
  final SignUpUseCase signUpUseCase;
  final SignInUseCase signInUseCase;
  final SignOutUseCase signOutUseCase;
  final GetCurrentUserUseCase getCurrentUserUseCase;

  AuthCubit(
      this.signUpUseCase,
      this.signInUseCase,
      this.signOutUseCase,
      this.getCurrentUserUseCase
      ) : super(AuthInitial());

  /// 🔐 SIGN UP
  Future<void> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    emit(AuthLoading());

    try {
      final user = await signUpUseCase(
        name: name,
        email: email,
        password: password,
      );

      emit(AuthSuccess(user));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  /// 🔑 SIGN IN
  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    emit(AuthLoading());

    try {
      final user = await signInUseCase(
        email: email,
        password: password,
      );

      emit(AuthSuccess(user));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  /// 🚪 SIGN OUT
  Future<void> signOut() async {
    emit(AuthLoading());

    try {
      await signOutUseCase();
      emit(AuthInitial());
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> getCurrentUser() async {
    emit(AuthLoading());

    try {
      final user = await getCurrentUserUseCase();

      if (user != null) {
        emit(AuthSuccess(user));
      } else {
        emit(AuthInitial());
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

}