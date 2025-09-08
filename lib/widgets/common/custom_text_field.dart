import 'package:flutter/material.dart';
import 'package:ui_ecommerce/theme/app_theme.dart';

class CustomTextField extends StatefulWidget {
  final String? labelText;
  final String? hintText;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final bool obscureText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final VoidCallback? onSuffixIconPressed;
  final bool enabled;
  final int? maxLines;
  final EdgeInsetsGeometry? contentPadding;

  const CustomTextField({
    super.key,
    this.labelText,
    this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.controller,
    this.validator,
    this.keyboardType,
    this.onSuffixIconPressed,
    this.enabled = true,
    this.maxLines = 1,
    this.contentPadding,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Color?> _borderColorAnimation;
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _borderColorAnimation = ColorTween(
      begin: Colors.grey.shade300,
      end: AppTheme.primaryColor,
    ).animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onFocusChange(bool hasFocus) {
    setState(() {
      _isFocused = hasFocus;
    });
    if (hasFocus) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _borderColorAnimation,
      builder: (context, child) {
        return Focus(
          onFocusChange: _onFocusChange,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: AppTheme.inputRadius,
              boxShadow: _isFocused ? AppTheme.cardShadow : null,
            ),
            child: TextFormField(
              controller: widget.controller,
              obscureText: widget.obscureText,
              validator: widget.validator,
              keyboardType: widget.keyboardType,
              enabled: widget.enabled,
              maxLines: widget.maxLines,
              style: const TextStyle(
                fontSize: 16,
                color: AppTheme.textPrimary,
              ),
              decoration: InputDecoration(
                labelText: widget.labelText,
                hintText: widget.hintText,
                prefixIcon: widget.prefixIcon != null
                    ? Icon(
                        widget.prefixIcon,
                        color: _isFocused ? AppTheme.primaryColor : AppTheme.textSecondary,
                      )
                    : null,
                suffixIcon: widget.suffixIcon != null
                    ? IconButton(
                        icon: Icon(
                          widget.suffixIcon,
                          color: _isFocused ? AppTheme.primaryColor : AppTheme.textSecondary,
                        ),
                        onPressed: widget.onSuffixIconPressed,
                      )
                    : null,
                filled: true,
                fillColor: AppTheme.surfaceColor,
                border: OutlineInputBorder(
                  borderRadius: AppTheme.inputRadius,
                  borderSide: BorderSide(color: _borderColorAnimation.value!),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: AppTheme.inputRadius,
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: AppTheme.inputRadius,
                  borderSide: const BorderSide(color: AppTheme.primaryColor, width: 2),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: AppTheme.inputRadius,
                  borderSide: const BorderSide(color: AppTheme.errorColor),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: AppTheme.inputRadius,
                  borderSide: const BorderSide(color: AppTheme.errorColor, width: 2),
                ),
                contentPadding: widget.contentPadding ?? 
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                labelStyle: TextStyle(
                  color: _isFocused ? AppTheme.primaryColor : AppTheme.textSecondary,
                ),
                hintStyle: const TextStyle(
                  color: AppTheme.textLight,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}