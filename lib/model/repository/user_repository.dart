import 'package:users_details_mvvm/model/apis/api_manager.dart';
import 'package:users_details_mvvm/model/db_user_model/user_data_model.dart';
import 'package:users_details_mvvm/model/user_model.dart';
import 'package:users_details_mvvm/utils/app_string.dart';
import 'package:users_details_mvvm/viewModel/local/db_operations.dart';

class UserRepository {
  final String apiUrl = 'https://randomuser.me/api/?results=100';

  Future<List<UserDetailsDBModel>> getUsersAndStore() async {
    final response = await APIManager.getAPICall(apiUrl);
    final Map<String, dynamic> data = response;
    final UserDetails myResults = UserDetails.fromJson(data);

    final List<UserDetailsDBModel> usersToStore = myResults.results!
        .map((json) => UserDetailsDBModel.fromJson({
              UserDetailsFields.name: '${json.name!.first} ${json.name!.last!}',
              UserDetailsFields.email: json.email,
              UserDetailsFields.dob: json.dob!.date,
              UserDetailsFields.joinDate: json.registered!.date,
              UserDetailsFields.city: json.location!.city,
              UserDetailsFields.country: json.location!.country,
              UserDetailsFields.state: json.location!.state,
              UserDetailsFields.postcode: json.location!.postcode.toString(),
              UserDetailsFields.profileImage: json.picture!.large,
              UserDetailsFields.age: json.dob!.age,
            }))
        .toList();

    for (var user in usersToStore) {
      await DBOperations().storeUserDetails(user);
    }
    return usersToStore;
  }
}
