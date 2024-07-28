import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:social_clone/pages/Auth/controller/auth_controller.dart';
import 'package:social_clone/pages/addPost/controller/addpost_controller.dart';
import 'package:social_clone/pages/homepage/controller/homecontroller.dart';
import 'package:social_clone/pages/search/controller/search_controller.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthController(), permanent: true);
    Get.put(AddPostController(), permanent: true);
    Get.put(HomeController(), permanent: true);
    Get.put(SearchUserController(), permanent: true);
  }
}
