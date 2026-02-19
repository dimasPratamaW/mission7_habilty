import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mission7_habitly/screen/controller/list_habit_controller.dart';
import 'package:mission7_habitly/screen/dashboard/main_dashboard.dart';
import 'package:mission7_habitly/style/app_color.dart';

class DashboardTime extends ConsumerWidget {
  static const routeName = '/dashboard_time';
  const DashboardTime({super.key});

  final List<Map<String, dynamic>> listTime = const [
    {'time': '06:00', 'title': 'Morning'},
    {'time': '12:00', 'title': 'Noon'},
    {'time': '16:00', 'title': 'Afternoon'},
    {'time': '21:00', 'title': 'Evening'},
  ];


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final args =
    ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    final String habitTitle = args['title'] ?? 'unknown habit';

    final colors = AppColors.of(context);
    return Scaffold(
      backgroundColor: colors.background,
      body: Column(
        children: [
          const SizedBox(height: 100),
          Text.rich(
            style: TextStyle(fontWeight: FontWeight.bold),
            TextSpan(
              text: 'When you want us to remind u to do ',
              children: [
                TextSpan(
                  text: habitTitle,
                  style: const TextStyle(
                    decoration: TextDecoration.underline,
                    decorationThickness: 3
                  ),
                ),
                const TextSpan(text: ' ?'),
              ],
            ),
          ),
          SizedBox(height: 10),
          Text('Select One'),
          SizedBox(height: 16),


          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemCount: listTime.length,
              itemBuilder: (context, index) {
                final time = listTime[index];

                return Padding(
                  padding: const EdgeInsets.only(
                    left: 12,
                    right: 12,
                    bottom: 24,
                  ),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      ref.read(habitListProvider.notifier).addHabit(habitTitle, "Daily habit", time['time']);

                      Navigator.pushReplacementNamed(
                        context,
                        MainDashboard.routeName,
                      );
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 10),
                        Text(time['time'],style: TextStyle(fontSize: 50),),
                        SizedBox(height: 10),
                        Text(time['title'], style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
