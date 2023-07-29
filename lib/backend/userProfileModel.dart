class UserProfile {
  String? name;
  DateTime? dateOfBirth;
  String? phone;
  String? profilePicUrl;
  String? profession;

  UserProfile({
    this.name,
    this.dateOfBirth,
    this.phone,
    this.profilePicUrl,
    this.profession,
  });

  // Convert UserProfile to Map
  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "dateOfBirth":
          dateOfBirth != null ? dateOfBirth!.toIso8601String() : null,
      "phone": phone,
      "profilePicUrl": profilePicUrl,
      "profession": profession,
    };
  }

  // Create UserProfile from Map
  static UserProfile fromMap(Map<String, dynamic> map) {
    return UserProfile(
      name: map['name'],
      dateOfBirth: map['dateOfBirth'] != null
          ? DateTime.parse(map['dateOfBirth'])
          : null,
      phone: map['phone'],
      profilePicUrl: map['profilePicUrl'],
      profession: map['profession'],
    );
  }
}
