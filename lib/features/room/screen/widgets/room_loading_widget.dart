import 'package:flutter/material.dart';
import 'package:flutter_template/assets/colors/app_colors.dart';
import 'package:shimmer/shimmer.dart';

/// {@template loading_room_widget.class}
/// Виджет, который выводится при загрузке экрана профиля.
/// {@endtemplate}
class LoadingRoomWidget extends StatelessWidget {
  /// Виджет-модель для экрана hotel

  /// {@macro loading_room_widget.class}
  const LoadingRoomWidget({super.key});

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
                SizedBox(height: 24),
                _BoxWidget(boxHeight: 270),
                SizedBox(height: 8),
                Padding(padding: EdgeInsets.only(right: 10), child: _BoxWidget(boxHeight: 30)),
                SizedBox(height: 13),
                Row(children: [
                  Expanded(child: Padding(padding: EdgeInsets.only(right: 10), child: _BoxWidget(boxHeight: 30))),
                  Expanded(child: Padding(padding: EdgeInsets.only(right: 100), child: _BoxWidget(boxHeight: 30))),
                ]),
                SizedBox(height: 8),
                Padding(padding: EdgeInsets.only(right: 150), child: _BoxWidget(boxHeight: 30)),
                SizedBox(height: 16),
                Padding(padding: EdgeInsets.only(right: 83), child: _BoxWidget(boxHeight: 38)),
                SizedBox(height: 16),
                _BoxWidget(boxHeight: 48),
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
