import 'package:flutter/material.dart';
import 'package:task/core/helpers/spacing.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:task/core/base/cubit/base_listener_widget.dart';
import 'package:task/core/base/cubit/base_state.dart';
import 'package:task/core/di/dependency_injection.dart';
import 'package:task/core/routing/routes.dart';
import 'package:task/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:task/features/auth/presentation/cubit/auth_state.dart';
import 'package:task/features/auth/presentation/widgets/auth_header.dart';
import 'package:task/features/auth/presentation/widgets/auth_footer_link.dart';
import 'package:task/features/auth/presentation/widgets/login_form.dart';
import 'package:task/features/auth/presentation/widgets/or_divider.dart';
import 'package:task/features/auth/presentation/widgets/social_button.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<AuthCubit>(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: BaseBlocListener<AuthCubit, AuthState>(
            endPoint: AuthCubit.endpointLogin,
            onSuccess: (context, state) {
              context.goNamed(RouteNames.bottomNavBar);
            },
            onError: (context, state, error) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(error), backgroundColor: Colors.red),
              );
            },
            child: BaseBlocListener<AuthCubit, AuthState>(
              endPoint: AuthCubit.endpointForgotPassword,
              onSuccess: (context, state) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Password reset email sent! Check your inbox.',
                    ),
                    backgroundColor: Colors.green,
                  ),
                );
              },
              onError: (context, state, error) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(error), backgroundColor: Colors.red),
                );
              },
              child: BlocBuilder<AuthCubit, AuthState>(
                builder: (context, state) {
                  final isLoading =
                      state.getStatus(AuthCubit.endpointLogin) ==
                      BaseStatus.loading;

                  return SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const AuthHeader(
                          title: 'Welcome Back',
                          subtitle: 'Please enter your details to sign in.',
                        ),
                        const LoginForm(),
                        verticalSpace(24.h),
                        const OrDivider(),
                        verticalSpace(24.h),
                        Row(
                          children: [
                            Expanded(
                              child: SocialButton(
                                icon: "assets/icons/iconify-icon_margin.svg",
                                label: 'Google',
                                onPressed: isLoading
                                    ? () {}
                                    : () => context
                                          .read<AuthCubit>()
                                          .signInWithGoogle(),
                              ),
                            ),
                            horizontalSpace(12.w),
                            Expanded(
                              child: SocialButton(
                                icon:
                                    "assets/icons/iconify-icon_margin (1).svg",
                                label: 'Apple',
                                onPressed: isLoading
                                    ? () {}
                                    : () => context
                                          .read<AuthCubit>()
                                          .signInWithApple(),
                              ),
                            ),
                          ],
                        ),
                        verticalSpace(24.h),
                        AuthFooterLink(
                          text: "Don't have an account? ",
                          linkText: 'Sign up',
                          onTap: () =>
                              context.goNamed(RouteNames.registerScreen),
                        ),
                        verticalSpace(24.h),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
