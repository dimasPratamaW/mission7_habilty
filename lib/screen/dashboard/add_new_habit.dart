import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mission7_habitly/presentation/providers/auth_providers.dart';
import 'package:mission7_habitly/presentation/providers/habit_providers.dart';
import 'package:mission7_habitly/screen/controller/list_habit_controller.dart';
import 'package:mission7_habitly/style/app_color.dart';
import 'package:mission7_habitly/widget/custom_field.dart';

class AddNewHabit extends ConsumerStatefulWidget {

  const AddNewHabit({super.key,});

  @override
  ConsumerState<AddNewHabit> createState() => _AddNewHabitState();
}

class _AddNewHabitState extends ConsumerState<AddNewHabit> {
  final titleHabit = TextEditingController();
  final descHabit = TextEditingController();
  String timeHabit = '06:00';
  DateTime selectedDate = DateTime.now();

  @override
  void dispose() {
    titleHabit.dispose();
    descHabit.dispose();
    super.dispose();
  }

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final uid = ref.watch(currentUidProvider);
    final List<String> timeOptions = [
      '06:00',
      '09:00',
      '12:00',
      '15:00',
      '18:00',
      '21:00',
    ];

    final colors = AppColors.of(context);

    return Scaffold(
      backgroundColor: colors.background,
      body: Center(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              SizedBox(height: 20,),
              CustomField(
                label: 'Habit Name',
                backgroundColor: Colors.white,
                controller: titleHabit,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'cant be empty';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              CustomField(
                label: 'Habit Description',
                backgroundColor: Colors.white,
                controller: descHabit,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'cant be empty';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              Padding(
                padding: EdgeInsetsGeometry.symmetric(horizontal: 40),
                child: Card(
                  color: Color(0XFFECE6F0),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsetsGeometry.symmetric(
                          horizontal: 20,
                          vertical: 15,
                        ),
                        child: InputDatePickerFormField(
                          firstDate: DateTime(2020),
                          lastDate: DateTime(2028),
                          initialDate: selectedDate,
                          onDateSaved: (date) {
                            selectedDate = date;
                          },
                        ),
                      ),
                      SizedBox(height: 10),
                      Text('When we should remind you ?'),
                      Padding(
                        padding: EdgeInsetsGeometry.symmetric(vertical: 10),
                        child: DropdownMenu<String>(
                          initialSelection: timeOptions[0],
                          dropdownMenuEntries: timeOptions.map((value) {
                            return DropdownMenuEntry<String>(
                              value: value,
                              label: value,
                            );
                          }).toList(),
                          onSelected: (value) {
                            if (value != null) {
                              timeHabit = value;
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: EdgeInsetsGeometry.directional(start: 30, end: 30),
                child: ElevatedButton(
                  //button register
                  onPressed: () async {
                    if (!formKey.currentState!.validate()) return;
                    if(uid == null) return;

                      // await ref.read(habitListProvider.notifier).addHabit(
                      //   titleHabit.text,
                      //   descHabit.text,
                      //   timeHabit,
                      // );

                    await ref.read(habitNotifierProvider.notifier).addHabit(title: titleHabit.text, desc: descHabit.text, time: timeHabit, uid: uid);

                      if(!context.mounted) return;

                      await showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text("Success"),
                          content: const Text("Habit added successfully!"),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text("OK"),
                            ),
                          ],
                        ),
                      );

                      // Clear fields AFTER dialog is closed
                      titleHabit.clear();
                      descHabit.clear();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF2FB969),
                    minimumSize: const Size(double.infinity, 40),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusGeometry.circular(10),
                    ),
                  ),
                  child: const Text(
                    "Save habit",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
