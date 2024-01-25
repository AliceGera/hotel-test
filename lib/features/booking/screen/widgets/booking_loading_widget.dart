import 'package:flutter/material.dart';
import 'package:flutter_template/assets/colors/app_colors.dart';
import 'package:shimmer/shimmer.dart';

/// {@template loading_booking_widget.class}
/// Виджет, который выводится при загрузке экрана профиля.
/// {@endtemplate}
class BookingLoadingWidget extends StatelessWidget {
  /// Виджет-модель для экрана booking

  /// {@macro booking_room_widget.class}
  const BookingLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Shimmer.fromColors(
            baseColor: AppColors.gray.withOpacity(0.2),
            highlightColor: AppColors.white,
            child: const Column(
              children: [
                SizedBox(height: 8),
                _BoxWidget(boxHeight: 120),
                SizedBox(height: 8),
                _BoxWidget(boxHeight: 280),
                SizedBox(height: 8),
                _BoxWidget(boxHeight: 230),
                SizedBox(height: 8),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _BoxWidget extends StatelessWidget {
  final double boxHeight;

  const _BoxWidget({required this.boxHeight});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: AppColors.gray,
      ),
      child: SizedBox(height: boxHeight, width: double.infinity),
    );
  }
}
