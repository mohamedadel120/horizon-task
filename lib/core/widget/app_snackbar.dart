import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task/core/helpers/spacing.dart';
import 'package:task/core/theming/colors.dart';

/// Global SnackBar widget with consistent styling and functionality
class AppSnackBar {
  /// Show an error message with slide-up + fade animation (ideal for auth errors)
  static void showAnimatedError(
    BuildContext context, {
    required String message,
    Duration duration = const Duration(seconds: 5),
    VoidCallback? onDismiss,
  }) {
    final overlay = Overlay.of(context);
    late OverlayEntry entry;
    entry = OverlayEntry(
      builder: (ctx) => _AnimatedErrorBanner(
        message: message,
        duration: duration,
        onDismiss: () {
          entry.remove();
          onDismiss?.call();
        },
      ),
    );
    overlay.insert(entry);
  }
  /// Show a success SnackBar
  static void showSuccess(
    BuildContext context, {
    required String message,
    Duration? duration,
    VoidCallback? onDismiss,
  }) {
    _showSnackBar(
      context,
      message: message,
      type: SnackBarType.success,
      duration: duration,
      onDismiss: onDismiss,
    );
  }

  /// Show an error SnackBar
  static void showError(
    BuildContext context, {
    required String message,
    Duration? duration,
    VoidCallback? onDismiss,
  }) {
    _showSnackBar(
      context,
      message: message,
      type: SnackBarType.error,
      duration: duration,
      onDismiss: onDismiss,
    );
  }

  /// Show a warning SnackBar
  static void showWarning(
    BuildContext context, {
    required String message,
    Duration? duration,
    VoidCallback? onDismiss,
  }) {
    _showSnackBar(
      context,
      message: message,
      type: SnackBarType.warning,
      duration: duration,
      onDismiss: onDismiss,
    );
  }

  /// Show an info SnackBar
  static void showInfo(
    BuildContext context, {
    required String message,
    Duration? duration,
    VoidCallback? onDismiss,
  }) {
    _showSnackBar(
      context,
      message: message,
      type: SnackBarType.info,
      duration: duration,
      onDismiss: onDismiss,
    );
  }

  /// Show a custom SnackBar with full control
  static void showCustom(
    BuildContext context, {
    required String message,
    required SnackBarType type,
    Widget? leading,
    Widget? trailing,
    Duration? duration,
    VoidCallback? onDismiss,
    bool showDismissAction = true,
    EdgeInsetsGeometry? margin,
    BorderRadius? borderRadius,
  }) {
    _showSnackBar(
      context,
      message: message,
      type: type,
      leading: leading,
      trailing: trailing,
      duration: duration,
      onDismiss: onDismiss,
      showDismissAction: showDismissAction,
      margin: margin,
      borderRadius: borderRadius,
    );
  }

  /// Internal method to show SnackBar
  static void _showSnackBar(
    BuildContext context, {
    required String message,
    required SnackBarType type,
    Widget? leading,
    Widget? trailing,
    Duration? duration,
    VoidCallback? onDismiss,
    bool showDismissAction = true,
    EdgeInsetsGeometry? margin,
    BorderRadius? borderRadius,
  }) {
    final snackBarConfig = _getSnackBarConfig(type);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            leading ?? Icon(snackBarConfig.icon, color: Colors.white, size: 20),
            horizontalSpace(8),
            Expanded(
              child: Text(message, style: TextStyle(color: Colors.white)),
            ),
            if (trailing != null) ...[horizontalSpace(8), trailing],
          ],
        ),
        backgroundColor: snackBarConfig.backgroundColor,
        duration: duration ?? snackBarConfig.defaultDuration,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: borderRadius ?? BorderRadius.circular(12),
        ),
        margin: margin ?? const EdgeInsets.all(16),
        action: showDismissAction
            ? SnackBarAction(
                label: 'Dismiss',
                textColor: Colors.white,
                onPressed: () {
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  onDismiss?.call();
                },
              )
            : null,
      ),
    );
  }

  /// Get SnackBar configuration based on type
  static _SnackBarConfig _getSnackBarConfig(SnackBarType type) {
    switch (type) {
      case SnackBarType.success:
        return _SnackBarConfig(
          backgroundColor: Colors.green.shade600,
          icon: Icons.check_circle_outline,
          defaultDuration: const Duration(seconds: 3),
        );
      case SnackBarType.error:
        return _SnackBarConfig(
          backgroundColor: Colors.red.shade600,
          icon: Icons.error_outline,
          defaultDuration: const Duration(seconds: 4),
        );
      case SnackBarType.warning:
        return _SnackBarConfig(
          backgroundColor: Colors.orange.shade600,
          icon: Icons.warning_amber_outlined,
          defaultDuration: const Duration(seconds: 4),
        );
      case SnackBarType.info:
        return _SnackBarConfig(
          backgroundColor: Colors.blue.shade600,
          icon: Icons.info_outline,
          defaultDuration: const Duration(seconds: 3),
        );
    }
  }

  /// Hide current SnackBar
  static void hide(BuildContext context) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
  }

  /// Clear all SnackBars
  static void clearAll(BuildContext context) {
    ScaffoldMessenger.of(context).clearSnackBars();
  }
}

/// SnackBar types
enum SnackBarType { success, error, warning, info }

/// Internal configuration class for SnackBar styling
class _SnackBarConfig {
  final Color backgroundColor;
  final IconData icon;
  final Duration defaultDuration;

  const _SnackBarConfig({
    required this.backgroundColor,
    required this.icon,
    required this.defaultDuration,
  });
}

/// Convenience widget for showing SnackBars with context
class AppSnackBarWidget extends StatelessWidget {
  final Widget child;
  final String? initialMessage;
  final SnackBarType? initialType;

  const AppSnackBarWidget({
    super.key,
    required this.child,
    this.initialMessage,
    this.initialType,
  });

  @override
  Widget build(BuildContext context) {
    // Show initial SnackBar if provided
    if (initialMessage != null && initialType != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        AppSnackBar.showCustom(
          context,
          message: initialMessage!,
          type: initialType!,
        );
      });
    }

    return child;
  }
}

/// Extension for easy SnackBar access from BuildContext
extension SnackBarExtension on BuildContext {
  /// Show success SnackBar
  void showSuccessSnackBar(String message, {Duration? duration}) {
    AppSnackBar.showSuccess(this, message: message, duration: duration);
  }

  /// Show error SnackBar
  void showErrorSnackBar(String message, {Duration? duration}) {
    AppSnackBar.showError(this, message: message, duration: duration);
  }

  /// Show warning SnackBar
  void showWarningSnackBar(String message, {Duration? duration}) {
    AppSnackBar.showWarning(this, message: message, duration: duration);
  }

  /// Show info SnackBar
  void showInfoSnackBar(String message, {Duration? duration}) {
    AppSnackBar.showInfo(this, message: message, duration: duration);
  }

  /// Hide current SnackBar
  void hideSnackBar() {
    AppSnackBar.hide(this);
  }

  /// Clear all SnackBars
  void clearSnackBars() {
    AppSnackBar.clearAll(this);
  }
}

/// Animated error banner with slide-up and fade (used by showAnimatedError)
class _AnimatedErrorBanner extends StatefulWidget {
  final String message;
  final Duration duration;
  final VoidCallback onDismiss;

  const _AnimatedErrorBanner({
    required this.message,
    required this.duration,
    required this.onDismiss,
  });

  @override
  State<_AnimatedErrorBanner> createState() => _AnimatedErrorBannerState();
}

class _AnimatedErrorBannerState extends State<_AnimatedErrorBanner>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 350),
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 1.2),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    ));
    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
    _controller.forward();
    Future.delayed(widget.duration, _animateOut);
  }

  Future<void> _animateOut() async {
    if (!mounted) return;
    await _controller.reverse();
    if (mounted) widget.onDismiss();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 16.w,
      right: 16.w,
      bottom: MediaQuery.of(context).padding.bottom + 24.h,
      child: SlideTransition(
        position: _slideAnimation,
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () => _animateOut(),
              borderRadius: BorderRadius.circular(16.r),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
                decoration: BoxDecoration(
                  color: ColorManager.statusError,
                  borderRadius: BorderRadius.circular(16.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.12),
                      blurRadius: 16,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.info_outline_rounded,
                      color: Colors.white,
                      size: 24.sp,
                    ),
                    horizontalSpace(12.w),
                    Expanded(
                      child: Text(
                        widget.message,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          height: 1.35,
                        ),
                      ),
                    ),
                    horizontalSpace(8.w),
                    Icon(
                      Icons.close,
                      color: Colors.white70,
                      size: 20.sp,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
