import 'package:anihub_flutter/utils/colors.dart';
import 'package:flutter/material.dart';

class SearchHistoryItem extends StatelessWidget {
  final String text;

  const SearchHistoryItem({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10.0, right: 10.0),
      width: MediaQuery.of(context).size.width,
      height: 50,
      decoration: BoxDecoration(
        color: Color(050505),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // TEXT
            Text(text),
            // REMOVE BTN
            IconButton(
                onPressed: () {
                  debugPrint("Remove item");
                },
                icon: const Icon(Icons.close))
          ],
        ),
      ),
    );
  }
}
