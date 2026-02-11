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
import 'package:task/features/auth/presentation/widgets/or_divider.dart';
import 'package:task/features/auth/presentation/widgets/register_form.dart';
import 'package:task/features/auth/presentation/widgets/social_button.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

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
              endPoint: AuthCubit.endpointRegister,
              onSuccess: (context, state) {
                context.goNamed(RouteNames.bottomNavBar);
              },
              onError: (context, state, error) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(error), backgroundColor: Colors.red),
                );
              },
              child: BlocBuilder<AuthCubit, AuthState>(
                builder: (context, state) {
                  final isLoginLoading =
                      state.getStatus(AuthCubit.endpointLogin) ==
                      BaseStatus.loading;
                  final isRegisterLoading =
                      state.getStatus(AuthCubit.endpointRegister) ==
                      BaseStatus.loading;
                  final isLoading = isLoginLoading || isRegisterLoading;

                  return SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        verticalSpace(20.h),
                        const AuthHeader(
                          title: 'Create Account',
                          subtitle: 'Start your journey with us today.',
                        ),
                        const RegisterForm(),
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
                          text: 'Already have an account? ',
                          linkText: 'Log in',
                          onTap: () => context.goNamed(RouteNames.loginScreen),
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
