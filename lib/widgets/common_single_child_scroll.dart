import 'package:flutter/material.dart';

class CommonSingleChildScroll extends StatelessWidget {
  final Widget childWidget;
  final ScrollController? scrollController;

  const CommonSingleChildScroll({
    Key? key,
    required this.childWidget,
    this.scrollController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints viewportConstraints) {
        return SingleChildScrollView(
          controller: scrollController,
          physics: const BouncingScrollPhysics(),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: viewportConstraints.maxHeight,
            ),
            child: IntrinsicHeight(
              child: childWidget,
            ),
          ),
        );
      },
    );
  }
}
