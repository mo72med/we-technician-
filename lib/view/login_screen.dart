import 'package:flutter/material.dart';

import '../view_model/ login_presenter.dart';

class LoginPage extends StatelessWidget {
  final LoginPresenter presenter = LoginPresenter();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('تسجيل الدخول')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: presenter.userIdController,
              decoration: InputDecoration(labelText: 'User ID'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: presenter.passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            ElevatedButton(
              onPressed: () => presenter.login(context),
              child: Text('تسجيل الدخول'),
            ),
          ],
        ),
      ),
    );
  }
}
