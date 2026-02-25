import 'package:mission7_habitly/domain/entities/auth_credentials.dart';
import 'package:mission7_habitly/models/app_user_model.dart';

abstract class AuthDatasource {
  Future<AppUserModel> login (AuthCredentials credentials);
  Future<AppUserModel> register (AuthCredentials credentials);
  Future<void> logout();
}