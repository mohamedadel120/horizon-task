import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:task/core/helpers/spacing.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task/core/di/dependency_injection.dart';
import 'package:task/core/routing/go_router.dart';
import 'package:task/core/theming/colors.dart';
import 'package:task/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await setupGetIt();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: 'Property App',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: ColorManager.mainColor,
              brightness: Brightness.light,
            ),
            useMaterial3: true,
          ),
          routerConfig: AppRouter.router,
        );
      },
    );
  }
}
