import 'package:anihub_flutter/back_end_methods/database_methods.dart';
import 'package:anihub_flutter/models/user.dart';
import 'package:flutter/cupertino.dart';

class UserProvider extends ChangeNotifier {
  UserModel? _user;

  UserModel? get getUser => _user;

  // FUNCTION TO FETCH NEW USER DATA (RELOAD).
  void fetchUserDetails() async {
    // FETCH DETAILS OF LOGGED USER.

    _user = await DatabaseMethods().getUserDetails();

    notifyListeners();
  }
}
