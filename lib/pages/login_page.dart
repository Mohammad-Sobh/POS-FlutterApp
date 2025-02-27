import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pos_app/widgets/button_widget.dart';
import 'package:pos_app/core/core.dart';
import 'package:pos_app/widgets/dialog_widget.dart';
import 'package:pos_app/widgets/first_login_widget.dart';
import 'package:provider/provider.dart';
import 'package:pos_app/services/user_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
  }

  //variables
  FocusNode? phoneFocusNode;
  TextEditingController phoneController = TextEditingController();
  String? Function(String?)? phoneValidator() => (value) {
        return value == null ||
                value.isEmpty ||
                value.length < 10 ||
                !RegExp(r'^07\d{8}$').hasMatch(value)
            ? Localization.of(context).getText('wrong phone')
            : null;
      };

  FocusNode? passwordFocusNode;
  TextEditingController passwordController = TextEditingController();
  String? Function(String?)? passwordValidator() => (value) {
        return value == null ||
                value.isEmpty ||
                value.length < 8 ||
                !RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[^\da-zA-Z]).{8,15}$')
                    .hasMatch(value)
            ? Localization.of(context).getText('wrong password')
            : null;
      };
  bool passwordVisibility = true;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            key: scaffoldKey,
            backgroundColor: AppTheme.of(context).primaryBackground,
            body: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      width: MediaQuery.sizeOf(context).width * 1.0,
                      height: MediaQuery.sizeOf(context).height * 1.0,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.fitWidth,
                          image: Image.asset(
                            'assets/images/login_bg@2x.png',
                          ).image,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            0.0, 40.0, 0.0, 0.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(20),
                                  child: Image.asset(
                                    'assets/images/logo_landscape.PNG',
                                    width: 170.0,
                                    height: 60.0,
                                    fit: BoxFit.fitWidth,
                                    isAntiAlias: true,
                                  ),
                                )
                              ],
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  24.0, 0.0, 24.0, 0.0),
                              child: SingleChildScrollView(
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Text(
                                            Localization.of(context).getText(
                                              'welcome back',
                                            ),
                                            style: AppTheme.of(context)
                                                .displaySmall),
                                      ],
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0.0, 12.0, 0.0, 0.0),
                                      child: Row(
                                        children: [
                                          Text(
                                              Localization.of(context).getText(
                                                'Login message',
                                              ),
                                              style: AppTheme.of(context)
                                                  .labelMedium),
                                        ],
                                      ),
                                    ),
                                    Form(
                                        key: _formKey,
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      0.0, 20.0, 0.0, 0.0),
                                              child: TextFormField(
                                                autovalidateMode:
                                                    AutovalidateMode
                                                        .onUserInteraction,
                                                maxLength: 10,
                                                inputFormatters: [
                                                  FilteringTextInputFormatter
                                                      .digitsOnly
                                                ],
                                                autofocus: true,
                                                keyboardType:
                                                    TextInputType.phone,
                                                controller: phoneController,
                                                focusNode: phoneFocusNode,
                                                decoration: InputDecoration(
                                                  labelText: Localization.of(
                                                          context)
                                                      .getText('phone number'),
                                                  labelStyle:
                                                      AppTheme.of(context)
                                                          .bodySmall,
                                                  hintText:
                                                      Localization.of(context)
                                                          .getText(
                                                    'enter phone',
                                                  ),
                                                  hintStyle:
                                                      AppTheme.of(context)
                                                          .bodySmall,
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color:
                                                          AppTheme.of(context)
                                                              .primary,
                                                      width: 1.0,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0),
                                                  ),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Color(0x00000000),
                                                      width: 1.0,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0),
                                                  ),
                                                  errorBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color:
                                                          AppTheme.of(context)
                                                              .error,
                                                      width: 1.0,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0),
                                                  ),
                                                  focusedErrorBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Color(0x00000000),
                                                      width: 1.0,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0),
                                                  ),
                                                  filled: true,
                                                  fillColor:
                                                      AppTheme.of(context)
                                                          .accent4,
                                                  contentPadding:
                                                      EdgeInsetsDirectional
                                                          .fromSTEB(20.0, 24.0,
                                                              20.0, 24.0),
                                                  prefixIcon: Icon(
                                                      Icons.phone_iphone,
                                                      color:
                                                          AppTheme.of(context)
                                                              .accent1),
                                                ),
                                                style: AppTheme.of(context)
                                                    .bodyLarge,
                                                validator: phoneValidator(),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      0.0, 12.0, 0.0, 0.0),
                                              child: TextFormField(
                                                autovalidateMode:
                                                    AutovalidateMode
                                                        .onUserInteraction,
                                                maxLength: 15,
                                                keyboardType: TextInputType
                                                    .visiblePassword,
                                                controller: passwordController,
                                                focusNode: passwordFocusNode,
                                                obscureText: passwordVisibility,
                                                decoration: InputDecoration(
                                                  labelText:
                                                      Localization.of(context)
                                                          .getText(
                                                    'password',
                                                  ),
                                                  labelStyle:
                                                      AppTheme.of(context)
                                                          .bodySmall,
                                                  hintText:
                                                      Localization.of(context)
                                                          .getText(
                                                    'enter password',
                                                  ),
                                                  hintStyle:
                                                      AppTheme.of(context)
                                                          .bodySmall,
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color:
                                                          AppTheme.of(context)
                                                              .primary,
                                                      width: 1.0,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0),
                                                  ),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Color(0x00000000),
                                                      width: 1.0,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0),
                                                  ),
                                                  errorBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color:
                                                          AppTheme.of(context)
                                                              .error,
                                                      width: 1.0,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0),
                                                  ),
                                                  focusedErrorBorder:
                                                      OutlineInputBorder(
                                                    borderSide:
                                                        const BorderSide(
                                                      color: Color(0x00000000),
                                                      width: 1.0,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0),
                                                  ),
                                                  filled: true,
                                                  fillColor:
                                                      AppTheme.of(context)
                                                          .accent4,
                                                  contentPadding:
                                                      EdgeInsetsDirectional
                                                          .fromSTEB(20.0, 24.0,
                                                              20.0, 24.0),
                                                  prefixIcon: Icon(Icons.lock,
                                                      color:
                                                          AppTheme.of(context)
                                                              .accent1),
                                                  suffixIcon: InkWell(
                                                    onTap: () => setState(
                                                      () => passwordVisibility =
                                                          !passwordVisibility,
                                                    ),
                                                    focusNode: FocusNode(
                                                        skipTraversal: true),
                                                    child: Icon(
                                                      passwordVisibility
                                                          ? Icons
                                                              .visibility_outlined
                                                          : Icons
                                                              .visibility_off_outlined,
                                                      color:
                                                          AppTheme.of(context)
                                                              .alternate,
                                                      size: 20.0,
                                                    ),
                                                  ),
                                                ),
                                                style: AppTheme.of(context)
                                                    .bodyLarge,
                                                validator: passwordValidator(),
                                              ),
                                            )
                                          ],
                                        )),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0.0, 10.0, 0.0, 0.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 24.0, 0.0, 24.0),
                                            child: MyButtonWidget(
                                              onPressed: () async {
                                                //sign up
                                                if (_formKey.currentState!
                                                    .validate()) {
                                                  var user =
                                                      await UserService.signUp(
                                                          phoneController.text,
                                                          passwordController
                                                              .text);
                                                  if (user != null) {
                                                    await showModalBottomSheet(
                                                        isScrollControlled:
                                                            true,
                                                        isDismissible: false,
                                                        useSafeArea: true,
                                                        context: context,
                                                        builder: (context) =>
                                                            FirstLoginWidget(
                                                                user: user));
                                                    // Provider.of<AppStateNotifier>(
                                                    //         context,
                                                    //         listen: false)
                                                    //     .setUser(user);
                                                  } else {
                                                    dialogWidget(
                                                            context,
                                                            Localization.of(
                                                                    context)
                                                                .getText(
                                                              'login error title',
                                                            ),
                                                            Localization.of(
                                                                    context)
                                                                .getText(
                                                              'signup error content',
                                                            ),
                                                            barrierDismissible:
                                                                true)
                                                        .showDialog();
                                                  }
                                                }
                                              },
                                              text: Localization.of(context)
                                                  .getText(
                                                'sign up',
                                              ),
                                              options: MyButtonOptions(
                                                width: 130.0,
                                                height: 50.0,
                                                color: AppTheme.of(context)
                                                    .secondaryText,
                                                textStyle: AppTheme.of(context)
                                                    .titleSmall,
                                                elevation: 3.0,
                                                borderSide: const BorderSide(
                                                  color: Colors.transparent,
                                                  width: 1.0,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(30.0),
                                              ),
                                            ),
                                          ),
                                          MyButtonWidget(
                                            onPressed: () async {
                                              //login
                                              if (_formKey.currentState!
                                                  .validate()) {
                                                var user =
                                                    await UserService.signIn(
                                                        phoneController.text,
                                                        passwordController
                                                            .text);
                                                if (user != null) {
                                                  if (user.active! &&
                                                      user.shopName!
                                                          .isNotEmpty) {
                                                    Provider.of<AppStateNotifier>(
                                                            context,
                                                            listen: false)
                                                        .setUser(user);
                                                  } else {
                                                    if (user.shopName!.isEmpty) {
                                                      await showModalBottomSheet(
                                                          isScrollControlled:
                                                              true,
                                                          isDismissible: false,
                                                          useSafeArea: true,
                                                          context: context,
                                                          builder: (context) =>
                                                              FirstLoginWidget(user: user));
                                                    }
                                                    dialogWidget(
                                                            context,
                                                            Localization.of(
                                                                    context)
                                                                .getText(
                                                              'user inactive title',
                                                            ),
                                                            Localization.of(
                                                                    context)
                                                                .getText(
                                                              'user inactive content',
                                                            ),
                                                            barrierDismissible:
                                                                true)
                                                        .showDialog();
                                                  }
                                                } else {
                                                  dialogWidget(
                                                          context,
                                                          Localization.of(
                                                                  context)
                                                              .getText(
                                                            'login error title',
                                                          ),
                                                          Localization.of(
                                                                  context)
                                                              .getText(
                                                            'login error content',
                                                          ),
                                                          barrierDismissible:
                                                              true)
                                                      .showDialog();
                                                }
                                              }
                                            },
                                            text: Localization.of(context)
                                                .getText(
                                              'log in',
                                            ),
                                            options: MyButtonOptions(
                                              width: 130.0,
                                              height: 50.0,
                                              color:
                                                  AppTheme.of(context).primary,
                                              textStyle: AppTheme.of(context)
                                                  .titleSmall,
                                              elevation: 3.0,
                                              borderSide: const BorderSide(
                                                color: Colors.transparent,
                                                width: 1.0,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(30.0),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0.0, 40.0, 0.0, 0.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          InkWell(
                                            splashColor: Colors.transparent,
                                            focusColor: Colors.transparent,
                                            hoverColor: Colors.transparent,
                                            highlightColor: Colors.transparent,
                                            onTap: () async {
                                              //contact us
                                              dialogWidget(
                                                      context,
                                                      '',
                                                      Localization.of(context)
                                                          .getText(
                                                        'contact dialog',
                                                      ),
                                                      barrierDismissible: true)
                                                  .showDialog();
                                            },
                                            child: Container(
                                              width: MediaQuery.sizeOf(context)
                                                      .width *
                                                  0.7,
                                              height: 44.0,
                                              decoration: BoxDecoration(
                                                color: AppTheme.of(context)
                                                    .accent4,
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                              ),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                      Localization.of(context)
                                                          .getText('help'),
                                                      style:
                                                          AppTheme.of(context)
                                                              .bodySmall),
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(24.0, 0.0,
                                                                4.0, 0.0),
                                                    child: Text(
                                                      Localization.of(context)
                                                          .getText(
                                                              'contact us'),
                                                      style: AppTheme.of(
                                                              context)
                                                          .bodySmall
                                                          .override(
                                                              fontFamily:
                                                                  'Plus Jakarta Sans',
                                                              color: AppTheme.of(
                                                                      context)
                                                                  .primary),
                                                    ),
                                                  ),
                                                  Icon(
                                                    Icons.arrow_forward_rounded,
                                                    color: AppTheme.of(context)
                                                        .primary,
                                                    size: 24.0,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            )));
  }

  @override
  void dispose() {
    super.dispose();
    phoneFocusNode?.dispose();
    phoneController.dispose();
    passwordFocusNode?.dispose();
    passwordController.dispose();
  }
}
