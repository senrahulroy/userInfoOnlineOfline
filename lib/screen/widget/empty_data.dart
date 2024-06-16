import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../utils/core.dart';

class EmptyData extends StatelessWidget {
  const EmptyData({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(AppAssets.emptyJson),
            Text(
            AppString.noData,
            style: AppTextStyle.nameStyle,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
