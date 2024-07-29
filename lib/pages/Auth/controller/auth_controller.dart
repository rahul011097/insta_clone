import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:typed_data';
import 'package:image_picker/image_picker.dart';
import 'package:social_clone/models/user.dart';
import 'package:social_clone/responsive/mobilescreen.dart';
import 'package:social_clone/responsive/responsive.dart';
import 'package:social_clone/responsive/webscreen.dart';
import 'package:social_clone/utils/utils.dart';
import 'package:social_clone/resources/auth_methods.dart';

class AuthBinding implements Bindings {
  @override
  void dependencies() => Get.put(AuthController());
}

class AuthController extends GetxController {
  final AuthMethods _authMethods = AuthMethods();
  var user = Rxn<User>();

  final isLoading = false.obs;
  final isSignupLoading = false.obs;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  TextEditingController emailControllerSignup = TextEditingController();
  TextEditingController passwordControllerSignup = TextEditingController();
  TextEditingController userNameControllerSignup = TextEditingController();
  TextEditingController bioControllerSignup = TextEditingController();
  Rx<Uint8List?> image = Rx<Uint8List?>(null);

  User? get getUser => user.value;

  @override
  void onInit() {
    super.onInit();
    refreshUser();
  }

  void loginUser() async {
    isLoading.value = true;
    String res = await AuthMethods().loginUser(
      email: emailController.text,
      password: passwordController.text,
    );
    if (res == 'success') {
      Get.offAll(
        () => const ResponsiveLayout(
          mobileScreenLayout: MobileScreenLayout(),
          webScreenLayout: WebScreenLayout(),
        ),
      );
    } else {
      // Utils.showSnackBar(res);
    }
    isLoading.value = false;
  }

  void signUpUser() async {
    isSignupLoading.value = true;

    // Logging to see the flow
    print('Sign-up process started.');

    if (image.value == null) {
      isSignupLoading.value = false;
      showSnackBar(Get.context!, 'Please select an image');
      print('Image is null.');
      return;
    }

    // signup user using our authmethodds
    try {
      String res = await AuthMethods().signUpUser(
          email: emailControllerSignup.text,
          password: passwordControllerSignup.text,
          username: userNameControllerSignup.text,
          bio: bioControllerSignup.text,
          file: image.value!);

      print('Response from AuthMethods: $res');

      if (res == "success") {
        // navigate to the home screen
        Get.off(
          () => const ResponsiveLayout(
            mobileScreenLayout: MobileScreenLayout(),
            webScreenLayout: WebScreenLayout(),
          ),
        );
      } else {
        if (Get.context != null) {
          showSnackBar(Get.context!, res);
        }
      }
    } catch (e) {
      print('Error during sign-up: $e');
      if (Get.context != null) {
        showSnackBar(Get.context!, e.toString());
      }
    } finally {
      isSignupLoading.value = false;
      print('Sign-up process ended.');
    }
  }

  void selectImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      image.value = await pickedFile.readAsBytes();
    }
  }

  Future<void> refreshUser() async {
    User userDetails = await _authMethods.getUserDetails();
    user.value = userDetails;
  }
}
