import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/constants/app_constants.dart';
import '../models/user_model.dart';

class MockAuthDataSource {
  final SharedPreferences sharedPreferences;
  
  MockAuthDataSource(this.sharedPreferences);
  
  Future<UserModel> login(String username) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));
    
    if (username == AppConstants.validUsername) {
      final user = UserModel(username: username);
      await sharedPreferences.setString(
        AppConstants.userPrefsKey,
        username,
      );
      return user;
    } else {
      throw Exception(AppConstants.invalidUsernameError);
    }
  }
  
  Future<UserModel?> getCurrentUser() async {
    final username = sharedPreferences.getString(AppConstants.userPrefsKey);
    if (username != null) {
      return UserModel(username: username);
    }
    return null;
  }
  
  Future<void> logout() async {
    await sharedPreferences.remove(AppConstants.userPrefsKey);
  }
}
