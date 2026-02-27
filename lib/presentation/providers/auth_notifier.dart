import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mission7_habitly/domain/entities/app_user.dart';
import 'package:mission7_habitly/domain/entities/auth_credentials.dart';
import 'package:mission7_habitly/presentation/providers/auth_providers.dart';

class AuthNotifier extends AsyncNotifier<AppUser?>{

  @override
  Future<AppUser?> build () async => null;

  Future<void> login(AuthCredentials credentials) async{
    state = const AsyncLoading();
    try {
      final user = await ref.read(authRepositoryProvider).login(credentials);
      state = AsyncData(user);
    } catch (e) {
      state = AsyncError(e, StackTrace.current);
    }
  }

  Future<void> register (AuthCredentials credentials) async{
    state = const AsyncLoading();
    try {
      final user = await ref.read(authRepositoryProvider).register(credentials);
      state = AsyncData(user);
    } catch (e) {
      state = AsyncError(e, StackTrace.current);
    }
  }



  Future<void> logout() async{
    state = const AsyncLoading();
    await ref.read(authRepositoryProvider).logout();
    state = const AsyncData(null);
  }


}