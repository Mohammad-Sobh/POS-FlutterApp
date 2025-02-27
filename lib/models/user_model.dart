class UserInfo{
  const UserInfo({
    this.userId,
    this.phone,
    this.active,
    this.shopName
  });
  final int? userId;
  final String? phone;
  final bool? active;
  final String? shopName;

  factory UserInfo.fromJSON(Map<String, dynamic> json){
    return UserInfo(
      userId : json['userId'],
      phone : json['phone'],
      active : json['active'],
      shopName : json['shopName'],
    );
  }
}

