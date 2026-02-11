import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:task/core/di/dependency_injection.dart';
import 'package:task/core/routing/routes.dart';
import 'package:task/features/auth/presentation/screens/login_screen.dart';
import 'package:task/features/auth/presentation/screens/register_screen.dart';
import 'package:task/features/home/logic/home_cubit.dart';
import 'package:task/features/home/presentation/screens/home_screen.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: Routes.loginScreen,
    routes: [
      GoRoute(
        path: Routes.loginScreen,
        name: RouteNames.loginScreen,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: Routes.registerScreen,
        name: RouteNames.registerScreen,
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: Routes.bottomNavBar,
        name: RouteNames.bottomNavBar,
        builder: (context, state) => BlocProvider(
          create: (context) => HomeCubit(sl())..loadCategoriesAndProducts(),
          child: const HomeScreen(),
        ),
      ),
    ],
  );
}
