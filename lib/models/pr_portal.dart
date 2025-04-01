import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class PRPortal extends ChangeNotifier {
  late bool isLoggedIn;
  String? token;
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
  }

  void loadData() {
    this.isLoggedIn = this.hiveBox.get("isLoggedIn");
    this.token = this.hiveBox.get("token");
  }

  void saveData() {
    this.hiveBox.put("isLoggedIn", this.isLoggedIn);
    this.hiveBox.put("token", this.token);
  }

  void setLoggedIn(bool loggedIn) {
    this.isLoggedIn = loggedIn;
    saveData();
    notifyListeners();
  }

  void setToken(String token) {
    this.token = token;
    saveData();
    notifyListeners();
  }

  void notifyListeners() {
    notifyListeners();
  }
}
