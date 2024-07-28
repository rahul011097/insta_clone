import 'package:get/route_manager.dart';
import 'package:social_clone/core/routes/app_routes.dart';
import 'package:social_clone/pages/Auth/view/login_page.dart';
import 'package:social_clone/pages/Auth/view/signup_page.dart';
import 'package:social_clone/pages/addPost/views/addpost.dart';
import 'package:social_clone/pages/profile/view/profile.dart';
import 'package:social_clone/pages/search/views/search_page.dart';

class AppPages {
  static final List<GetPage> pages = [
    GetPage(
      name: AppRoutes.login,
      page: () => LoginPage(),
    ),
    GetPage(
      name: AppRoutes.signup,
      page: () => SignupPage(),
    ),
    GetPage(
      name: AppRoutes.addpost,
      page: () => AddPostView(),
    ),
    GetPage(
      name: AppRoutes.search,
      page: () => SearchScreen(),
    ),
    GetPage(
      name: AppRoutes.profile,
      page: () => ProfilePage(),
    ),
  ];
}
