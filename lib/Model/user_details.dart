class UserDetailsModel {
  final String name;
  final String address;

  UserDetailsModel({required this.name, required this.address});

  Map<String, dynamic> getJson() => {
        'name': name,
        'address': address,
      };
      factory UserDetailsModel.getmodelfromjson(Map<String, dynamic> json){
        return UserDetailsModel(name: json["name"], address:json["address"]);

      }
}

UserDetailsModel peace = UserDetailsModel(name: "peace", address: "Somewhere");
