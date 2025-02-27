// ignore_for_file: unused_import

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:pos_app/core/core.dart';
import 'package:pos_app/models/item_model.dart';
import 'package:pos_app/packages/text/auto_size_text.dart';
import 'package:pos_app/services/services.dart';
import 'package:pos_app/widgets/widgets.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => HomePageState();
}

class _stateValues {
  final List<Item> displayItems;
  final List<Item> cartItems;
  final String selectedCategory;
  _stateValues(
      {required this.cartItems,
      required this.selectedCategory,
      required this.displayItems});
  _stateValues copyWith(
          {List<Item>? cartItems,
          String? selectedCategory,
          List<Item>? displayItems}) =>
      _stateValues(
          cartItems: cartItems ?? this.cartItems,
          selectedCategory: selectedCategory ?? this.selectedCategory,
          displayItems: displayItems ?? this.displayItems);
}

class HomePageState extends State<HomePage> with TickerProviderStateMixin {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = <String, AnimationInfo>{};

  @override
  void initState() {
    super.initState();
    animationsMap.addAll({
      'rowOnPageLoadAnimation': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
          MoveEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: const Offset(0.0, 22.0),
            end: const Offset(0.0, 0.0),
          ),
          ScaleEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: const Offset(0.2, 1.0),
            end: const Offset(1.0, 1.0),
          ),
        ],
      ),
      'columnOnPageLoadAnimation': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
          MoveEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: const Offset(0.0, 60.0),
            end: const Offset(0.0, 0.0),
          ),
          ScaleEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: const Offset(1.0, 1.0),
            end: const Offset(1.0, 1.0),
          ),
        ],
      ),
    });
    setupAnimations(
      animationsMap.values.where((anim) =>
          anim.trigger == AnimationTrigger.onActionTrigger ||
          !anim.applyInitialState),
      this,
    );
  }

  TextEditingController _searchController = TextEditingController();
  FocusNode _searchFocusNode = FocusNode();
  _stateValues _values =
      _stateValues(cartItems: [], selectedCategory: 'All', displayItems: []);
  //TODO default to get All Items
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: AppTheme.of(context).primaryBackground,
      body: ListView(
          scrollDirection: Axis.vertical,
          padding: EdgeInsets.only(top: 70, bottom: 70),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [_searchBox(context)],
            ),
            Padding(padding: EdgeInsets.only(bottom: 10)),
            Row(
              spacing: 20,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _cartButton(context),
                _scanButton(context),
              ],
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(10, 15, 0, 5),
              child: Text(
                Localization.of(context).getText('categories'),
                style: AppTheme.of(context).labelLarge,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    padding: EdgeInsets.all(5),
                    height: MediaQuery.sizeOf(context).height * 0.07,
                    width: MediaQuery.sizeOf(context).width * 0.95,
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              color: const Color.fromARGB(20, 0, 0, 0),
                              blurStyle: BlurStyle.normal,
                              blurRadius: 20,
                              spreadRadius: 0)
                        ],
                        border: Border(
                            right: BorderSide(
                                color: AppTheme.of(context).secondaryBackground,
                                width: 5,
                                strokeAlign: BorderSide.strokeAlignInside),
                            left: BorderSide(
                                color: AppTheme.of(context).secondaryBackground,
                                width: 5,
                                strokeAlign: BorderSide.strokeAlignInside)),
                        borderRadius: BorderRadius.circular(10),
                        color: AppTheme.of(context).secondaryBackground),
                    child: FutureBuilder(
                      future: CategoryService.getCategories(
                          Provider.of<AppStateNotifier>(context, listen: false)
                              .getUserAuth),
                      builder: (context, snapshot) {
                        if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                          //default category
                          return ListView(
                              scrollDirection: Axis.horizontal,
                              children: [
                                Padding(padding: EdgeInsets.all(5)),
                                Row(spacing: 20, children: [
                                  _categoryButton('All', context),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    spacing: 20,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: List<Widget>.from(snapshot.data!
                                        .map((category) => _categoryButton(
                                            category, context))),
                                  ),
                                ]),
                                Padding(padding: EdgeInsets.all(5)),
                              ]);
                        } else if (snapshot.hasError ||
                            (snapshot.hasData && snapshot.data!.isEmpty)) {
                          return Center(child: Text('Error: Try again later.'));
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
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(10, 15, 0, 5),
              child: Text(
                Localization.of(context).getText('products'),
                style: AppTheme.of(context).labelLarge,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(top: 10, bottom: 10),
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
                      future: ItemService.getItems(
                          auth: Provider.of<AppStateNotifier>(context, listen: false).getUserAuth,
                          category: _values.selectedCategory),
                      builder: (context, snapshot) {
                        if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                          _values =
                              _values.copyWith(displayItems: snapshot.data!);
                          _completeSearch();
                          return Column(
                              spacing: 5,
                              children: List<Widget>.generate(
                                  _values.displayItems.length, (index) {
                                if (index % 2 == 0) {
                                  Item item1 = _values.displayItems[index++];
                                  Item? item2 =
                                      index < _values.displayItems.length
                                          ? _values.displayItems[index++]
                                          : null;
                                  index++;
                                  return _itemRowBuilder(context, item1, item2);
                                }
                                return Container();
                              }));
                        } else if (snapshot.hasError ||
                            (snapshot.hasData && snapshot.data!.isEmpty)) {
                          return Center(
                              child: Text(Localization.of(context)
                                  .getText('no result')));
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
            Padding(padding: EdgeInsets.only(bottom: 70))
          ]),
    );
  }

  Widget _categoryButton(String category, BuildContext context) {
    return MyButtonWidget(
      onPressed: () async {
        //select category
        setState(() {
          _values = _values.copyWith(selectedCategory: category);
        });
      },
      text: '${category[0].toUpperCase()}${category.substring(1)}',
      options: MyButtonOptions(
          color: AppTheme.of(context).primaryBackground,
          textStyle: AppTheme.of(context).bodyMedium,
          elevation: category == _values.selectedCategory ? 0 : 2,
          padding: EdgeInsets.all(5)),
    );
  }

  Container _scanButton(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
      height: MediaQuery.sizeOf(context).height * 0.06,
      width: MediaQuery.sizeOf(context).width * 0.3,
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
      child: InkWell(
          child: Row(
        spacing: 10,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          AutoSizeText(
            Localization.of(context).getText('scan'),
            style: AppTheme.of(context).titleLarge,
          ),
          Icon(Icons.qr_code_rounded,
              color: AppTheme.of(context).error, size: 30)
        ],
      )),
    );
  }

  Container _searchBox(BuildContext context) {
    return Container(
        alignment: Alignment.bottomCenter,
        //padding: EdgeInsets.all(15),
        width: MediaQuery.sizeOf(context).width * 0.95,
        height: MediaQuery.sizeOf(context).height * 0.065,
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
              color: const Color.fromARGB(20, 0, 0, 0),
              blurStyle: BlurStyle.normal,
              blurRadius: 20,
              spreadRadius: 0)
        ], borderRadius: BorderRadius.circular(30)),
        child: TextFormField(
          onEditingComplete: () {
            _searchFocusNode.unfocus();
            _completeSearch();
          },
          onTap: FocusScope.of(context).requestFocus,
          autofocus: false,
          controller: _searchController,
          inputFormatters: [FilteringTextInputFormatter.singleLineFormatter],
          keyboardType: TextInputType.name,
          focusNode: _searchFocusNode,
          cursorHeight: 0,
          decoration: InputDecoration(
              contentPadding: EdgeInsetsDirectional.fromSTEB(30, 15, 10, 15),
              hintText: Localization.of(context).getText(
                'search product',
              ),
              hintStyle: AppTheme.of(context).bodySmall,
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.transparent,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(30.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0x00000000),
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(30.0),
              ),
              filled: true,
              fillColor: AppTheme.of(context).secondaryBackground,
              suffixIcon: InkWell(
                child: Icon(
                  Icons.search_rounded,
                  color: AppTheme.of(context).primary,
                ),
                onTap: () => _completeSearch(),
              )),
          style: AppTheme.of(context).bodyLarge,
        ));
  }

  void _completeSearch() {
    if (_searchController.text.isNotEmpty) {
      _values.displayItems
          .removeWhere((item) => !item.name!.contains(_searchController.text));
    }
  }

  Badge _cartButton(BuildContext context) {
    return Badge.count(
        backgroundColor: Colors.red,
        count: _values.cartItems.length,
        textColor: AppTheme.of(context).info,
        textStyle: AppTheme.of(context).bodySmall,
        child: Container(
          height: MediaQuery.sizeOf(context).height * 0.06,
          width: MediaQuery.sizeOf(context).width * 0.3,
          alignment: Alignment.center,
          padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
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
          child: InkWell(
              onTap: () {
                _cartBottemSheet(context);
              },
              child: Row(
                spacing: 10,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  AutoSizeText(
                    Localization.of(context).getText('cart'),
                    style: AppTheme.of(context).titleLarge,
                  ),
                  Icon(Icons.shopping_cart_outlined,
                      color: AppTheme.of(context).primary, size: 30)
                ],
              )),
        ));
  }

  void _cartBottemSheet(BuildContext context) {
    showModalBottomSheet(
        sheetAnimationStyle: AnimationStyle(
            curve: Curves.easeInOut, duration: Duration(milliseconds: 500)),
        isScrollControlled: true,
        context: context,
        builder: (context) => CartWidget(items: _values.cartItems));
  }

  Widget _itemRowBuilder(BuildContext context, Item item, Item? nextItem) {
    if (nextItem == null) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _itemCard(context, item),
          Container(
            width: MediaQuery.sizeOf(context).width * 0.4,
            height: MediaQuery.sizeOf(context).height * 0.1,
            margin: EdgeInsets.all(5),
            padding: EdgeInsets.all(5),
          )
        ],
      );
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [_itemCard(context, item), _itemCard(context, nextItem)],
    );
  }

  Container _itemCard(BuildContext context, Item item) {
    return Container(
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: const Color.fromARGB(30, 0, 0, 0),
                blurStyle: BlurStyle.outer,
                blurRadius: 5,
                spreadRadius: 0)
          ],
          borderRadius: BorderRadius.circular(10),
          color: AppTheme.of(context).primaryBackground,
          border: Border.all(
            color: AppTheme.of(context).secondaryBackground,
            width: 1,
          )),
      width: MediaQuery.sizeOf(context).width * 0.45,
      margin: EdgeInsets.all(0),
      padding: EdgeInsets.all(5),
      child: Column(
        children: [
          Row(children: [
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.all(5),
              child: Icon(
                Icons.image_outlined,
                size: 40,
                color: AppTheme.of(context).primaryText,
              ),
            ),
            Expanded(
                child: Text(item.name!, style: AppTheme.of(context).bodyMedium))
          ]),
          Row(), //TODO item describtion
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.all(5),
                  child: Text(
                      '${item.price} ${Localization.of(context).getText('jod')}',
                      style: AppTheme.of(context).bodySmall)),
              Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.all(5),
                  child: InkWell(
                      onTap: () {
                        setState(() {
                          _values.cartItems.add(item);
                          _values = _values.copyWith();
                        });
                      },
                      child: Icon(
                        Icons.add_circle_outline_rounded,
                        size: 40,
                        color: AppTheme.of(context).primary,
                      )))
            ],
          )
        ],
      ),
    );
  }
}
