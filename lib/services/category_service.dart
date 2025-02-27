import 'api_service.dart';

class CategoryService {
  static final _path = 'UserStock';
  static Future<bool> addCategory(Map<String, dynamic> auth, String name) async {
    try{
      await APIService.makeRequest('$_path/AddCategory', {
        'phone': auth['phone'],
        'userId': auth['userId'].toString(),
        'name': name,
        });
        return true;
    }
    catch(e){
      print(e.toString());
      return false;
    }

  }
  static Future<List<String>> getCategories(Map<String, dynamic> auth) async {
    try{
      var res = await APIService.makeRequest('$_path/GetCategories', {
        'phone': auth['phone'],
        'userId': auth['userId'].toString(),
        });
        List<String> categories = [];
        res?.forEach((e) => categories.add(e.toString()));
        return categories;
    }
    catch(e){
      print(e.toString());
      return List.empty();
      }

  }
  static Future<bool> removeCategory(Map<String, dynamic> auth, String name) async {
    try{
      await APIService.makeRequest('$_path/RemoveCategory', {
        'phone': auth['phone'],
        'userId': auth['userId'].toString(),
        'name' : name,
        });
        return true;
    }
    catch(e){
      print(e.toString());
      return false;
    }
  }
}
    // category service
    // -AddCategory
    // -GetCategories
    // -RemoveCategory