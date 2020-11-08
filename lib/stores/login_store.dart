import 'package:mobx/mobx.dart';

part 'login_store.g.dart';

class LoginStore = _loginSotre with _$LoginStore;


abstract class _loginSotre with Store{

 /* _loginSotre(){
    autorun((_){ //autorun irá detectar que tem o observable dentro da função
        print(email);
        print(password);
    });
  }*/

  _loginSotre(){
    autorun((_){ //autorun irá detectar que tem o observable dentro da função
      print(isFormValid);

    });
  }
  @observable
  String email = "";

  @action
  void setEmail(String value) => email = value;

  @observable
  String password = "";

  //conforme vai indo digitando ele vai indo chamando o setpassword mesma coisa pra email
  @action
  void setPassword(String value) => password = value;

  @observable
  bool passwordVisible = false;

  @action
  void togglePasswordVisibility()=> passwordVisible = !passwordVisible;

  @observable
  bool loading = false;

  @computed
  bool get isEmailValid => RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$').hasMatch(email);

  @computed
  bool get isPasswordValid => password.length>=6;

  @computed
  bool get isFormValid => isEmailValid && isPasswordValid;

  @observable
  bool loggedin = false;

  @computed
  Function get loginPressed =>(isEmailValid && isPasswordValid && !loading) ? login : null;

  @action
  Future <void> login() async{
    loading = true;
    await Future.delayed(Duration(seconds: 2));
    loading = false;
    loggedin = true;
  }
}