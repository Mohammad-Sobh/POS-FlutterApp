import 'package:flutter/material.dart';
import 'package:pos_app/core/core.dart';
import 'package:pos_app/models/bill_model.dart';
import 'package:pos_app/services/services.dart';
import 'package:pos_app/widgets/add_bill_widget.dart';
import 'package:provider/provider.dart';

class BillsPage extends StatefulWidget {
  const BillsPage({super.key});

  @override
  State<BillsPage> createState() => _BillsPageState();
}

class _BillsPageState extends State<BillsPage> {
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
                    padding: EdgeInsets.only(top: 70, bottom: 70),
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _cashDisplay(context),
                          ]),
                      Padding(padding: EdgeInsets.only(bottom: 10)),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [_todayBillsDisplay(context)]),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(10, 15, 10, 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              Localization.of(context).getText('bills'),
                              style: AppTheme.of(context).labelLarge,
                            ),
                            InkWell(
                              onTap: () {
                                _addBill(context);
                              },
                              child: Icon(
                                Icons.add,
                                color: AppTheme.of(context).secondaryText,
                                size: 30,
                              ),
                            )
                          ],
                        ),
                      ),
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
                                future: BillService.getBills(
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
                                          .map((Bill) =>
                                              _BillCard(context, Bill))
                                          .toList()),
                                    );
                                  } else if (snapshot.hasError ||
                                      (snapshot.hasData &&
                                          snapshot.data!.isEmpty)) {
                                    return Center(
                                        child: Text(
                                            'Can\'t get your Bills right now. Try again later.'));
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

  Container _billDetails(BuildContext context, Bill bill) {
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
              '${Localization.of(context).getText('bill details')}   # ${bill.id!}',
              style: AppTheme.of(context).bodyMedium),
          Text('${Localization.of(context).getText('date')}    ${bill.date!}',
              style: AppTheme.of(context).bodySmall),
          Text(
              '${Localization.of(context).getText('total')}    ${bill.total!} ${Localization.of(context).getText('jod')}',
              style: AppTheme.of(context).bodySmall)
        ],
      ), 
    );
  }

  Container _billBottemSheet(BuildContext context, Bill bill) {
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
          spacing: 10,
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 10),
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [_billDetails(context, bill)],
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
                child: Text(
                  bill.description!,
                  style: AppTheme.of(context).bodyLarge,
                ),
              ),
            )
          ],
        ));
  }

  Future<dynamic> _addBill(BuildContext context) {
    return showModalBottomSheet(
        isScrollControlled: true,
        isDismissible: false,
        useSafeArea: true,
        context: context,
        builder: (context) => AddBillWidget());
  }

  Container _todayBillsDisplay(BuildContext context) {
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
          future: _Bills(),
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
                            Localization.of(context).getText('bills'),
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

  Container _BillCard(BuildContext context, Bill bill) {
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
              child: Text('${bill.id}', style: AppTheme.of(context).bodyMedium),
            ),
            Container(
              //details
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${Localization.of(context).getText('total')} ${bill.total} ${Localization.of(context).getText('jod')}',
                    style: AppTheme.of(context).bodySmall,
                  ),
                  Text(
                    '${Localization.of(context).getText('date')} ${bill.date}',
                    style: AppTheme.of(context).bodySmall,
                  )
                ],
              ),
            ),
            Container(
                padding: EdgeInsets.only(right: 10, left: 10),
                child: InkWell(
                  onTap: () {
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
                              child: _billBottemSheet(context, bill));
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

  Future<List<int>> _Bills() async {
    List<int> data = [];
    try {
      List<Bill> Bills = await BillService.getBills(
          Provider.of<AppStateNotifier>(context).getUserAuth);
      double BillsTotal = 0;
      int count = 0;
      List<String> date;
      List<String> now;
      for (Bill bill in Bills) {
        date = bill.date!.split(' ');
        date = date[0].split('/');
        now = DateTime.now().toString().split(' ');
        now = now[0].split('-');
        if (date[1] == now[2] && date[0] == now[1] && date[2] == now[0]) {
          BillsTotal -= double.parse(bill.total!);
          count++;
        }
      }
      data.add(BillsTotal.floor());
      data.add(count);
      return data;
    } catch (e) {
      data.add(0);
      data.add(0);
      return data;
    }
  }
}
