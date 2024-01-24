import 'package:flutter/material.dart';
import 'package:flutter_template/assets/text/text_style.dart';
import 'package:flutter_template/features/common/widgets/app_button_widget.dart';

/// {@template app_error_widget.class}
/// Виджет, который выводится при загрузке экрана профиля.
/// {@endtemplate}
class AppErrorWidget extends StatelessWidget {
  /// {@macro app_error_widget.class}

  final VoidCallback? onPressed;

  const AppErrorWidget({
    super.key,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Spacer(),
          Text(
            'Упс!',
            style: AppTextStyle.medium18.value,
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Text(
              'Что-то пошло не так...',
              style: AppTextStyle.medium18.value,
            ),
          ),
          AppButtonWidget(
            title: 'Повторить',
            onPressed: onPressed,
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
