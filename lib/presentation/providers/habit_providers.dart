import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:mission7_habitly/datasources/firestore_habit_datasource.dart';
import 'package:mission7_habitly/datasources/habit_datasource.dart';
import 'package:mission7_habitly/domain/entities/habit_entity.dart';
import 'package:mission7_habitly/domain/repositories/habit_repositories.dart';
import 'package:mission7_habitly/presentation/providers/habit_notifier.dart';
import 'package:mission7_habitly/repositories/habit_repo_impl.dart';

final firestoreProvider = Provider<FirebaseFirestore>((ref){
  return FirebaseFirestore.instance;
});

final habitDatasourceProvider = Provider<HabitDatasource>((ref){
  return FirestoreHabitDatasource(ref.watch(firestoreProvider));
});

final habitRepositoryProvider = Provider<HabitRepositories>((ref){
  return HabitRepoImpl(ref.watch(habitDatasourceProvider));
});


enum HabitSort {dateNewest, dateOldest}
enum HabitFilter {all, upcoming, ongoing, completed}

final habitSortProvider = StateProvider<HabitSort>((ref)=> HabitSort.dateNewest);
final habitFilterProvider = StateProvider<HabitFilter>((ref)=>HabitFilter.all);

final habitStreamProvider = StreamProvider.family<List<HabitEntity>,String>((ref,uid){
  return ref.watch(habitRepositoryProvider).getHabits(uid);
});


// this is for add and deleting habit
final habitNotifierProvider = AsyncNotifierProvider<HabitNotifier,List<HabitEntity>>((){
  return HabitNotifier();
});