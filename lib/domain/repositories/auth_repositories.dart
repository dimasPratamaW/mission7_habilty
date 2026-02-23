import 'package:mission7_habitly/domain/entities/app_user.dart';
import 'package:mission7_habitly/domain/entities/auth_credentials.dart';

abstract class AuthRepositories {
  Future<AppUser> login(AuthCredentials authcredentials);
  Future<void> logout();
}