class UserModel {
  final String userName;
  final int userId;
  final String email;
  final String companyName;
  final String roleName;
  final String empImagePath;

  UserModel({
    required this.userName,
    required this.userId,
    required this.email,
    required this.companyName,
    required this.roleName,
    required this.empImagePath,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userName: json['UserName'],
      userId: json['UserId'],
      email: json['Email'],
      companyName: json['CompanyName'],
      roleName: json['RoleName'],
      empImagePath: json['EmpImagePath'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'UserName': userName,
      'UserId': userId,
      'Email': email,
      'CompanyName': companyName,
      'RoleName': roleName,
      'EmpImagePath': empImagePath,
    };
  }
}
