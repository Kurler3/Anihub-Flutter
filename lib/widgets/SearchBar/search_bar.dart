import 'package:anihub_flutter/utils/colors.dart';
import 'package:anihub_flutter/widgets/SearchBar/search_history_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

class SearchBar extends StatefulWidget {
  // SEARCH HISTORY
  final List<String>? searchHistory;

  // PLACEHOLDER FOR SEARCH BAR
  final String placeHolder;

  // EDITING CONTROLLER.
  final TextEditingController editingController;

  // FUNCTION THAT UPDATES THE TEXT. (NOT REQUIRED)
  final Function? onChangeInput;

  // FUNCTION THAT IS CALLED WHEN SUBMITTED (NOT REQUIRED)
  final Function? onSubmit;

  // FUNCTION THAT IS CALLED WHEN TEXT IS CLEARED
  final Function? onClear;

  final double searchBarWidth;
  final double searchBarHeight;

  const SearchBar({
    Key? key,
    required this.placeHolder,
    required this.editingController,
    required this.searchBarWidth,
    required this.searchBarHeight,
    this.onChangeInput,
    this.onSubmit,
    this.onClear,
    this.searchHistory,
  }) : super(key: key);

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> with WidgetsBindingObserver {
  bool _isShowClearIcon = false;
  bool _isFocused = false;
  final FocusNode _searchNode = FocusNode();

  _handleShowClearIcon(newValue) {
    if (newValue.isNotEmpty && !_isShowClearIcon) {
      setState((() {
        _isShowClearIcon = true;
      }));
    } else if (newValue.isEmpty && _isShowClearIcon) {
      setState((() {
        _isShowClearIcon = false;
      }));
    }
  }

  @override
  void dispose() {
    super.dispose();

    _searchNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardVisibilityBuilder(
      builder: (BuildContext context, bool isKeyboardVisible) {
        return Stack(
          clipBehavior: Clip.none,
          children: [
            // SEARCH BAR
            _searchInput(isKeyboardVisible),
            // SEARCH HISTORY LIST
            widget.searchHistory != null &&
                    widget.searchHistory!.isNotEmpty &&
                    _isFocused &&
                    isKeyboardVisible
                ? _searchHistoryList()
                : Container(),
          ],
        );
      },
    );
  }

  Widget _searchHistoryList() {
    return Positioned(
      top: 50,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 400,
        child: Column(
          children: [
            // TITLE
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Row(
                  children: [
                    // ICON
                    const Icon(Icons.access_time_outlined),
                    // TITLE
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: RichText(
                        text: const TextSpan(children: [
                          // RECENT
                          TextSpan(
                            text: "Recent",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          // SEARCHES
                          TextSpan(
                            text: " Searches",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ]),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // ACTUAL LIST
            Expanded(
              child: ListView.builder(
                itemCount: widget.searchHistory!.length,
                itemBuilder: (BuildContext context, int index) {
                  return SearchHistoryItem(text: widget.searchHistory![index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _searchInput(bool isKeyBoardVisible) {
    return Container(
      width: widget.searchBarWidth,
      height: widget.searchBarHeight,
      decoration: BoxDecoration(
        // BLACK BACKGROUND
        color: backgroundColor,
        borderRadius: BorderRadius.circular(6.0),
        // border: Border.all(color: Colors.white),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 5,
            blurRadius: 4,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: // SEARCH BAR
          Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // SEARCH ICON
            const Icon(
              Icons.search,
              size: 28,
              color: mainGrey,
            ),

            // INPUT (TAKE REST OF AVAILABLE SPACE IN ROW)
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.only(left: 6.0, right: 6.0, bottom: 1.0),
                child: Focus(
                  onFocusChange: (hasFocus) {
                    setState(() {
                      _isFocused = hasFocus;
                    });
                  },
                  child: TextFormField(
                    showCursor: isKeyBoardVisible,
                    keyboardType: TextInputType.text,
                    controller: widget.editingController,
                    autofocus: false,
                    maxLines: 1,
                    textAlignVertical: TextAlignVertical.center,
                    decoration: InputDecoration(
                      hintText: widget.placeHolder,
                      border: InputBorder.none,
                    ),
                    onChanged: (newValue) {
                      _handleShowClearIcon(newValue);

                      if (widget.onChangeInput != null) {
                        widget.onChangeInput!(newValue);
                      }

                      if (newValue.isEmpty && widget.onClear != null) {
                        widget.onClear!();
                      }
                    },
                    onFieldSubmitted: (value) {
                      debugPrint(value);

                      if (value.isNotEmpty) {
                        if (widget.onSubmit != null) {
                          widget.onSubmit!(value);
                        }
                        // widget.editingController.clear();
                        // setState(() {
                        //   _isShowClearIcon = false;
                        // });
                      }
                    },
                  ),
                ),
              ),
            ),

            // CLEAR ICON
            _isShowClearIcon
                ? IconButton(
                    onPressed: () {
                      widget.editingController.clear();
                      setState(() {
                        _isShowClearIcon = false;
                      });

                      if (widget.onClear != null) {
                        widget.onClear!();
                      }
                    },
                    icon: const Icon(Icons.close),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
