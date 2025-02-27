import 'package:pos_app/models/item_model.dart';
import 'api_service.dart';

class ItemService {
  static final _path = 'UserStock';
  static Future<bool> addItem({required Map<String, dynamic> auth,
  required String name,
  required String price,
  required String category,
  required String description,
  required String pic,
  required String barcode}) async {
    try{
      await APIService.makeRequest('$_path/AddItem', {
        'phone': auth['phone'],
        'userId': auth['userId'].toString(),
        'name': name,
        'price': price,
        'pic': pic,
        'category': category,
        'description':description,
        'barcode': barcode
        });
        return true;
    }
    catch(e){
      print(e.toString());
      return false;
    }
  }
  static Future<bool> editItem({required Map<String, dynamic> auth,
  required int id,
  required String? name,
  required String? price,
  required String? category,
  required String? description,
  required String? pic,
  required String? barcode}) async {
    try{
      await APIService.makeRequest('$_path/EditItem', {
        'phone': auth['phone'],
        'userId': auth['userId'].toString(),
        'itemId': id.toString(),
        'name': name,
        'price': price,
        'pic': pic,
        'category': category,
        'description':description,
        'barcode': barcode
        });
        return true;
    }
    catch(e){
      print(e.toString());
      return false;
    }
  }
  static Future<List<Item>> getItems({required Map<String, dynamic> auth, 
  required String category}) async {
    try{
      var res = await APIService.makeRequest('$_path/GetItems', {
        'phone': auth['phone'],
        'userId': auth['userId'].toString(),
        'category': category,
        });
        List<Item> items = [];
        res?.forEach((e) =>
          items.add(Item.fromJSON(e as Map<String, dynamic>)));
        return items;
    }
    catch(e){
      print(e.toString());
      return List.empty();
      }
  }
  static Future<bool> removeItem(Map<String, dynamic> auth, int itemId) async {
    try{
      await APIService.makeRequest('$_path/RemoveItem', {
        'phone': auth['phone'],
        'userId': auth['userId'].toString(),
        'itemId': itemId.toString(),
        });
        return true;
    }
    catch(e){
      print(e.toString());
      return false;
    }
  }
}
    // item service
    // -AddItem
    // -GetItems
    // -RemoveItem