import 'package:shared_preferences/shared_preferences.dart';

getStoredValue(String type, String key) async {
  final prefs = await SharedPreferences.getInstance();
  if(type == 'String') {
    return prefs.getString(key) ?? 'hi@icyfeva.com';
  }

  return false;
}