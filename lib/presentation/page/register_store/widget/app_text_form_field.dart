import 'package:flutter/material.dart';
import 'package:oneship_merchant_app/config/config.dart';

class AppTextFormField extends StatelessWidget {
  final bool isRequired;
  final bool? filled;
  final TextEditingController? controller;
  final String? hintText;
  final bool? enabled;
  final void Function()? onTap;
  const AppTextFormField({
    super.key,
    required this.isRequired,
    this.controller,
    this.hintText,
    this.filled,
    this.enabled,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      cursorHeight: 20,
      style: Theme.of(context).textTheme.bodySmall!.copyWith(
            fontSize: 14,
            color: filled == true ? Colors.grey : AppColors.textColor,
          ),
      onTap: onTap,
      enabled: enabled,
      decoration: InputDecoration(
        // floatingLabelBehavior: FloatingLabelBehavior.always,
        isDense: false,
        filled: filled,
        fillColor: const Color(0xffF9FAFB),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.borderColor,
          ),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.borderColor,
          ),
        ),
        border: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.borderColor,
          ),
        ),
        label: RichText(
          text: TextSpan(
            text: hintText,
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  fontSize: 14,
                  color:
                      filled == true ? Colors.grey : AppColors.placeHolderColor,
                ),
            children: [
              if (isRequired)
                const TextSpan(
                  text: ' *',
                  style: TextStyle(
                    color: Colors.red,
                  ),
                ),
            ],
          ),
        ),
        // hintText: 'Nhập họ và tên người đại diện',
      ),
    );
  }
}
