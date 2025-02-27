import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pos_app/core/core.dart';
import 'package:pos_app/services/services.dart';
import 'package:pos_app/widgets/widgets.dart';
import 'package:provider/provider.dart';

class AddCategoryWidget extends StatefulWidget {
  const AddCategoryWidget({super.key});
  @override
  State<AddCategoryWidget> createState() => _AddCategoryWidget();
}

class _AddCategoryWidget extends State<AddCategoryWidget> {
  FocusNode _newCategoryFocusNode = FocusNode();
  TextEditingController _newCategory = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
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
      height: MediaQuery.sizeOf(context).height * 0.25,
      child: Column(
        spacing: 5,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Text(
              Localization.of(context).getText('new category'),
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
                  onTap: () => FocusScope.of(context)
                      .requestFocus(_newCategoryFocusNode),
                  controller: _newCategory,
                  inputFormatters: [
                    FilteringTextInputFormatter.singleLineFormatter
                  ],
                  keyboardType: TextInputType.text,
                  focusNode: _newCategoryFocusNode,
                  decoration: InputDecoration(
                    labelText:
                        Localization.of(context).getText('category name'),
                    labelStyle: AppTheme.of(context).bodyLarge,
                    hintText: Localization.of(context).getText('category hint'),
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
                        ? 'Name too short'
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
                    if (_newCategory.text.isNotEmpty) if (await CategoryService
                        .addCategory(
                            Provider.of<AppStateNotifier>(context,
                                    listen: false)
                                .getUserAuth,
                            _newCategory.text)) {
                              Provider.of<AppStateNotifier>(context, listen: false).refresh();
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
