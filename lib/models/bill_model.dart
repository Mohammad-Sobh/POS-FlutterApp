class Bill{
  const Bill({
    this.id = 0,
    this.date = '00/00/0000',
    this.total = '00.00',
    this.description
  });
  final int? id; 
  final String? date;
  final String? total; 
  final String? description;
  factory Bill.fromJSON(Map<String, dynamic> json){
    return Bill(
      id : json['id'] ?? 0,
      date : json['date'] ?? '00-00-0000',
      total : json['total'].toString(),
      description: json['description'] ?? ''
    );}
  
}