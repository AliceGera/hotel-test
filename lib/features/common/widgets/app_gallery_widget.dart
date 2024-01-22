// ignore: duplicate_ignore
// ignore_for_, duplicate_ignore-file: public_member_api_docs
// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:flutter_template/assets/colors/app_colors.dart';
import 'package:flutter_template/assets/text/text_style.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class AppGalleryWidget extends StatelessWidget {
  final List<String> imageUrls;
  final VoidCallback? onPressed;

  const AppGalleryWidget({
    super.key,
    this.onPressed,
    required this.imageUrls,
  });

  @override
  Widget build(BuildContext context) {
    final controllerRoom = PageController(keepPage: true);

    final pages = List.generate(
      imageUrls.length,
      (index) => Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.white,
        ),
        margin: const EdgeInsets.symmetric(horizontal: 1),
        child: AspectRatio(
          aspectRatio: 343 / 257,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20), // Image border
            child: SizedBox.fromSize(
              size: Size.fromRadius(12), // Image radius
              child: Image.network(
                imageUrls[index],
                fit: BoxFit.fill,
                loadingBuilder: (_, child, loadingProgress) => loadingProgress == null
                    ? child
                    : SizedBox(
                        height: 16,
                        width: 16,
                        child: Center(
                          child: CircularProgressIndicator(
                            strokeWidth: 1.5,
                            color: AppColors.gray.withOpacity(0.6),
                          ),
                        ),
                      ),
              ),
            ),
          ),
        ),
      ),
    );
    return Stack(
      children: [
        AspectRatio(
          aspectRatio: 343 / 257,
          child: SizedBox(
            child: PageView.builder(
              controller: controllerRoom,
              allowImplicitScrolling: true,
              itemBuilder: (_, index) {
                return pages[index % pages.length];
              },
            ),
          ),
        ),
        Column(
          children: [
            AspectRatio(
              aspectRatio: 343 / 232,
              child: Container(
                width: double.infinity,
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(5),
                ),
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: SmoothPageIndicator(
                  controller: controllerRoom,
                  count: 3,
                  effect: const WormEffect(
                    dotHeight: 7,
                    dotWidth: 7,
                    type: WormType.thinUnderground,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
