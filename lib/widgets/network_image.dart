import 'package:anihub_flutter/utils/colors.dart';
import 'package:flutter/material.dart';

class CommonNetworkImage extends StatelessWidget {
  final String imageUrl;
  final BoxFit? boxFit;
  final Widget Function(BuildContext, Widget, ImageChunkEvent?)? loadingBuilder;

  const CommonNetworkImage({
    Key? key,
    required this.imageUrl,
    this.boxFit,
    this.loadingBuilder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.network(
      imageUrl,
      fit: boxFit ?? BoxFit.cover,
      loadingBuilder: loadingBuilder ??
          (BuildContext context, Widget child,
              ImageChunkEvent? loadingProgress) {
            if (loadingProgress == null) return child;
            return Center(
              child: CircularProgressIndicator(
                color: mainOrange,
                value: loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded /
                        loadingProgress.expectedTotalBytes!
                    : null,
              ),
            );
          },
    );
  }
}
