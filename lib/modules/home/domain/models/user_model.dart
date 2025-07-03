class UserModel {
  final String name;
  final String avatarUrl;
  
  UserModel({required this.name, required this.avatarUrl});
  
  factory UserModel.fromFirebase() {
    return UserModel(
      name: 'Caio Máximo',
      avatarUrl: 'assets/images/avatar-man.png',
    );
  }
}