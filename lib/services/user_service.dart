
import 'api_service.dart';
import 'package:pos_app/models/user_model.dart';

class UserService {
  static final _path = 'UserClass';
  static Future<UserInfo?>signIn(String phone, String password) async{
    try{
      var res = await APIService.makeRequest('$_path/SignIn', {
        'phone': phone,
        'password': password
        });
        return UserInfo.fromJSON(res);
    }
    catch(e){
      print(e.toString());
      return null;
      }
  }
  
  static Future<UserInfo?>signUp(String phone, String password)async{
    try{
      var res = await APIService.makeRequest('$_path/SignUp', {
        'phone': phone,
        'password': password
        });
        return UserInfo.fromJSON(res);
    }
    catch(e){
      print(e.toString());
      return null;
      }
  }

  static Future<bool>firstLogin({required UserInfo user,required String shopName ,required String cash})async{
    try{
      await APIService.makeRequest('$_path/FirstLogin', {
        'phone': user.phone,
        'userId': user.userId.toString(),
        'shopName': shopName,
        'cash': cash,
        });
        return true;
    }
    catch(e){
      print(e.toString());
      return false;
      }
  }
  //main
  static Future<String>getCash(Map<String, dynamic> auth)async{
    try{
      var res = await APIService.makeRequest('UserStock/GetCash', {
        'userId': auth['userId'].toString(),
        'phone': auth['phone'],
        });
        return res.toString();
    }
    catch(e){
      print(e.toString());
      return ('-1.0');
      }
  }
  //First login
  static Future<UserInfo?>refreshUser(Map<String, dynamic> auth)async{
    try{
      var res = await APIService.makeRequest('$_path/RefreshUser', {
        'userId': auth['userId'].toString(),
        'phone': auth['phone'],
        });
        return UserInfo.fromJSON(res);
    }
    catch(e){
      print(e);
      return null;
      }
  }
}
// user service 
//     -SignIn
//     -SignUp
//     -FirstLogin
//     -GetCash