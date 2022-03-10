import 'package:flutter/material.dart';

class CommonSingleChildScroll extends StatelessWidget {
  final Widget childWidget;

  const CommonSingleChildScroll({
    Key? key,
    required this.childWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints viewportConstraints) {
        return SingleChildScrollView(
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
