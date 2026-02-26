import 'package:mission7_habitly/domain/entities/habit_entity.dart';

abstract class HabitRepositories {
  Stream<List<HabitEntity>>getHabits(String uid);
  Future<void> addHabit(HabitEntity habit);
  Future<void> deleteHabit(String uid, String habitId);

}