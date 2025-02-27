import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pos_app/core/core.dart';
import 'package:pos_app/services/services.dart';
import 'package:pos_app/widgets/widgets.dart';
import 'package:provider/provider.dart';

class AddBillWidget extends StatefulWidget {
  const AddBillWidget({super.key});
  @override
  State<AddBillWidget> createState() => _AddCategoryWidget();
}

class _AddCategoryWidget extends State<AddBillWidget> {
  FocusNode _totalFocusNode = FocusNode();
  TextEditingController _totalController = TextEditingController();
    FocusNode _descriptionFocusNode = FocusNode();
  TextEditingController _descriptionController = TextEditingController();
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
              Localization.of(context).getText('new bill'),
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
                  controller: _totalController,
                  inputFormatters: [
                    FilteringTextInputFormatter.singleLineFormatter
                  ],
                  keyboardType: TextInputType.number,
                  focusNode: _totalFocusNode,
                  decoration: InputDecoration(
                    labelText: Localization.of(context).getText('bill total'),
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
                        ? 'Total can\'t be empty'
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
                height: MediaQuery.sizeOf(context).height * 0.13,
                margin: EdgeInsetsDirectional.fromSTEB(5, 0, 5, 0),
                padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 5),
                child: TextFormField(
                  maxLines: 3,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: _descriptionController,
                  keyboardType: TextInputType.multiline,
                  focusNode: _descriptionFocusNode,
                  decoration: InputDecoration(
                    
                    labelText:
                        Localization.of(context).getText('bill description'),
                    labelStyle: AppTheme.of(context).bodyLarge,
                    //hintText: Localization.of(context).getText('category hint'),
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
                    return value == null || value.isEmpty || value.length < 5
                        ? 'Bill must have description'
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
                    if (_totalController.text.isNotEmpty && _descriptionController.text.isNotEmpty) 
                    if (await BillService.AddBill(auth: Provider.of<AppStateNotifier>(context,listen: false).getUserAuth, 
                    description: _descriptionController.text, total: _totalController.text)) {
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
