import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:users_details_mvvm/utils/app_string.dart';
import 'package:users_details_mvvm/view/screens/user_details_screen.dart';
import 'package:users_details_mvvm/viewModel/provider/user_provider.dart';
import '../../utils/app_constant.dart';

class UserListScreen extends StatefulWidget {
  const UserListScreen({super.key});

  @override
  _UserListScreenState createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  @override
  void initState() {
    super.initState();
    getUserData();
  }

  getUserData() async {
    Provider.of<UserProvider>(context, listen: false).scrollController.addListener(Provider.of<UserProvider>(context, listen: false).scrollListener);
    await Provider.of<UserProvider>(context, listen: false).getUsers();
  }

  @override
  Widget build(BuildContext context) {
    final userViewModel = Provider.of<UserProvider>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStringRes.userListString),
      ),
      body: Provider.of<UserProvider>(context, listen: false).users.isNotEmpty
          ? Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    controller: userViewModel.scrollController,
                    itemCount: userViewModel.users.length,
                    itemBuilder: (context, index) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        userListComponent(userViewModel, index, context),
                        if (index != userViewModel.users.length - 1) ...[
                          const Divider(
                            endIndent: 20,
                            indent: 15,
                            color: Colors.black,
                            thickness: 0.5,
                          ),
                          const SizedBox(height: 10),
                        ]
                      ],
                    ),
                  ),
                ),
                if (userViewModel.isLoading) ...[
                  Center(
                    child: AppConstant.circularProgressIndicator(),
                  )
                ]
              ],
            )
          : Center(
              child: AppConstant.circularProgressIndicator(),
            ),
    );
  }

  userListComponent(UserProvider userViewModel, int index, BuildContext context) {
    return ListTile(
      leading: SizedBox(
        height: 45,
        width: 45,
        child: CachedNetworkImage(
          imageUrl: userViewModel.users[index].profileImage,
          imageBuilder: (context, imageProvider) {
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7),
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.fill,
                ),
              ),
            );
          },
          progressIndicatorBuilder: (context, url, downloadProgress) {
            return Center(
              child: SizedBox(
                width: 20,
                height: 20,
                child: AppConstant.circularProgressIndicator(
                  color: Colors.blue,
                ),
              ),
            );
          },
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
      ),
      title: Row(
        children: [
          Expanded(child: Text(userViewModel.users[index].name, style: AppConstant.mainTextStyle(fontSize: 15, fontWeight: FontWeight.bold))),
          Text(AppConstant.formatDate(userViewModel.users[index].joinDate), style: AppConstant.mainTextStyle(fontSize: 10)),
          const SizedBox(width: 5),
          const Icon(Icons.arrow_forward_ios, size: 12),
        ],
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(userViewModel.users[index].email, style: AppConstant.mainTextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
          Text('${AppStringRes.countrySecondString} ${userViewModel.users[index].country}', style: AppConstant.mainTextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
        ],
      ),
      onTap: () {
        Navigator.of(context).push(
          CupertinoPageRoute<bool>(
            builder: (BuildContext context) => UserDetailsScreen(user: userViewModel.users[index]),
          ),
        );
      },
    );
  }
}
