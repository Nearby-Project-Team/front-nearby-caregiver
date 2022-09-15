class User {
  late final String userId;
  late final String name;
  late final String email;
  late final String phoneNumber;

  late final List<UserOA>? elderlyList;

  User({
    required this.userId,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.elderlyList
  });

  factory User.fromJson(Map<String, dynamic> userMap, Map<String, dynamic>? OAList)
  {
    List<UserOA> elderlyList;
    if((OAList == null) || (OAList == [])) {
      elderlyList = [] as List<UserOA>;
    }
    else{
      var list = OAList['data'] as List;
      elderlyList = list.map((i) => UserOA.fromJson(i)).toList();
    }

    return User(
      userId: '200',
      name: userMap['name'],
      email: userMap['email'],
      phoneNumber: userMap['phone_number'],
      elderlyList: elderlyList
    );
  }
}

class UserOA {
  late final String elderlyId;
  late final String cgEmail;
  late final String elderlyName;
  late final String phoneNumber;

  UserOA({
    required this.elderlyId,
    required this.cgEmail,
    required this.elderlyName,
    required this.phoneNumber
  });

  factory UserOA.fromJson(Map<String, dynamic> userMap)
  {
    return UserOA(
      elderlyId: userMap['elderly_id'],
      cgEmail: userMap['email'],
      elderlyName: userMap['name'],
      phoneNumber: userMap['phone_number'],
    );
  }
}
