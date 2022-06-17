import 'package:shared_preferences/shared_preferences.dart';

class UserData {
  Future<bool> setName(String name) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString("name", name);
  }

  Future<bool> setNim(String nim) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString("nim", nim);
  }

  Future<bool> setDate(String date) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString("date", date);
  }

  Future<bool> setDistance(String distance) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString("distance", distance);
  }

  Future<String> getName() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("name") ?? '';
  }

  Future<String> getNim() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("nim") ?? '';
  }

  Future<String> getDate() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("date") ?? '';
  }

  Future<String> getDistance() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("distance") ?? '';
  }
}
