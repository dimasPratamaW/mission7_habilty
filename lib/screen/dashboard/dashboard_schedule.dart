import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mission7_habitly/models/list_habit_hive.dart';
import 'package:mission7_habitly/presentation/providers/auth_providers.dart';
import 'package:mission7_habitly/presentation/providers/habit_providers.dart';
import 'package:mission7_habitly/screen/controller/list_habit_controller.dart';
import 'package:mission7_habitly/style/app_color.dart';

class DashboardSchedule extends ConsumerStatefulWidget {
  static const routeName = '/dashboard_schedule';

  const DashboardSchedule({super.key});

  @override
  ConsumerState<DashboardSchedule> createState() => _DashboardSchedule();
}

class _DashboardSchedule extends ConsumerState<DashboardSchedule> {
  static const List<Map<String, String>> days = [
    {'letter': 'M', 'number': '1'},
    {'letter': 'T', 'number': '2'},
    {'letter': 'W', 'number': '3'},
    {'letter': 'T', 'number': '4'},
    {'letter': 'F', 'number': '5'},
    {'letter': 'S', 'number': '6'},
    {'letter': 'S', 'number': '7'},
  ];

  @override
  Widget build(BuildContext context) {

    final uid = ref.watch(currentUidProvider); // ← get uid
    final colors = AppColors.of(context);

    if (uid == null) return const Center(child: CircularProgressIndicator());

    final pullData = ref.watch(habitStreamProvider(uid));
    // final pullData = ref.watch(habitListProvider);// this is for hive
    return Scaffold(
      backgroundColor: colors.background,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 16),
          SizedBox(
            // tanggal diatas
            height: 80,
            child: Padding(
              padding: EdgeInsetsGeometry.directional(start: 20),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: days.length,
                itemBuilder: (context, index) {
                  final day = days[index];
                  return SizedBox(
                    width: 50,
                    child: Column(
                      children: [
                        Text(day['letter']!),
                        SizedBox(height: 10),
                        Container(
                          width: 30,
                          height: 30,
                          decoration: const BoxDecoration(
                            color: Color(0xFFF5F5F5),
                            shape: BoxShape.circle,
                          ),
                          child: Center(child: Text(day['number']!)),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
          SizedBox(height: 10),
          Padding(
            // text title my Habit
            padding: EdgeInsetsGeometry.directional(start: 10),
            child: Text(
              'My Habit',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: pullData.when(
              data: (activities) {
                if (activities.isEmpty) {
                  return const Center(child: Text("No habits yet"));
                }
                return RefreshIndicator(  // ← add this
                  onRefresh: () async {
                    ref.invalidate(habitStreamProvider(uid));
                  },
                  child: Padding(  // ← your existing code unchanged
                    padding: const EdgeInsetsGeometry.symmetric(horizontal: 30),
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: activities.length,
                      itemBuilder: (context, index) {
                        final activity = activities[index];
                        return Container(
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(color: Colors.black, width: 1),
                            ),
                          ),
                          width: 200,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 8),
                                  Text(
                                    activity.title,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Text(activity.desc),
                                  SizedBox(height: 10),
                                  Text(activity.time),
                                  SizedBox(height: 8),
                                ],
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  if (!context.mounted) return;
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: const Text("CAREFUL 🙏"),
                                      content: Text("this ${activity.title} habit will be deleted, are you really sure?"),
                                      actionsPadding: EdgeInsetsDirectional.symmetric(horizontal: 10, vertical: 10),
                                      actions: [
                                        ElevatedButton(
                                          style: ElevatedButton.styleFrom(backgroundColor: Color(0xFFF5F5F5)),
                                          onPressed: () {
                                            ref.read(habitNotifierProvider.notifier).deleteHabit(uid, activity.id);
                                            Navigator.pop(context);
                                          },
                                          child: const Text("YES"),
                                        ),
                                        ElevatedButton(
                                          style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                                          onPressed: () => Navigator.pop(context),
                                          child: const Text("NO", style: TextStyle(color: Colors.white)),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                                child: Icon(Icons.delete_forever),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, stack) => const Center(child: Text('ERROR please ask developer')),
            ),
          ),
        ],
      ),
    );
  }
}
