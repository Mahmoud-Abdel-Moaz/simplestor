class User {
    String? email;
    int? id;
    String? name;

    User({this.email, this.id, this.name});

    factory User.fromJson(Map<String, dynamic> json) {
        return User(
            email: json['email'], 
            id: json['id'], 
            name: json['name'], 
        );
    }

}