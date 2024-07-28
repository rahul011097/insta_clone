import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_clone/resources/firebase_methods.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() => Get.put(HomeController());
}

class HomeController extends GetxController {
  final selectedIndex = 0.obs;
  final isLikeAnimating = false.obs;
  final commentLen = 0.obs;
  var comments = <QueryDocumentSnapshot<Map<String, dynamic>>>[].obs;
  final isLoading = true.obs;
  final TextEditingController commentEditingController =
      TextEditingController();
  Future<void> fetchCommentLen(String postId) async {
    try {
      QuerySnapshot snap = await FirebaseFirestore.instance
          .collection('posts')
          .doc(postId)
          .collection('comments')
          .get();
      commentLen.value = snap.docs.length;
    } catch (err) {
      // Handle error
      print('Error fetching comments: $err');
    }
  }

  Future<void> likePost(String postId, String userId, List likes) async {
    try {
      await FireStoreMethods().likePost(postId, userId, likes);
    } catch (err) {
      // Handle error
      print('Error liking post: $err');
    }
  }

  Future<void> deletePost(String postId) async {
    try {
      await FireStoreMethods().deletePost(postId);
    } catch (err) {
      // Handle error
      print('Error deleting post: $err');
    }
  }

  void fetchComments(String postId) async {
    try {
      isLoading(true);
      FirebaseFirestore.instance
          .collection('posts')
          .doc(postId)
          .collection('comments')
          .snapshots()
          .listen((snapshot) {
        comments.value = snapshot.docs;
        isLoading(false);
      });
    } catch (e) {
      isLoading(false);
      // Handle error
    }
  }

  void postComment(
      String postId, String uid, String name, String profilePic) async {
    try {
      String res = await FireStoreMethods().postComment(
        postId,
        commentEditingController.text,
        uid,
        name,
        profilePic,
      );

      if (res != 'success') {
        Get.snackbar('Error', res);
      } else {
        commentEditingController.clear();
      }
    } catch (err) {
      Get.snackbar('Error', err.toString());
    }
  }
}
