// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:pos_app/core/core.dart';
import 'package:pos_app/models/sale_model.dart';
import 'package:pos_app/models/item_model.dart';
import 'package:pos_app/packages/text/auto_size_text.dart';
import 'package:pos_app/services/services.dart';
import 'package:provider/provider.dart';

class SalesPage extends StatefulWidget {
  const SalesPage({super.key});

  @override
  State<SalesPage> createState() => _SalesPageState();
}

class _SalesPageState extends State<SalesPage> {
  final _key = GlobalKey<ScaffoldState>();
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        color: AppTheme.of(context).primary,
        strokeWidth: 3,
        triggerMode: RefreshIndicatorTriggerMode.onEdge,
        displacement: 70,
        backgroundColor: AppTheme.of(context).primaryBackground,
        onRefresh: () async {
          setState(() {});
        },
        child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Scaffold(
                key: _key,
                backgroundColor: AppTheme.of(context).primaryBackground,
                body: ListView(
                    scrollDirection: Axis.vertical,
                    padding: EdgeInsets.only(top: 70,bottom: 70),
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _cashDisplay(context),
                          ]),
                      Padding(padding: EdgeInsets.only(bottom: 10)),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [_todaySalesDisplay(context)]),
                      Padding(padding: EdgeInsets.only(bottom: 10)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.all(10),
                              width: MediaQuery.sizeOf(context).width * 0.95,
                              decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                        color:
                                            const Color.fromARGB(20, 0, 0, 0),
                                        blurStyle: BlurStyle.normal,
                                        blurRadius: 20,
                                        spreadRadius: 0)
                                  ],
                                  borderRadius: BorderRadius.circular(10),
                                  color:
                                      AppTheme.of(context).secondaryBackground),
                              child: FutureBuilder(
                                future: SaleService.getSales(
                                    Provider.of<AppStateNotifier>(context,
                                            listen: false)
                                        .getUserAuth),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData &&
                                      snapshot.data!.isNotEmpty) {
                                    return Column(
                                      mainAxisSize: MainAxisSize.max,
                                      spacing: 20,
                                      children: List<Widget>.from(snapshot.data!.reversed
                                          .map((sale) =>
                                              _saleCard(context, sale))
                                          .toList()),
                                    );
                                  } else if (snapshot.hasError ||
                                      (snapshot.hasData &&
                                          snapshot.data!.isEmpty)) {
                                    return Center(
                                        child: Text(
                                            'Error: Can\'t get your Sales right now. Try again later.'));
                                  } else {
                                    return Center(
                                      child: CircularProgressIndicator(
                                        color: AppTheme.of(context).primary,
                                      ),
                                    );
                                  }
                                },
                              ))
                        ],
                      ),
                    ]))));
  }

  Container _todaySalesDisplay(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(0),
        height: MediaQuery.sizeOf(context).height * 0.06,
        width: MediaQuery.sizeOf(context).width * 0.95,
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  color: const Color.fromARGB(20, 0, 0, 0),
                  blurStyle: BlurStyle.normal,
                  blurRadius: 20,
                  spreadRadius: 0)
            ],
            borderRadius: BorderRadius.circular(10),
            color: AppTheme.of(context).secondaryBackground),
        child: FutureBuilder(
          future: _sales(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Row(
                  spacing: 30,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Badge.count(
                      textColor: AppTheme.of(context).info,
                      textStyle: AppTheme.of(context).bodyMedium,
                      backgroundColor: AppTheme.of(context).secondaryText,
                      count: snapshot.data![1],
                      child: Container(
                          padding: EdgeInsets.only(left: 20, right: 20),
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                                color: const Color.fromARGB(22, 0, 0, 0),
                                width: 2),
                            color: AppTheme.of(context).primaryBackground,
                          ),
                          child: Text(
                            Localization.of(context).getText('sales'),
                            style: AppTheme.of(context).labelLarge,
                          )),
                    ),
                    Container(
                        padding: EdgeInsetsDirectional.fromSTEB(20, 0, 40, 0),
                        decoration: BoxDecoration(color: Colors.transparent),
                        child: Text(
                            '${snapshot.data![0]} ${Localization.of(context).getText('jod')}',
                            style: AppTheme.of(context).titleLarge))
                  ]);
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return Center(
                child: CircularProgressIndicator(
                  color: AppTheme.of(context).primary,
                ),
              );
            }
          },
        ));
  }

  Container _cashDisplay(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(0),
        height: MediaQuery.sizeOf(context).height * 0.06,
        width: MediaQuery.sizeOf(context).width * 0.95,
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  color: const Color.fromARGB(20, 0, 0, 0),
                  blurStyle: BlurStyle.normal,
                  blurRadius: 20,
                  spreadRadius: 0)
            ],
            borderRadius: BorderRadius.circular(10),
            color: AppTheme.of(context).secondaryBackground),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          spacing: 30,
          children: [
            Container(
                alignment: Alignment.center,
                padding: EdgeInsets.only(left: 20, right: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                      color: const Color.fromARGB(22, 0, 0, 0), width: 2),
                  color: AppTheme.of(context).primaryBackground,
                ),
                child: Text(
                  Localization.of(context).getText('cash'),
                  style: AppTheme.of(context).headlineSmall,
                )),
            Container(
              padding: EdgeInsetsDirectional.fromSTEB(20, 0, 40, 0),
              decoration: BoxDecoration(color: Colors.transparent),
              child: FutureBuilder(
                future: UserService.getCash(
                    Provider.of<AppStateNotifier>(context, listen: false)
                        .getUserAuth),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Text(
                        ' ${snapshot.data!} ${Localization.of(context).getText('jod')}',
                        style: AppTheme.of(context).titleLarge);
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    return Center(
                        child: Text(Localization.of(context).getText(''),
                            style: AppTheme.of(context).titleLarge));
                  }
                },
              ),
            )
          ],
        ));
  }

  Container _saleCard(BuildContext context, Sale sale) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppTheme.of(context).primaryBackground,
      ),
      child: Row(
          spacing: 10,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              //id
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Text('${sale.id}', style: AppTheme.of(context).bodyMedium),
            ),
            Container(
              //details
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${Localization.of(context).getText('total')} ${sale.total} ${Localization.of(context).getText('jod')}',
                    style: AppTheme.of(context).bodySmall,
                  ),
                  Text(
                    '${Localization.of(context).getText('date')} ${sale.date}',
                    style: AppTheme.of(context).bodySmall,
                  )
                ],
              ),
            ),
            Container(
                padding: EdgeInsets.only(right: 10, left: 10),
                child: InkWell(
                  onTap: () {
                    //bottem sheet for details
                    showBottomSheet(
                        sheetAnimationStyle: AnimationStyle(
                            curve: Curves.easeInOut,
                            duration: Duration(milliseconds: 500)),
                        context: context,
                        builder: (context) {
                          return TapRegion(
                              onTapOutside: (event) =>
                                  Navigator.of(context).canPop()
                                      ? Navigator.of(context).pop()
                                      : null,
                              child: _saleBottemSheet(context, sale));
                        });
                  },
                  child: Icon(
                    size: 40,
                    Icons.menu_rounded,
                    color: AppTheme.of(context).secondaryText,
                  ),
                ))
          ]),
    );
  }

  Container _saleBottemSheet(BuildContext context, Sale sale) {
    return Container(
        height: MediaQuery.of(context).size.height * 0.8,
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
          spacing: 10,
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 10),
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [_saleDetails(context, sale)],
            ),
            Expanded(
              flex: 1,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.95,
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: const Color.fromARGB(20, 0, 0, 0),
                          blurStyle: BlurStyle.normal,
                          blurRadius: 20,
                          spreadRadius: 0)
                    ],
                    borderRadius: BorderRadius.circular(10),
                    color: AppTheme.of(context).secondaryBackground),
                padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 0),
                child: ListView(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  children:
                      List<Widget>.generate(sale.items!.length, (index) {
                    Item i = sale.items![index];
                    if(index<sale.items!.length-1){
                      return _itemSaleCard(context, i);
                      }
                    else 
                    {
                      return Container(
                        child: _itemSaleCard(context, i),
                        padding: EdgeInsets.only(bottom: 50),
                      );
                    }
                  }),
                ),
              ),
            )
          ],
        ));
  }

  Container _saleDetails(BuildContext context, Sale sale) {
    return Container(
      padding: EdgeInsets.all(10),
      width: MediaQuery.of(context).size.width * 0.95,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppTheme.of(context).secondaryBackground,
        boxShadow: [
          BoxShadow(
              color: const Color.fromARGB(20, 0, 0, 0),
              blurStyle: BlurStyle.normal,
              blurRadius: 20,
              spreadRadius: 0)
        ],
      ),
      child: Column(
        spacing: 4,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
              '${Localization.of(context).getText('sale details')}   # ${sale.id!}',
              style: AppTheme.of(context).bodyMedium),
          Text('${Localization.of(context).getText('date')}    ${sale.date!}',
              style: AppTheme.of(context).bodySmall),
          Text(
              '${Localization.of(context).getText('total')}    ${sale.total!} ${Localization.of(context).getText('jod')}\n${Localization.of(context).getText('discount')}    ${sale.discount} ${Localization.of(context).getText('jod')}',
              style: AppTheme.of(context).bodySmall)
        ],
      ), //row -> columns
    );
  }

  Container _itemSaleCard(BuildContext context, Item i) {
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
                child: Text('${i.id}\n${i.category}',
                    style: AppTheme.of(context).bodyMedium),
              ),
              Container(
                //details
                width: MediaQuery.of(context).size.width * 0.5,
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${Localization.of(context).getText('product name')} ${i.name}',
                      style: AppTheme.of(context).bodySmall,
                    ),
                    Text(
                      '${Localization.of(context).getText('price')} ${i.price} ${Localization.of(context).getText('jod')}',
                      style: AppTheme.of(context).bodySmall,
                    )
                  ],
                ),
              ),
            ]));
  }

  Future<List<int>> _sales() async {
    List<int> data = [];
    try {
      List<Sale> sales = await SaleService.getSales(
          Provider.of<AppStateNotifier>(context).getUserAuth);
      double salesTotal = 0;
      int count = 0;
      List<String> date;
      List<String> now;
      for (Sale sale in sales) {
        date = sale.date!.split(' ');
        date = date[0].split('/');
        now = DateTime.now().toString().split(' ');
        now = now[0].split('-');
        if (date[1] == now[2] && date[0] == now[1] && date[2] == now[0]) {
          salesTotal += double.parse(sale.total!);
          count++;
        }
      }
      data.add(salesTotal.floor());
      data.add(count);
      return data;
    } catch (e) {
      data.add(0);
      data.add(0);
      return data;
    }
  }
}
