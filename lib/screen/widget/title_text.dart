import 'package:flutter/material.dart';

import '../../utils/core.dart';

class TitleText extends StatelessWidget {
  const TitleText({
    super.key,
    this.color,
    required this.title,
    this.maxLines = 1,
    this.textAlign = TextAlign.right,
    this.textSize = TextSizes.small,
  });

  final Color? color;
  final String title;
  final int maxLines;
  final TextAlign? textAlign;
  final TextSizes textSize;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textAlign: textAlign,
      style: textSize == TextSizes.small
          ? Theme.of(context).textTheme.titleMedium!.apply(color: color)
          : textSize == TextSizes.medium
              ? Theme.of(context)
                  .textTheme
                  .headlineLarge!
                  .apply(color: color, fontWeightDelta: 10)
              : textSize == TextSizes.large
                  ? Theme.of(context)
                      .textTheme
                      .displayMedium!
                      .apply(color: color, fontWeightDelta: 10)
                  : Theme.of(context).textTheme.titleLarge!.apply(color: color),
      overflow: TextOverflow.ellipsis,
      maxLines: maxLines,
    );
  }
}
