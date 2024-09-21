import 'package:flutter/material.dart';

class GeneralSection extends StatelessWidget {
  final IconData? icon;
  final IconData? suffixIcon;
  final void Function()? suffixIconOnTap;
  final String name;
  final Widget content;
  final double gap;

  const GeneralSection({
    super.key,
    this.icon,
    this.suffixIcon,
    this.suffixIconOnTap,
    required this.name,
    required this.content,
    this.gap = 4.0,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (icon != null)
          Column(
            children: [
              const SizedBox(height: 2),
              Icon(
                icon,
                size: 16,
              ),
            ],
          ),
        if (icon != null) SizedBox(width: gap),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  if (suffixIcon != null) SizedBox(width: gap),
                  if (suffixIcon != null)
                    GestureDetector(
                      onTap: suffixIconOnTap,
                      child: Icon(
                        suffixIcon,
                        size: 16,
                      ),
                    ),
                ],
              ),
              SizedBox(height: gap),
              content,
            ],
          ),
        ),
      ],
    );
  }
}
