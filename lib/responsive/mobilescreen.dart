import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_clone/pages/addPost/views/addpost.dart';
import 'package:social_clone/pages/homepage/controller/homecontroller.dart';
import 'package:social_clone/pages/homepage/views/homepage.dart';
import 'package:social_clone/pages/profile/view/profile.dart';
import 'package:social_clone/pages/search/views/search_page.dart';
import 'package:social_clone/utils/colors.dart';

class MobileScreenLayout extends StatefulWidget {
  const MobileScreenLayout({Key? key}) : super(key: key);

  @override
  State<MobileScreenLayout> createState() => _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends State<MobileScreenLayout> {
  late HomeController controller;

  List<Widget> _tabs = [
    HomePage(),
    SearchScreen(),
    AddPostView(),
    HomePage(),
    ProfilePage(uid: FirebaseAuth.instance.currentUser!.uid)
  ];

  @override
  void initState() {
    super.initState();
    controller = Get.put(HomeController());
  }

  void _updateTab(int index) {
    controller.selectedIndex.value = index;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => _tabs[controller.selectedIndex.value]),
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: Colors.black,
      //   elevation: 0,
      //   onPressed: () => _updateTab(2),
      //   child: Icon(
      //     Icons.add_circle,
      //     color: primaryColor,
      //     size: 30,
      //   ),
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: Obx(
        () => BottomAppBar(
          color: Colors.black,
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildTabButton(
                context,
                index: 0,
                icon: Icons.home,
              ),
              _buildTabButton(
                context,
                index: 1,
                icon: Icons.search,
              ),
              _buildTabButton(
                context,
                index: 2,
                icon: Icons.add_circle,
              ),
              _buildTabButton(
                context,
                index: 3,
                icon: Icons.favorite,
              ),
              _buildTabButton(
                context,
                index: 4,
                icon: Icons.person,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTabButton(
    BuildContext context, {
    required int index,
    required IconData icon,
  }) {
    return IconButton(
      icon: Icon(
        icon,
        color: controller.selectedIndex.value == index
            ? primaryColor
            : secondaryColor,
      ),
      onPressed: () => _updateTab(index),
    );
  }
}
