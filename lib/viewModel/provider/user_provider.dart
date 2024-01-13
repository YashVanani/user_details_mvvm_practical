import 'package:flutter/material.dart';
import 'package:users_details_mvvm/main.dart';
import 'package:users_details_mvvm/model/db_user_model/user_data_model.dart';
import 'package:users_details_mvvm/model/repository/user_repository.dart';
import 'package:users_details_mvvm/utils/app_color.dart';
import 'package:users_details_mvvm/utils/app_constant.dart';
import 'package:users_details_mvvm/viewModel/local/db_operations.dart';

class UserProvider extends ChangeNotifier {
  UserRepository userRepository = UserRepository();
  List<UserDetailsDBModel> users = [];
  int currentPage = 1;
  bool isLoading = false;
  ScrollController scrollController = ScrollController();

  Future<void> getUsers() async {
    if (isLoading) return;
    try {
      isLoading = true;
      if (currentPage == 1) {
        await DBOperations.deleteAll();
        await userRepository.getUsersAndStore();
      }
      final usersDB = await DBOperations.readAllUserDetailsPagination(currentPage);
      users = usersDB;
      isLoading = false;
      currentPage++;
      notifyListeners();
    } catch (error) {
      isLoading = false;
      notifyListeners();
      SnackBar snackBar = AppConstant.snackBarStyle(error.toString(), AppColors.secondaryColor);
      snackBarKey.currentState?.showSnackBar(snackBar);
    }
  }

  scrollListener() {
    if (scrollController.offset >= (scrollController.position.maxScrollExtent) && !(scrollController.position.outOfRange)) {
      getUsers();
      notifyListeners();
    }
  }
}
