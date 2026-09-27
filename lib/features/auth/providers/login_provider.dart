import 'package:flutter/foundation.dart';

import '../../../app/auth_controller.dart';
import '../../../app/get_network_caller.dart';
import '../../../app/urls.dart';
import '../../../core/services/network_caller/network_caller.dart';
import '../data/models/login_params.dart';
import '../data/models/user_model.dart';

class LoginProvider extends ChangeNotifier {
  bool _isLoginInProgress = false;

  bool get isLoginInProgress => _isLoginInProgress;

  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  Future<bool> setLoginInProgress(LoginParams loginParams) async {
    bool isSuccess = false;
    _isLoginInProgress = true;
    notifyListeners();

    final NetworkResponse networkResponse = await getNetworkCaller().getRequest(
      Urls.loginUrl(loginParams.userName, loginParams.password),
    );

    if (networkResponse.isSuccess) {
      String token = networkResponse.body['Token'];
      UserModel userModel = UserModel.fromJson(networkResponse.body);

      await AuthController.saveUserData(userModel, token);

      isSuccess = true;
      _errorMessage = null;
    } else {
      _errorMessage = networkResponse.errorMessage;
    }

    _isLoginInProgress = false;
    notifyListeners();

    return isSuccess;
  }
}
