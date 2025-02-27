import 'api_service.dart';
import 'package:pos_app/models/sale_model.dart';

class SaleService {
  static final _path = 'UserStock';
  static Future<bool> addSale(Map<String, dynamic> auth,Map<String, dynamic> body) async {
    try{
      await APIService.makeRequest('$_path/AddSale', {
        'phone': auth['phone'],
        'userId': auth['userId'].toString(),
        'itemsId':body['itemsId'],
        'discount':body['discount'],
        });
        return true;
    }
    catch(e){
      print(e.toString());
      return false;
      }

  }
  static Future<List<Sale>>getSales(Map<String, dynamic> auth)async{
    try{
      var res = await APIService.makeRequest('$_path/GetSales', {
        'phone': auth['phone'],
        'userId': auth['userId'].toString(),
        });

        List<Sale> sales = []; //refactor code if needed
        res?.forEach((e) =>
          sales.add(Sale.fromJSON(e as Map<String, dynamic>)));
        return sales;
    }
    catch(e){
      return List.empty();
      }
  }
}
