import 'package:get/get.dart';

class AuthController extends GetxController {
  void login(String email, String password) {
    // Dummy credentials
    if (email == 'admin@gmail.com' && password == '123456') {
      Get.offAllNamed('/dashboard');
    } else {
      Get.snackbar('Login Failed', 'Invalid email or password');
    }
  }

  void register(String email, String password) {
    // You can add registration logic here
    Get.back(); // After registration, go back to login
    Get.snackbar('Success', 'Registered successfully. Please login.');
  }
}
