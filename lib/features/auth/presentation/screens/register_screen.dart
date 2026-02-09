import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task/core/theming/colors.dart';
import 'package:task/features/auth/presentation/widgets/auth_header.dart';
import 'package:task/features/auth/presentation/widgets/auth_text_field.dart';
import 'package:task/features/auth/presentation/widgets/social_button.dart';
import 'package:task/features/auth/presentation/widgets/or_divider.dart';
import 'package:task/features/auth/presentation/widgets/auth_footer_link.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 20.h),
              const AuthHeader(
                title: 'Create Account',
                subtitle: 'Start your journey with us today.',
              ),
              AuthTextField(
                label: 'Full Name',
                hintText: 'Sarah Miller',
                controller: _nameController,
              ),
              SizedBox(height: 20.h),
              AuthTextField(
                label: 'Email Address',
                hintText: 'sarah@example.com',
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 20.h),
              AuthTextField(
                label: 'Password',
                hintText: '••••••••',
                controller: _passwordController,
                obscureText: _obscurePassword,
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
              SizedBox(height: 32.h),
              SizedBox(
                height: 54.h,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorManager.mainColor,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  child: Text(
                    'Sign Up',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 24.h),
              const OrDivider(),
              SizedBox(height: 24.h),
              Row(
                children: [
                  Expanded(
                    child: SocialButton(
                      icon: "assets/icons/iconify-icon_margin.svg",
                      label: 'Google',
                      onPressed: () {},
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: SocialButton(
                      icon: "assets/icons/iconify-icon_margin (1).svg",
                      label: 'Apple',
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24.h),
              AuthFooterLink(
                text: 'Already have an account? ',
                linkText: 'Log in',
                onTap: () => Navigator.pushReplacementNamed(context, '/login'),
              ),
              SizedBox(height: 24.h),
            ],
          ),
        ),
      ),
    );
  }
}
