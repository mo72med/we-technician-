import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:we_app/view/complain_details_screen.dart';
import 'package:we_app/view/complaints_screen.dart';
import 'package:we_app/view/login_screen.dart';
import 'package:we_app/view_model/compalin_manager.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ComplaintManager()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: 'LoginPage',
      routes: {
        'LoginPage': (context) => LoginPage(),
        'ComplaintsScreen': (context) => const ComplaintsScreen(),
        'ComplainDetailsScreen': (context) => ComplainDetailsScreen(
              index: ModalRoute.of(context)!.settings.arguments as int,
            ),
      },
    );
  }
}
