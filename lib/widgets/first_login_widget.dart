import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pos_app/core/core.dart';
import 'package:pos_app/models/user_model.dart';
import 'package:pos_app/services/services.dart';
import 'package:pos_app/widgets/widgets.dart';

class FirstLoginWidget extends StatefulWidget {
  const FirstLoginWidget({super.key, required this.user});
  final UserInfo user;
  @override
  State<FirstLoginWidget> createState() => _FirstLoginWidget();
}

class _FirstLoginWidget extends State<FirstLoginWidget> {
  FocusNode _shopNameFocusNode = FocusNode();
  TextEditingController _shopNameController = TextEditingController();
    FocusNode _cashFocusNode = FocusNode();
  TextEditingController _cashController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.5,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: const Color.fromARGB(150, 0, 0, 0),
                blurStyle: BlurStyle.normal,
                blurRadius: 300,
                offset: Offset(0, -10),
                spreadRadius: -10)
          ],
          border:
              Border.all(color: const Color.fromARGB(22, 0, 0, 0), width: 2),
          color: AppTheme.of(context).primaryBackground,
          borderRadius: BorderRadius.vertical(top: Radius.circular(15))),
      child: Column(
        spacing: 5,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Text(
              Localization.of(context).getText('complete account'),
              style: AppTheme.of(context).labelLarge,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.center,
                width: MediaQuery.sizeOf(context).width * 0.8,
                height: MediaQuery.sizeOf(context).height * 0.075,
                margin: EdgeInsetsDirectional.fromSTEB(5, 0, 5, 0),
                padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 5),
                child: TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: _shopNameController,
                  inputFormatters: [
                    FilteringTextInputFormatter.singleLineFormatter
                  ],
                  keyboardType: TextInputType.text,
                  focusNode: _shopNameFocusNode,
                  decoration: InputDecoration(
                    labelText: Localization.of(context).getText('shop name'),
                    labelStyle: AppTheme.of(context).bodyLarge,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: AppTheme.of(context).primary,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0x00000000),
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: AppTheme.of(context).error,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    filled: true,
                    fillColor: AppTheme.of(context).accent4,
                  ),
                  style: AppTheme.of(context).bodyMedium,
                  validator: (value) {
                    return value == null || value.isEmpty || value.length < 3
                        ? 'Shop name can\'t be empty'
                        : null;
                  },
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.center,
                width: MediaQuery.sizeOf(context).width * 0.8,
                height: MediaQuery.sizeOf(context).height * 0.075,
                margin: EdgeInsetsDirectional.fromSTEB(5, 0, 5, 0),
                padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 5),
                child: TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: _cashController,
                  keyboardType: TextInputType.number,
                  focusNode: _cashFocusNode,
                  decoration: InputDecoration(
                    labelText:
                        Localization.of(context).getText('amount cash'),
                    labelStyle: AppTheme.of(context).bodyLarge,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: AppTheme.of(context).primary,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0x00000000),
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: AppTheme.of(context).error,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    filled: true,
                    fillColor: AppTheme.of(context).accent4,
                  ),
                  style: AppTheme.of(context).bodyMedium,
                  validator: (value) {
                    return value == null || value.isEmpty
                        ? ''
                        : null;
                  },
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                width: MediaQuery.sizeOf(context).width * 0.4,
                height: MediaQuery.sizeOf(context).height * 0.06,
                margin: EdgeInsetsDirectional.fromSTEB(5, 0, 5, 0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                ),
                alignment: Alignment.center,
                padding: EdgeInsets.all(5),
                child: MyButtonWidget(
                  onPressed: () async {
                    if (_shopNameController.text.isNotEmpty && _cashController.text.isNotEmpty) 
                    if (await UserService.firstLogin(user: widget.user, 
                    cash: _cashController.text, shopName: _shopNameController.text)) {
                      Navigator.of(context).canPop()
                          ? Navigator.of(context).pop(true)
                          : null;
                      setState(() {});
                    }
                  },
                  text: Localization.of(context).getText('save'),
                  icon: Icon(
                    Icons.add_rounded,
                    color: AppTheme.of(context).info,
                  ),
                  options: MyButtonOptions(
                    color: AppTheme.of(context).primary,
                    textStyle: AppTheme.of(context).titleMedium,
                    elevation: 2,
                  ),
                ),
              ),
              Container(
                width: MediaQuery.sizeOf(context).width * 0.4,
                height: MediaQuery.sizeOf(context).height * 0.06,
                margin: EdgeInsetsDirectional.fromSTEB(5, 0, 5, 0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                ),
                alignment: Alignment.center,
                padding: EdgeInsets.all(5),
                child: MyButtonWidget(
                  onPressed: () async {
                    Navigator.of(context).canPop()
                        ? Navigator.of(context).pop(false)
                        : null;
                  },
                  text: Localization.of(context).getText('cancel'),
                  icon: Icon(
                    Icons.close_rounded,
                    color: AppTheme.of(context).info,
                  ),
                  options: MyButtonOptions(
                    color: AppTheme.of(context).secondaryText,
                    textStyle: AppTheme.of(context).titleMedium,
                    elevation: 2,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
