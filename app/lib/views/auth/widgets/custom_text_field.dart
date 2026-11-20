import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../theme/app_theme.dart';

class CustomTextField extends StatefulWidget {
  final String label;
  final String hint;
  final bool isPassword;
  final TextInputType keyboardType;
  final TextEditingController? controller;
  final TextInputAction? textInputAction;

  const CustomTextField({
    super.key,
    required this.label,
    required this.hint,
    this.isPassword = false,
    this.keyboardType = TextInputType.text,
    this.controller,
    this.textInputAction,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool _obscureText;
  final focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _obscureText = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final customColors = context.customColors;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label
        Text(
          widget.label,
          style: GoogleFonts.poppins(
            color: theme.colorScheme.onSurface,
            fontSize: 13.5,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 7),

        // Text Field Container (inherits InputDecorationTheme from ThemeData)
        TextField(
          controller: widget.controller,
          obscureText: _obscureText,
          textInputAction: widget.textInputAction,
          focusNode: focusNode,
          onTapOutside: (event) => focusNode.unfocus(),
          keyboardType: widget.keyboardType,
          style: GoogleFonts.poppins(
            color: theme.colorScheme.onSurface,
            fontSize: 14.5,
            fontWeight: FontWeight.w500,
          ),
          decoration: InputDecoration(
            hintText: widget.hint,
            suffixIcon: widget.isPassword
                ? IconButton(
                    icon: Icon(
                      _obscureText
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                      color: customColors.textPlaceholder,
                      size: 20,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                  )
                : null,
          ),
        ),
      ],
    );
  }
}
