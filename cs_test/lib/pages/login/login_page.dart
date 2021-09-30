import 'package:cs_test/pages/login/login_form.dart';
import 'package:cs_test/utilities/constants.dart';
import 'package:cs_test/widgets/buttons.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:cs_test/pages/login/login_view_model.dart';
import 'package:cs_test/state.dart';
import 'package:cs_test/models/models.dart';
import 'package:cs_test/theme.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        resizeToAvoidBottomPadding: false,
        body: StoreConnector<GlobalAppState, LoginViewModel>(
            distinct: true,
            onDidChange: (LoginViewModel viewModel) {
              if (viewModel.authState.loadingStatus == LoadingStatus.success) {
                viewModel.dispatchNavigateToHome(context);
              }
            },
            converter: (Store<GlobalAppState> store) =>
                LoginViewModel.create(store),
            builder: (BuildContext context, LoginViewModel viewModel) =>
                buildContent(context, viewModel)));
  }

  Widget buildContent(BuildContext context, LoginViewModel viewModel) =>
      GestureDetector(
          onTap: () {
            // call this method here to hide soft keyboard
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Flexible(
                      fit: FlexFit.tight,
                      child: _buildHeader(context, viewModel),
                    ),
                    Flexible(
                        flex: 2,
                        child: Container(
                            child: Column(
                              children: <Widget>[
                                LoginFormWidget(viewModel,
                                    key: Key('login-form')),
                                _buildForgetPassword(context),
                                _buildSignUp(context)
                              ],
                            ),
                            decoration:
                                BoxDecoration(gradient: csHorizontalGradient)))
                  ],
                ),
              )));

  Widget _buildHeader(BuildContext context, LoginViewModel viewModel) =>
      SafeArea(
          child: Column(children: [
        Padding(
            padding: const EdgeInsets.only(top: 40, bottom: 20),
            child: Container(
                height: 75,
                child: Image.asset('assets/logo/logo-icon.png',
                    fit: BoxFit.cover))),
        Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Text(Constants.APP_NAME,
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).accentColor)),
        )
      ]));

  Widget _buildForgetPassword(BuildContext context) => Flexible(
      fit: FlexFit.loose,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FlatButton(
            onPressed: () {},
            child: Text("Forgot Password?",
                style: TextStyle(
                    fontWeight: FontWeight.w300,
                    color: Theme.of(context).scaffoldBackgroundColor)),
          )
        ],
      ));

  Widget _buildSignUp(BuildContext context) => Flexible(
      fit: FlexFit.tight,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text("Don't have an account?",
              style: TextStyle(
                  fontWeight: FontWeight.w300,
                  color: Theme.of(context).scaffoldBackgroundColor)),
          FlatButton(
              onPressed: () {},
              child: Text("SIGN UP",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                      color: Theme.of(context).scaffoldBackgroundColor))),
        ],
      ));
}
