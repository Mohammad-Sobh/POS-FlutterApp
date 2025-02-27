import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pos_app/core/core.dart';
import 'package:pos_app/services/item_service.dart';
import 'package:pos_app/widgets/widgets.dart';
import 'package:provider/provider.dart';

class AddItemWdget extends StatefulWidget {
  const AddItemWdget({super.key, required this.categories});
  final List<String> categories;
  @override
  State<AddItemWdget> createState() => _AddItemWidget();
}

class _AddItemWidget extends State<AddItemWdget> {
  FocusNode _nameFocusNode = FocusNode();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _categoryController = TextEditingController();
  FocusNode _priceFocusNode = FocusNode();
  TextEditingController _priceController = TextEditingController();
  FocusNode _descriptionFocusNode = FocusNode();
  TextEditingController _descriptionController = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 70),
      height: MediaQuery.of(context).size.height * 0.7,
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
      child: Column(spacing: 10, children: [
        Padding(
          padding: EdgeInsets.only(bottom: 1),
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
                onTap: () =>
                    FocusScope.of(context).requestFocus(_nameFocusNode),
                controller: _nameController,
                inputFormatters: [
                  FilteringTextInputFormatter.singleLineFormatter
                ],
                keyboardType: TextInputType.text,
                focusNode: _nameFocusNode,
                decoration: InputDecoration(
                  labelText: Localization.of(context).getText('product name'),
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
                      ? 'Product must have a name'
                      : null;
                },
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 5,
          children: [
            Container(
                alignment: Alignment.center,
                width: MediaQuery.sizeOf(context).width * 0.38,
                height: MediaQuery.sizeOf(context).height * 0.075,
                margin: EdgeInsetsDirectional.fromSTEB(5, 0, 5, 0),
                padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 5),
                child: DropdownMenu(
                    menuStyle: MenuStyle(
                        backgroundColor: WidgetStatePropertyAll(
                            AppTheme.of(context).primaryBackground),
                        shape: WidgetStatePropertyAll(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        )),
                    enableSearch: false,
                    controller: _categoryController,
                    label: Text(Localization.of(context).getText('category')),
                    inputDecorationTheme: InputDecorationTheme(
                      labelStyle: AppTheme.of(context).bodySmall,
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
                      filled: true,
                      fillColor: AppTheme.of(context).accent4,
                    ),
                    textStyle: AppTheme.of(context).bodyLarge,
                    dropdownMenuEntries: widget.categories
                        .map((category) => DropdownMenuEntry(
                            value: category,
                            label:
                                '${category[0].toUpperCase()}${category.substring(1)}'))
                        .toList())),
            Container(
              alignment: Alignment.center,
              width: MediaQuery.sizeOf(context).width * 0.38,
              height: MediaQuery.sizeOf(context).height * 0.075,
              margin: EdgeInsetsDirectional.fromSTEB(5, 0, 5, 0),
              padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 5),
              child: TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                onTap: FocusScope.of(context).requestFocus,
                controller: _priceController,
                inputFormatters: [
                  FilteringTextInputFormatter.singleLineFormatter
                ],
                keyboardType: TextInputType.number,
                focusNode: _priceFocusNode,
                decoration: InputDecoration(
                  labelText: Localization.of(context).getText('product price'),
                  labelStyle: AppTheme.of(context).bodySmall,
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
                  return value == null || value.isEmpty ? 'Product must have price' : null;
                },
              ),
            ),
          ],
        ),
        Container(
          alignment: Alignment.center,
          width: MediaQuery.sizeOf(context).width * 0.8,
          height: MediaQuery.sizeOf(context).height * 0.13,
          margin: EdgeInsetsDirectional.fromSTEB(5, 0, 5, 0),
          child: TextFormField(
            maxLines: 3,
            scrollPadding: EdgeInsets.all(10),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            onTap: FocusScope.of(context).requestFocus,
            controller: _descriptionController,
            keyboardType: TextInputType.multiline,
            focusNode: _descriptionFocusNode,
            decoration: InputDecoration(
              labelText: Localization.of(context).getText('description'),
              labelStyle: AppTheme.of(context).bodySmall,
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
              filled: true,
              fillColor: AppTheme.of(context).accent4,
            ),
            style: AppTheme.of(context).bodyLarge,
            validator: null,
          ),
        ),
        Container(
          width: MediaQuery.sizeOf(context).width * 0.8,
          height: MediaQuery.sizeOf(context).height * 0.06,
          margin: EdgeInsetsDirectional.fromSTEB(5, 0, 5, 0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
          ),
          alignment: Alignment.center,
          padding: EdgeInsets.all(5),
          child: MyButtonWidget(
            onPressed: () async {},
            text: '${Localization.of(context).getText('add pic')}',
            icon: Icon(
              Icons.camera_alt_rounded,
              color: AppTheme.of(context).primaryText,
            ),
            options: MyButtonOptions(
              width: double.infinity,
              color: AppTheme.of(context).alternate,
              textStyle: AppTheme.of(context).bodySmall,
              elevation: 2,
            ),
          ),
        ),
        Container(
          width: MediaQuery.sizeOf(context).width * 0.8,
          height: MediaQuery.sizeOf(context).height * 0.06,
          margin: EdgeInsetsDirectional.fromSTEB(5, 0, 5, 0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
          ),
          alignment: Alignment.center,
          padding: EdgeInsets.all(5),
          child: MyButtonWidget(
            onPressed: () async {},
            text: '${Localization.of(context).getText('add barcode')}',
            icon: Icon(
              Icons.qr_code_outlined,
              color: AppTheme.of(context).primaryText,
            ),
            options: MyButtonOptions(
              width: double.infinity,
              color: AppTheme.of(context).alternate,
              textStyle: AppTheme.of(context).bodySmall,
              elevation: 2,
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              width: MediaQuery.sizeOf(context).width * 0.4,
              height: MediaQuery.sizeOf(context).height * 0.06,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
              ),
              alignment: Alignment.center,
              padding: EdgeInsets.all(5),
              child: MyButtonWidget(
                onPressed: () async {
                  if (await ItemService.addItem(
                      auth:
                          Provider.of<AppStateNotifier>(context, listen: false)
                              .getUserAuth,
                      name: _nameController.text,
                      price: _priceController.text,
                      category: _categoryController.text,
                      description: _descriptionController.text,
                      pic: "pic", //TODO ADD PIC AND BARCODE
                      barcode: "barcode"))
                      Provider.of<AppStateNotifier>(context, listen: false).refresh();
                    Navigator.of(context).canPop()
                        ? Navigator.of(context).pop(true)
                        : null;
                },
                text: '${Localization.of(context).getText('save')}',
                icon: Icon(
                  Icons.add,
                  color: AppTheme.of(context).info,
                ),
                options: MyButtonOptions(
                  width: double.infinity,
                  color: AppTheme.of(context).primary,
                  textStyle: AppTheme.of(context).titleMedium,
                  elevation: 2,
                ),
              ),
            ),
            Container(
              width: MediaQuery.sizeOf(context).width * 0.4,
              height: MediaQuery.sizeOf(context).height * 0.06,
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
                text: '${Localization.of(context).getText('cancel')}',
                icon: Icon(
                  Icons.close_rounded,
                  color: AppTheme.of(context).info,
                ),
                options: MyButtonOptions(
                  width: double.infinity,
                  color: AppTheme.of(context).secondaryText,
                  textStyle: AppTheme.of(context).titleMedium,
                  elevation: 2,
                ),
              ),
            ),
          ],
        )
      ]),
    );
  }
}
