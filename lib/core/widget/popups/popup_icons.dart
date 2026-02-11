import 'package:flutter/material.dart';
import 'package:task/core/helpers/spacing.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task/core/theming/colors.dart';
import 'package:task/core/utils/constants/assets/app_icons.dart';

enum PopupType { success, error, pending, confirm, offline }

class PopupIcon extends StatefulWidget {
  final PopupType type;
  const PopupIcon({super.key, required this.type});

  @override
  State<PopupIcon> createState() => _PopupIconState();
}

class _PopupIconState extends State<PopupIcon>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _scaleAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticOut,
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final config = _getConfig(widget.type);
    return ScaleTransition(
      scale: _scaleAnimation,
      child: Container(
        width: 100.w,
        height: 100.w,
        decoration: BoxDecoration(
          color: config.color.withOpacity(0.1),
          shape: BoxShape.circle,
        ),
        padding: EdgeInsets.all(16.w), // Inner padding for icon
        child: Container(
          // Inner circle or just icon?
          // Adding a ring border via another container or generic decoration
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: config.color.withOpacity(0.2),
              width: 8.w, // Ring around the icon
            ),
          ),
          child: Center(
            child: Image.asset(
              config.icon,
              width: 50.w,
              height: 50.w,
              fit: BoxFit.contain,
              // If you need color filter for the icon itself:
              // color: config.color,
              // But standard icons might be colored already.
            ),
          ),
        ),
      ),
    );
  }

  _PopupConfig _getConfig(PopupType type) {
    switch (type) {
      case PopupType.success:
        return _PopupConfig(ColorManager.statusSuccess, AppIcons.IN_PROGRESS);
      case PopupType.error:
        return _PopupConfig(ColorManager.statusError, AppIcons.REMOVE);
      case PopupType.pending:
        return _PopupConfig(ColorManager.statusWarning, AppIcons.WAITING);
      case PopupType.confirm:
        // Confirm usually implies a destructive action (Trash) or Info.
        // Given icon is TRASH, we use Error/Red color.
        return _PopupConfig(ColorManager.statusError, AppIcons.TRASH);
      case PopupType.offline:
        return _PopupConfig(ColorManager.gray, AppIcons.NO_WIFI);
    }
  }
}

class _PopupConfig {
  final Color color;
  final String icon;
  _PopupConfig(this.color, this.icon);
}

// ─── Backward Compatibility Wrappers ──────────────────────────────

class SuccessPopupIcon extends StatelessWidget {
  const SuccessPopupIcon({super.key});
  @override
  Widget build(BuildContext context) =>
      const PopupIcon(type: PopupType.success);
}

class PendingPopupIcon extends StatelessWidget {
  const PendingPopupIcon({super.key});
  @override
  Widget build(BuildContext context) =>
      const PopupIcon(type: PopupType.pending);
}

class ErrorPopupIcon extends StatelessWidget {
  const ErrorPopupIcon({super.key});
  @override
  Widget build(BuildContext context) => const PopupIcon(type: PopupType.error);
}

class ConfirmPopupIcon extends StatelessWidget {
  const ConfirmPopupIcon({super.key});
  @override
  Widget build(BuildContext context) =>
      const PopupIcon(type: PopupType.confirm);
}

class OfflinePopupIcon extends StatelessWidget {
  const OfflinePopupIcon({super.key});
  @override
  Widget build(BuildContext context) =>
      const PopupIcon(type: PopupType.offline);
}
