import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:users_details_mvvm/model/db_user_model/user_data_model.dart';
import 'package:users_details_mvvm/utils/app_color.dart';
import 'package:users_details_mvvm/utils/app_constant.dart';
import 'package:users_details_mvvm/utils/app_string.dart';

class UserDetailsScreen extends StatelessWidget {
  final UserDetailsDBModel user;

  const UserDetailsScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.appBarColor,
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_back_ios, size: 22)),
        title: Text(user.name, style: AppConstant.mainTextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * .03),
          userImgDetails(context),
          userLocationDetails(),
        ],
      ),
    );
  }

  userLocationDetails() {
    return Padding(
      padding: const EdgeInsets.only(left: 50, top: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppConstant.divider(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${AppStringRes.emailString} ${user.email}', style: AppConstant.mainTextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
              Text('${AppStringRes.dateJoinedString} ${AppConstant.formatDate(user.joinDate)}',
                  style: AppConstant.mainTextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
              Text('${AppStringRes.dobString} ${AppConstant.dateFormat(user.dob)}', style: AppConstant.mainTextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 25),
          Text(AppStringRes.locationString, style: AppConstant.mainTextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
          AppConstant.divider(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${AppStringRes.cityString} ${user.city}', style: AppConstant.mainTextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
              Text('${AppStringRes.countryString} ${user.country}', style: AppConstant.mainTextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
              Text('${AppStringRes.postcodeString} ${user.postcode}', style: AppConstant.mainTextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
            ],
          ),
        ],
      ),
    );
  }

  userImgDetails(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * .24,
            width: MediaQuery.of(context).size.width * .5,
            child: CachedNetworkImage(
              imageUrl: user.profileImage,
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
                    width: 30,
                    height: 30,
                    child: AppConstant.circularProgressIndicator(
                      color: AppColors.secondaryColor,
                    ),
                  ),
                );
              },
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              width: 35,
              height: 35,
              decoration: const BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
              ),
              child: Center(child: Text(user.age.toString(), style: AppConstant.mainTextStyle(fontSize: 14, fontWeight: FontWeight.bold))),
            ),
          ),
        ],
      ),
    );
  }
}
