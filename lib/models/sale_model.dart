import 'item_model.dart';

class Sale{
  const Sale({
    this.id = 0,
    this.date = '00/00/0000',
    this.total = '00.00',
    this.items,
    this.discount = '00.00',
  });
  final int? id; 
  final String? date;
  final String? total; 
  final List<Item>? items; 
  final String? discount; 
  factory Sale.fromJSON(Map<String, dynamic> json){
    return Sale(
      id : json['id'],
      date : json['date'],
      total : json['total'].toString(),
      items : (json['items'] as List<dynamic>?)?.map((e) => 
        Item.fromJSON(e as Map<String, dynamic>)).toList(),
      discount : json['discount'].toString(),
    );}
  
}