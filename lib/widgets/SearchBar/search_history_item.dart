import 'package:anihub_flutter/providers/search_history_provider.dart';
import 'package:anihub_flutter/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchHistoryItem extends StatelessWidget {
  final String text;
  final Function(String value)? onSubmit;
  final int index;

  const SearchHistoryItem({
    Key? key,
    required this.text,
    required this.onSubmit,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10.0, right: 10.0),
      width: MediaQuery.of(context).size.width,
      height: 50,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(5.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: InkWell(
        onTap: () {
          onSubmit!(text);
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // TEXT
              Text(
                text,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              // REMOVE BTN
              IconButton(
                  onPressed: () {
                    Provider.of<SearchHistoryProvider>(context, listen: false)
                        .removeFromSearchHistory(index);
                  },
                  icon: const Icon(Icons.close))
            ],
          ),
        ),
      ),
    );
  }
}
