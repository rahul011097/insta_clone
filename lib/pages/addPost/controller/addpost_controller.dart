import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:typed_data';
import 'package:image_picker/image_picker.dart';
import 'package:social_clone/utils/utils.dart';
import 'package:social_clone/resources/firebase_methods.dart';

class AddPostBinding implements Bindings {
  @override
  void dependencies() => Get.put(AddPostController());
}

class AddPostController extends GetxController {
  var file = Rxn<Uint8List>();
  var isLoading = false.obs;
  TextEditingController descriptionController = TextEditingController();

  Future<void> selectImage(ImageSource source) async {
    Uint8List selectedFile = await pickImage(source);
    file.value = selectedFile;
  }

  void loadData() {}

  void clearImage() {
    file.value = null;
  }

  Future<void> postImage(String uid, String username, String profImage) async {
    isLoading.value = true;
    try {
      String res = await FireStoreMethods().uploadPost(
        descriptionController.text,
        file.value!,
        uid,
        username,
        profImage,
      );
      if (res == "success") {
        isLoading.value = false;
        Get.snackbar('Success', 'Posted!', snackPosition: SnackPosition.BOTTOM);
        clearImage();
      } else {
        Get.snackbar('Error', res, snackPosition: SnackPosition.BOTTOM);
      }
    } catch (err) {
      isLoading.value = false;
      Get.snackbar('Error', err.toString(),
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  @override
  void onClose() {
    descriptionController.dispose();
    super.onClose();
  }
}
