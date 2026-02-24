import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mission7_habitly/datasources/auth_datasource.dart';
import 'package:mission7_habitly/datasources/firebase_auth_datasource.dart';
import 'package:mission7_habitly/domain/entities/app_user.dart';
import 'package:mission7_habitly/domain/repositories/auth_repositories.dart';
import 'package:mission7_habitly/presentation/providers/auth_notifier.dart';
import 'package:mission7_habitly/repositories/auth_repo_impl.dart';


// 1 - Firebase Instance
final firebaseAuthProvider = Provider<FirebaseAuth>((ref){
  return FirebaseAuth.instance;
});

// 2 - Datasource
final authDataSourceAuthProvider = Provider<AuthDatasource>((ref){
return FirebaseAuthDatasource(ref.watch(firebaseAuthProvider));
});

// 3 - Repository
final authRepositoryProvider = Provider<AuthRepositories>((ref){
  return AuthRepoImpl(ref.watch(authDataSourceAuthProvider));
});

// 4 - Notifier (login/logout state)
final authNotifierProvider = AsyncNotifierProvider<AuthNotifier,AppUser?>((){
  return AuthNotifier();
});