import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchBinding implements Bindings {
  @override
  void dependencies() => Get.put(SearchUserController());
}

class SearchUserController extends GetxController {
  final searchController = TextEditingController();
  final isShowUsers = false.obs;
}
