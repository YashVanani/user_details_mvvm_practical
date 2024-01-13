import 'package:users_details_mvvm/utils/app_string.dart';

class UserDetailsDBModel {
  final int? id;
  final String name;
  final String email;
  final String dob;
  final String joinDate;
  final String profileImage;
  final String country;
  final String city;
  final String state;
  final String postcode;
  final int? age;

  const UserDetailsDBModel({
    this.id,
    required this.name,
    required this.email,
    required this.dob,
    required this.joinDate,
    required this.profileImage,
    required this.country,
    required this.city,
    required this.state,
    required this.postcode,
    required this.age,
  });

  static UserDetailsDBModel fromJson(Map<String, Object?> json) => UserDetailsDBModel(
        id: json[UserDetailsFields.id] as int?,
        name: json[UserDetailsFields.name] as String,
        email: json[UserDetailsFields.email] as String,
        dob: json[UserDetailsFields.dob] as String,
        joinDate: json[UserDetailsFields.joinDate] as String,
        profileImage: json[UserDetailsFields.profileImage] as String,
        country: json[UserDetailsFields.country] as String,
        city: json[UserDetailsFields.city] as String,
        state: json[UserDetailsFields.state] as String,
        postcode: json[UserDetailsFields.postcode] as String,
        age: json[UserDetailsFields.age] as int?,
      );

  Map<String, Object?> toJson() => {
        UserDetailsFields.id: id,
        UserDetailsFields.name: name,
        UserDetailsFields.email: email,
        UserDetailsFields.dob: dob,
        UserDetailsFields.joinDate: joinDate,
        UserDetailsFields.profileImage: profileImage,
        UserDetailsFields.country: country,
        UserDetailsFields.city: city,
        UserDetailsFields.state: state,
        UserDetailsFields.postcode: postcode,
        UserDetailsFields.age: age,
      };
}
