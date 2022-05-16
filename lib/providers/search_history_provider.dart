import 'package:flutter/cupertino.dart';

class SearchHistoryProvider extends ChangeNotifier {
  final List<String> _searchHistory = [];

  List<String> get getSearchHistory => _searchHistory;

  // FUNCTION THAT ADDS A STRING WHEN USER SEARCHS SOMETHING NEW
  void addToSearchHistory(String searchInput) {
    _searchHistory.insert(0, searchInput);

    notifyListeners();
  }

  // FUNCTION THAT REMOVES A STRING WHEN USER SEARCHS SOMETHING NEW
  void removeFromSearchHistory(int indexToRemove) {
    _searchHistory.removeAt(indexToRemove);

    notifyListeners();
  }
}
