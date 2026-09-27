import 'package:hisab_plus/app/auth_controller.dart';

import '../core/services/network_caller/network_caller.dart';

NetworkCaller getNetworkCaller() {
  return NetworkCaller(
    headers: () => {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      if (AuthController.accessToken != null)
        'Authorization': AuthController.accessToken!,
    },
  );
}
