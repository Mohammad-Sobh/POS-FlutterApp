import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pos_app/core/core.dart';
import 'package:pos_app/models/item_model.dart';
import 'package:pos_app/packages/text/auto_size_text.dart';
import 'package:pos_app/services/sale_service.dart';
import 'package:pos_app/widgets/widgets.dart';
import 'package:provider/provider.dart';

class CartWidget extends StatefulWidget {
  const CartWidget({
    super.key,
    required List<Item> this.items,
  });
  final List<Item> items;
  @override
  State<CartWidget> createState() => _CartWidgetState();
}

class _CartWidgetState extends State<CartWidget> {
  FocusNode _discountFocusNode = FocusNode();
  TextEditingController _discountController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
          height: MediaQuery.of(context).size.height * 0.6,
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
              border: Border.all(
                  color: const Color.fromARGB(22, 0, 0, 0), width: 2),
              color: AppTheme.of(context).primaryBackground,
              borderRadius: BorderRadius.vertical(top: Radius.circular(15))),
          child: Column(spacing: 10, children: [
            Padding(
              padding: EdgeInsets.only(bottom: 1),
            ),
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.95,
                decoration: BoxDecoration(
                    border: Border.all(
                        color: AppTheme.of(context).secondaryBackground,
                        width: 10,
                        strokeAlign: BorderSide.strokeAlignInside),
                    boxShadow: [
                      BoxShadow(
                          color: const Color.fromARGB(20, 0, 0, 0),
                          blurStyle: BlurStyle.normal,
                          blurRadius: 20,
                          spreadRadius: 0)
                    ],
                    borderRadius: BorderRadius.circular(10),
                    color: AppTheme.of(context).secondaryBackground),
                padding: EdgeInsetsDirectional.fromSTEB(5, 5, 5, 0),
                child: ListView(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  children: List<Widget>.generate(widget.items.length, (index) {
                    Item item = widget.items[index];
                    return _saleItemBuilder(context, item);
                  }),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  alignment: Alignment.center,
                  width: MediaQuery.sizeOf(context).width * 0.5,
                  height: MediaQuery.sizeOf(context).height * 0.06,
                  margin: EdgeInsetsDirectional.fromSTEB(5, 0, 5, 0),
                  padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 5),
                  child: TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    onTap: FocusScope.of(context).requestFocus,
                    autofocus: true,
                    controller: _discountController,
                    inputFormatters: [
                      FilteringTextInputFormatter.singleLineFormatter
                    ],
                    keyboardType: TextInputType.number,
                    focusNode: _discountFocusNode,
                    decoration: InputDecoration(
                      labelText: Localization.of(context).getText('discount'),
                      labelStyle: AppTheme.of(context).bodySmall,
                      hintText: Localization.of(context).getText(
                        'discount hint',
                      ),
                      hintStyle: AppTheme.of(context).bodySmall,
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
                      contentPadding: EdgeInsetsDirectional.fromSTEB(
                          20.0, 24.0, 20.0, 24.0),
                    ),
                    style: AppTheme.of(context).bodyLarge,
                    validator: null,
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
                      if (widget.items.isNotEmpty) {
                        Map<String, dynamic> body = {
                          'discount': _discountController.text.isEmpty
                              ? '0'
                              : _discountController.text,
                          'itemsId':
                              List<int>.generate(widget.items.length, (index) {
                            return widget.items[index].id!;
                          }).toString()
                        };
                        if (widget.items.isNotEmpty && await SaleService.addSale(
                                Provider.of<AppStateNotifier>(context,
                                        listen: false)
                                    .getUserAuth,
                                body) &&
                            Navigator.of(context).canPop()) {
                          Provider.of<AppStateNotifier>(context, listen: false)
                              .refresh();
                        }
                      }
                    },
                    text:
                        '${Localization.of(context).getText('complete sale')}',
                    icon: Icon(
                      Icons.check,
                      color: AppTheme.of(context).info,
                    ),
                    options: MyButtonOptions(
                      color: AppTheme.of(context).primary,
                      textStyle: AppTheme.of(context).titleMedium,
                      elevation: 2,
                    ),
                  ),
                )
              ],
            )
          ])),
    );
  }

  Widget _saleItemBuilder(BuildContext context, Item item) {
    return Container(
        alignment: Alignment.center,
        padding: EdgeInsetsDirectional.fromSTEB(10, 5, 10, 5),
        margin: EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppTheme.of(context).primaryBackground,
        ),
        child: Row(
            spacing: 10,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                  //pic
                  child: Icon(
                Icons.category_sharp,
                size: 40,
                color: AppTheme.of(context).primary,
              )),
              Container(
                //id
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Text('${item.id}\n${item.category}',
                    style: AppTheme.of(context).bodySmall),
              ),
              Container(
                //details
                width: MediaQuery.of(context).size.width * 0.4,
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: AutoSizeText(
                            '${Localization.of(context).getText('product name')} ${item.name}',
                            style: AppTheme.of(context).bodySmall,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      '${Localization.of(context).getText('price')} ${item.price} ${Localization.of(context).getText('jod')}',
                      style: AppTheme.of(context).bodySmall,
                    )
                  ],
                ),
              ),
            ]));
  }
}
