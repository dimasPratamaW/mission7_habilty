import 'package:flutter/material.dart';

class UserAccount extends StatelessWidget {
  const UserAccount({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.account_circle, size: 60),
          const SizedBox(height: 10),
          Text('email'),
          const SizedBox(height: 10),
          Text('password'),
        ],
      ),
    );
  }
}
