import 'package:flutter/material.dart';
import 'package:task/core/helpers/spacing.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task/core/base/cubit/base_state.dart';
import 'package:task/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:task/features/auth/presentation/cubit/auth_state.dart';

class ForgotPasswordButton extends StatelessWidget {
  final TextEditingController emailController;

  const ForgotPasswordButton({super.key, required this.emailController});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          final isLoading =
              state.getStatus(AuthCubit.endpointForgotPassword) ==
              BaseStatus.loading;
          return TextButton(
            onPressed: isLoading
                ? null
                : () {
                    final email = emailController.text.trim();
                    if (email.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Please enter your email first.'),
                          backgroundColor: Colors.red,
                        ),
                      );
                      return;
                    }
                    context.read<AuthCubit>().sendPasswordResetEmail(email);
                  },
            child: Text(
              'Forgot Password?',
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
          );
        },
      ),
    );
  }
}
