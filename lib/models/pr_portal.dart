import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class PRPortal extends ChangeNotifier {
  late bool isLoggedIn;
  String? token, username;
  late Box hiveBox;

  PRPortal() {
    // Open the database
    this.hiveBox = Hive.box("LOCAL_STORAGE");

    if (dataExistsOnLocalStorage()) {
      // Load existing data
      loadData();
    } else {
      // Initialize default data
      setDefaultData();

      // Save data
      saveData();
    }
  }

  bool dataExistsOnLocalStorage() {
    return this.hiveBox.get("isLoggedIn") != null;
  }

  setDefaultData() {
    this.isLoggedIn = false;
    this.token = null;
    this.username = null;
  }

  void loadData() {
    this.isLoggedIn = this.hiveBox.get("isLoggedIn");
    this.token = this.hiveBox.get("token");
    this.username = this.hiveBox.get("username");
  }

  void saveData() {
    this.hiveBox.put("isLoggedIn", this.isLoggedIn);
    this.hiveBox.put("token", this.token);
    this.hiveBox.put("username", this.username);
  }

  void setLoggedIn(bool loggedIn, String? username) {
    this.isLoggedIn = loggedIn;
    this.username = username;
    saveData();
    notifyListeners();
  }

  void setToken(String token) {
    this.token = token;
    saveData();
    notifyListeners();
  }

  void refresh() {
    notifyListeners();
  }
}
