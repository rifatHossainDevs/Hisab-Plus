import 'package:flutter/material.dart';

import '../../../../app/assets_path.dart';


class NoImage extends StatelessWidget {
  const NoImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      AssetsPath.noImage,
      fit: .scaleDown,
    );
  }
}
