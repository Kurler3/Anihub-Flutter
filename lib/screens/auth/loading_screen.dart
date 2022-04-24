import 'package:anihub_flutter/utils/colors.dart';
import 'package:anihub_flutter/utils/constants.dart';
import 'package:anihub_flutter/widgets/rotating_image.dart';
import 'package:flutter/material.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          RotatingImage(
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: Image.asset(
                appLogoAbsolutePath,
                fit: BoxFit.fill,
              ),
            ),
            isRotating: true,
          ),
          const SizedBox(
            height: 15,
          ),
          const Text('Fetching data...'),
          const CircularProgressIndicator(
            color: mainOrange,
          ),
        ],
      ),
    );
  }
}
