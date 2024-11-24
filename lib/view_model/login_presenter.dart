import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'compalin_manager.dart';

class LoginPresenter {
  final TextEditingController userIdController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> login(BuildContext context) async {
    final complaintManager =
        Provider.of<ComplaintManager>(context, listen: false);
    final userId = int.tryParse(userIdController.text);
    final password = passwordController.text;

    if (userId == null || password != '123') {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('بيانات غير صحيحة')),
      );
      return;
    }

    await complaintManager.fetchComplaints(userId);
    if (complaintManager.employeeComplaints.isNotEmpty) {
      Navigator.pushReplacementNamed(context, 'ComplaintsScreen');
    } else {
      Navigator.pushReplacementNamed(context, 'ComplaintsScreen');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('لا توجد شكاوى')),
      );
    }
  }
}
