import 'package:flutter/material.dart';
import 'package:task/core/helpers/spacing.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task/core/base/cubit/base_state.dart';
import 'package:task/core/helpers/app_regex.dart';
import 'package:task/core/theming/colors.dart';
import 'package:task/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:task/features/auth/presentation/cubit/auth_state.dart';
import 'package:task/features/auth/presentation/widgets/auth_text_field.dart';
import 'package:task/features/auth/presentation/widgets/forgot_password_button.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          AuthTextField(
            label: 'Email Address',
            hintText: 'sarah@example.com',
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your email';
              }
              if (!AppRegex.isEmailValid(value)) {
                return 'Please enter a valid email';
              }
              return null;
            },
          ),
          verticalSpace(20.h),
          AuthTextField(
            label: 'Password',
            hintText: '••••••••',
            controller: _passwordController,
            obscureText: _obscurePassword,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your password';
              }
              if (!AppRegex.hasMinLength(value)) {
                return 'Password must be at least 8 characters';
              }
              return null;
            },
            suffixIcon: IconButton(
              icon: Icon(
                _obscurePassword
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
                color: Colors.grey[600],
              ),
              onPressed: () =>
                  setState(() => _obscurePassword = !_obscurePassword),
            ),
          ),
          verticalSpace(12.h),
          ForgotPasswordButton(emailController: _emailController),
          verticalSpace(20.h),
          SizedBox(
            height: 48.h,
            width: double.infinity,
            child: BlocBuilder<AuthCubit, AuthState>(
              builder: (context, state) {
                final isLoading =
                    state.getStatus(AuthCubit.endpointLogin) ==
                    BaseStatus.loading;
                return ElevatedButton(
                  onPressed: isLoading
                      ? null
                      : () {
                          if (_formKey.currentState!.validate()) {
                            context.read<AuthCubit>().signInWithEmail(
                              _emailController.text.trim(),
                              _passwordController.text,
                            );
                          }
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorManager.mainColor,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  child: isLoading
                      ? SizedBox(
                          height: 24.h,
                          width: 24.w,
                          child: const CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : Text(
                          'Log In',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
