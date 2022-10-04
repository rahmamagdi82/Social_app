import 'package:shared_preferences/shared_preferences.dart';

class CashHelper{
  static late SharedPreferences sharedPreferences;
  static initial() async{
   sharedPreferences=await SharedPreferences.getInstance();
  }

  static Future<bool> putData({
    required String key,
    required dynamic value
}) async{
    if(value is bool) return await sharedPreferences.setBool(key,value);
    if(value is int) return await sharedPreferences.setInt(key,value);
    if(value is String) return await sharedPreferences.setString(key,value);

    else return await sharedPreferences.setDouble(key,value);
  }

  static dynamic getData({
    required String key,
  }){
    return sharedPreferences.get(key);
  }

  static dynamic removeData({
    required String key,
  }){
    return sharedPreferences.remove(key);
  }

}