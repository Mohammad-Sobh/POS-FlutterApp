import 'api_service.dart';
import 'package:pos_app/models/bill_model.dart';

class BillService {
  static final _path = 'UserStock';
  static Future<bool> AddBill(
      {required Map<String, dynamic> auth,
      required String description,
      required String total}) async {
    try {
      await APIService.makeRequest('$_path/AddBill', {
        'phone': auth['phone'],
        'userId': auth['userId'].toString(),
        'description': description,
        'total' : total
      });
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  static Future<List<Bill>> getBills(Map<String, dynamic> auth) async {
    try {
      var res = await APIService.makeRequest('$_path/GetBills', {
        'phone': auth['phone'],
        'userId': auth['userId'].toString(),
      });

      List<Bill> Bills = []; //refactor code if needed
      res?.forEach((e) => Bills.add(Bill.fromJSON(e as Map<String, dynamic>)));
      return Bills;
    } catch (e) {
      return List.empty();
    }
  }
}
