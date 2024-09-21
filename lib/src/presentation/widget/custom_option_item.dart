import 'package:flutter/material.dart';

class CustomOptionItem extends StatelessWidget {
  final String text;
  final IconData? icon;
  final bool isSelected;
  final void Function()? onTap;
  final bool isTextExpanded;

  const CustomOptionItem({
    super.key,
    required this.text,
    this.icon,
    this.isSelected = false,
    this.onTap,
    this.isTextExpanded = false,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Ink(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 20,
          ),
          decoration: BoxDecoration(
            color: isSelected
                ? Theme.of(context).colorScheme.primary.withAlpha(100)
                : Theme.of(context).cardColor,
            border: Border.all(
              width: 1,
              color: Theme.of(context).colorScheme.primary.withAlpha(100),
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              icon != null ? Icon(icon) : const SizedBox(),
              icon != null ? const SizedBox(width: 4) : const SizedBox(),
              if (isTextExpanded) Expanded(child: buildText()) else buildText(),
            ],
          ),
        ),
      ),
    );
  }

  Text buildText() {
    return Text(
      text,
      textAlign: TextAlign.center,
      overflow: TextOverflow.ellipsis,
    );
  }
}
