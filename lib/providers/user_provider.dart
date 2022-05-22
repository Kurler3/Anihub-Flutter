import 'package:anihub_flutter/back_end_methods/database_methods.dart';
import 'package:anihub_flutter/models/user.dart';
import 'package:flutter/cupertino.dart';

import '../classes/anime/anime.dart';

class UserProvider extends ChangeNotifier {
  UserModel? _user;

  get getUser => _user;

  // FUNCTION TO FETCH NEW USER DATA (RELOAD).
  Future fetchUserDetails() async {
    // FETCH DETAILS OF LOGGED USER.
    _user = await DatabaseMethods().getUserDetails();

    debugPrint("User: " + _user!.email);

    notifyListeners();
  }

  Future addRemoveFavoriteAnime(bool isAdd, Anime animeData) async {
    _user = await DatabaseMethods().addRemoveFavoriteAnime(isAdd, animeData);

    notifyListeners();
  }
}
