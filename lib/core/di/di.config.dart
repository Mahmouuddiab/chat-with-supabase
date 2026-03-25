// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:supabase_flutter/supabase_flutter.dart' as _i454;

import '../../features/auth/data/data%20source/auth_remote_ds.dart' as _i6;
import '../../features/auth/data/data%20source/auth_remote_ds_impl.dart'
    as _i624;
import '../../features/auth/data/repository/auth_repository_impl.dart' as _i409;
import '../../features/auth/domain/repository/auth_repository.dart' as _i961;
import '../../features/auth/domain/usecase/current_user.dart' as _i85;
import '../../features/auth/domain/usecase/signin_usecase.dart' as _i618;
import '../../features/auth/domain/usecase/signout_usecase.dart' as _i584;
import '../../features/auth/domain/usecase/signup_usecase.dart' as _i472;
import '../../features/auth/presentation/cubit/auth_cubit.dart' as _i117;
import '../../features/chat/data/data%20source/chat_remote_ds.dart' as _i653;
import '../../features/chat/data/data%20source/chat_remote_ds_impl.dart'
    as _i594;
import '../../features/chat/data/repository/chat_repository_impl.dart' as _i88;
import '../../features/chat/domain/repository/chat_repository.dart' as _i477;
import '../../features/chat/domain/usecase/get_message.dart' as _i485;
import '../../features/chat/domain/usecase/online_status.dart' as _i235;
import '../../features/chat/domain/usecase/send_message.dart' as _i441;
import '../../features/chat/presentation/cubit/chat_cubit.dart' as _i305;
import 'module.dart' as _i946;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final supabaseModule = _$SupabaseModule();
    gh.lazySingleton<_i454.SupabaseClient>(() => supabaseModule.client);
    gh.lazySingleton<_i6.AuthRemoteDs>(
      () => _i624.AuthRemoteDsImpl(gh<_i454.SupabaseClient>()),
    );
    gh.lazySingleton<_i653.ChatRemoteDs>(
      () => _i594.ChatRemoteDsImpl(gh<_i454.SupabaseClient>()),
    );
    gh.factory<_i477.ChatRepository>(
      () => _i88.ChatRepositoryImpl(gh<_i653.ChatRemoteDs>()),
    );
    gh.factory<_i961.AuthRepository>(
      () => _i409.AuthRepositoryImpl(gh<_i6.AuthRemoteDs>()),
    );
    gh.factory<_i85.GetCurrentUserUseCase>(
      () => _i85.GetCurrentUserUseCase(gh<_i961.AuthRepository>()),
    );
    gh.factory<_i618.SignInUseCase>(
      () => _i618.SignInUseCase(gh<_i961.AuthRepository>()),
    );
    gh.factory<_i584.SignOutUseCase>(
      () => _i584.SignOutUseCase(gh<_i961.AuthRepository>()),
    );
    gh.factory<_i472.SignUpUseCase>(
      () => _i472.SignUpUseCase(gh<_i961.AuthRepository>()),
    );
    gh.factory<_i485.GetMessagesUseCase>(
      () => _i485.GetMessagesUseCase(gh<_i477.ChatRepository>()),
    );
    gh.factory<_i235.GetOnlineStatusUseCase>(
      () => _i235.GetOnlineStatusUseCase(gh<_i477.ChatRepository>()),
    );
    gh.factory<_i441.SendMessageUseCase>(
      () => _i441.SendMessageUseCase(gh<_i477.ChatRepository>()),
    );
    gh.factory<_i117.AuthCubit>(
      () => _i117.AuthCubit(
        gh<_i472.SignUpUseCase>(),
        gh<_i618.SignInUseCase>(),
        gh<_i584.SignOutUseCase>(),
        gh<_i85.GetCurrentUserUseCase>(),
      ),
    );
    gh.factory<_i305.ChatCubit>(
      () => _i305.ChatCubit(
        gh<_i485.GetMessagesUseCase>(),
        gh<_i441.SendMessageUseCase>(),
        gh<_i235.GetOnlineStatusUseCase>(),
      ),
    );
    return this;
  }
}

class _$SupabaseModule extends _i946.SupabaseModule {}
