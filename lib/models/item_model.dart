class Item{
  const Item({
    this.id,
    this.name,
    this.price,
    this.pic ,
    this.category,
    this.barcode ,
    this.description, 
  });
  final int? id;
  final String? name;
  final String? price;
  final String? pic;
  final String? category;
  final String? barcode;
  final String? description;
  
  factory Item.fromJSON(Map<String, dynamic> json){
    return Item(
      id : json['id'] ?? 0,
      name : json['name'] ?? '',
      price : json['price'].toString(),
      pic : json['pic'] ?? 'N/A',
      category : json['category'] ?? 'none',
      barcode : json['barcode'] ?? 'N/A',
      description: json['description']??''
    );
  }
}
