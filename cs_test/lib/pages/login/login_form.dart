import 'package:cs_test/pages/login/login_view_model.dart';
import 'package:cs_test/widgets/widgets.dart';
import 'package:flutter/material.dart';

class LoginFormWidget extends StatefulWidget {
  final LoginViewModel viewModel;
  LoginFormWidget(this.viewModel, {key: Key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginFormWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _userEmail;
  String _userPassword;

  final FocusNode emailNode = FocusNode();
  final FocusNode passwordNode = FocusNode();

  void _logIn() {
    if (_formKey.currentState.validate() &&
      _userEmail.isNotEmpty &&
      _userPassword.isNotEmpty) {
      Scaffold.of(context).showSnackBar(SnackBar( content: Text('Logging in')));
      widget.viewModel.onUserLogin(email: _userEmail, password: _userPassword);
    }
  }

  @override
  Widget build(BuildContext context) {


    return Expanded(
      flex: 3,
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 25, right: 25, bottom: 10),
              child: CSTextFormField(
                  focusNode: emailNode,
                  label: "User Name",
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value.isEmpty)
                      return 'Please enter your email';
                    else
                      _formKey.currentState.save();
                    return null;
                  },
                  onFieldSubmitted: (String value) {
                    this._userEmail = value;
                    FocusScope.of(context).requestFocus(passwordNode);
                  },
                  onSaved: (String value) {
                    this._userEmail = value;
                  },
                  key: Key('login-form-email'),
                ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25, right: 25, bottom: 20),
              child: CSTextFormField(
                label: "Password",
                focusNode: passwordNode,
                textInputAction: TextInputAction.done,
                obscureText: true,
                validator: (value) {
                  if (value.isEmpty)
                    return 'Please enter your password';
                  else
                    _formKey.currentState.save();
                  return null;
                },
                onFieldSubmitted: (String value) {
                  this._userPassword = value;
                  _logIn();
                },
                onSaved: (String value) {
                  this._userPassword = value;
                },
                key: Key('login-form-password'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25, right: 25, bottom: 10),
              child: CSRaisedButton(
                label: 'SIGN IN',
                labelFontSize: 20,
                labelColor: Color.fromARGB(255, 112, 112, 112),
                onPressed: () {
                  _logIn();
                },
                key: Key('login-form-submit'),
              ),
            )
          ],
        )
      ),
    );
  }
}