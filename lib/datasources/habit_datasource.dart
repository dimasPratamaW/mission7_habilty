import 'package:mission7_habitly/models/habit_model.dart';

abstract class HabitDatasource {
  Stream<List<HabitModel>> getHabits(String uid);
  Future<void> addHabit(HabitModel habit);
  Future<void> deleteHabit(String uid, String habitId);

}