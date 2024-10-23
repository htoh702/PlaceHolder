import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:placeholder/amplifyconfiguration.dart';
import 'package:placeholder/globals.dart';
import 'package:placeholder/services/api.dart';
import 'package:placeholder/services/model.dart';

Future<void> getCurrentUser() async {
  try {
    AuthUser user = await Amplify.Auth.getCurrentUser();
    print('User ID: ${user.userId}');
    print('User username: ${user.username}');
    subID.value = user.username.replaceFirst('google_', '');
    UserData? userData = await fetchUserData(subID.value);
    userName.value = userData!.name;
    userEmail.value = userData.email;
  } catch (e) {
    print('Could not get user: $e');
  }
}

Future<String> checkUserLoggedIn() async {
  try {
    await Amplify.Auth.getCurrentUser();
    return "true";
  } catch (e) {
    return "false";
  }
}

void configureAmplify() async {
  try {
    final authPlugin = AmplifyAuthCognito();
    await Amplify.addPlugin(authPlugin);
    await Amplify.configure(amplifyconfig);
    print('Successfully configured Amplify');
    getCurrentUser();
  } catch (e) {
    print('Error configuring Amplify: $e');
  }
}
