import '../models/user_model.dart';

abstract class IAuth {
  signIn();
  signOut();
  signInValidation(UserModel userModel);
}

abstract class IStandardAuth extends IAuth {
  signUp();
  setTempUserModelForSignUn({emailController, passwordController, phoneController, nameController});
  setTempUserModelForSignin({phoneController, passwordController});
}
