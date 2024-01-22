import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_template/assets/colors/app_colors.dart';
import 'package:flutter_template/assets/res/resources.dart';
import 'package:flutter_template/assets/text/text_style.dart';

class AppRatingWidget extends StatelessWidget {
  final int rating;
  final String ratingName;

  const AppRatingWidget({
    super.key,
    required this.rating,
    required this.ratingName,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            color: AppColors.orange.withOpacity(.2),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Row(
              children: [
                SvgPicture.asset(SvgIcons.iconStar),
                Text(
                  '$rating $ratingName',
                  style: AppTextStyle.medium16.value.copyWith(color: AppColors.orange),
                ),
              ],
            ),
          ),
        ),
        const Spacer(),
      ],
    );
  }
}
