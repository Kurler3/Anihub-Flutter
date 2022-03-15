import 'package:anihub_flutter/utils/colors.dart';
import 'package:anihub_flutter/utils/constants.dart';
import 'package:anihub_flutter/widgets/common_elevated_button.dart';
import 'package:anihub_flutter/widgets/network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class PremadeImagePickerScreen extends StatefulWidget {
  // EITHER SHOW PRE-MADE BACKGROUND PICS OR PROFILE.
  final bool isBackgroundPic;

  final String? initiallySelectedPic;

  // FUNCTION THAT GETS CALLED WHEN CONFIRM ICON BUTTON IS PRESSED.
  final Function(String? selectedImage) onConfirmSelect;

  const PremadeImagePickerScreen({
    Key? key,
    required this.isBackgroundPic,
    required this.onConfirmSelect,
    this.initiallySelectedPic,
  }) : super(key: key);

  @override
  State<PremadeImagePickerScreen> createState() =>
      _PremadeImagePickerScreenState();
}

class _PremadeImagePickerScreenState extends State<PremadeImagePickerScreen> {
  String? selectedImage;

  @override
  void initState() {
    super.initState();

    selectedImage = widget.initiallySelectedPic;
  }

  @override
  Widget build(BuildContext context) {
    List<String> imagesArray =
        widget.isBackgroundPic ? backgroundPics : profilePics;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Choose a pre-made ${widget.isBackgroundPic ? "background" : "profile"} pic",
          style: const TextStyle(fontSize: 18),
        ),
        centerTitle: true,
        backgroundColor: backgroundColor,
      ),
      body: SizedBox(
        width: double.maxFinite,
        height: double.maxFinite,
        child: Column(
          children: [
            // IMAGES GRID
            Expanded(
              child: StaggeredGrid.count(
                crossAxisCount: 2,
                mainAxisSpacing: 5,
                children: imagesArray.map((image) {
                  bool isSelected =
                      selectedImage != null && image == selectedImage!;

                  return InkWell(
                    key: Key("pre-made-" + image),
                    // SET NEW SELECTED IMAGE
                    onTap: () => setState(() {
                      selectedImage = image;
                    }),
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        // IMAGE CONTAINER
                        Container(
                          // height: 100,
                          // IF SELECTED THEN SHOW BORDER
                          decoration: isSelected
                              ? BoxDecoration(
                                  border: Border.all(color: darkGrey, width: 3))
                              : null,
                          margin: const EdgeInsets.all(2),
                          child: CommonNetworkImage(
                            imageUrl: image,
                            boxFit: BoxFit.fill,
                          ),
                        ),

                        // SELECTED ICON
                        isSelected
                            ? Positioned(
                                // top: 0,
                                right: 0,
                                child: Container(
                                  child: const Icon(
                                    Icons.check,
                                    color: Colors.black,
                                  ),
                                  decoration: BoxDecoration(
                                    color: darkGrey,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                              )
                            : Container(),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
            // BUTTONS
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: CommonElevatedButton(
                    onPress: () {
                      Navigator.of(context).pop();
                    },
                    buttonChild: const Icon(
                      Icons.close,
                      color: iconColor,
                    ),
                    backgroundColor: Colors.red[600],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: CommonElevatedButton(
                    onPress: () => widget.onConfirmSelect(selectedImage),
                    buttonChild: const Icon(
                      Icons.check,
                      color: iconColor,
                    ),
                    backgroundColor: blue,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
