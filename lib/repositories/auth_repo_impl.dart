import 'package:mission7_habitly/datasources/auth_datasource.dart';
import 'package:mission7_habitly/domain/entities/app_user.dart';
import 'package:mission7_habitly/domain/entities/auth_credentials.dart';
import 'package:mission7_habitly/domain/repositories/auth_repositories.dart';

class AuthRepoImpl implements AuthRepositories{
  final AuthDatasource _datasource;
  AuthRepoImpl(this._datasource);

  @override
  Future<AppUser> login(AuthCredentials authcredentials) async {
    // TODO: implement login
    final model = await _datasource.login(authcredentials);

    return model;
  }

  @override
  Future<void> logout() async {
    await _datasource.logout();
  }

  @override
  Future<AppUser> register(AuthCredentials authcredentials)async {
    // TODO: implement register
    final model = await _datasource.register(authcredentials);

    return model;
  }
}