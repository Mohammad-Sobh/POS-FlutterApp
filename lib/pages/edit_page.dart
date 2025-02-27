import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pos_app/core/core.dart';
import 'package:pos_app/models/item_model.dart';
import 'package:pos_app/services/services.dart';
import 'package:pos_app/widgets/widgets.dart';
import 'package:provider/provider.dart';

class EditPage extends StatefulWidget {
  const EditPage({super.key});

  @override
  State<EditPage> createState() => _EditPageState();
}

class stateValues {
  final List<Item> items;
  final String selectedCategory;
  final List<String> categories;
  stateValues(
      {required this.items,
      required this.selectedCategory,
      required this.categories});
  stateValues copyWith(
          {List<Item>? items,
          String? selectedCategory,
          List<String>? categories}) =>
      stateValues(
          categories: categories ?? this.categories,
          items: items ?? this.items,
          selectedCategory: selectedCategory ?? this.selectedCategory);
}

class _EditPageState extends State<EditPage> {
  void initState() {
    super.initState();
  }

  stateValues _values =
      stateValues(items: [], selectedCategory: 'all', categories: []);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBody: true,
        backgroundColor: AppTheme.of(context).primaryBackground,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(10, 70, 10, 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    Localization.of(context).getText('categories'),
                    style: AppTheme.of(context).labelLarge,
                  ),
                  InkWell(
                    onTap: () {
                      _addCategory(context);
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
                    padding: EdgeInsets.all(0),
                    height: MediaQuery.sizeOf(context).height * 0.08,
                    width: MediaQuery.sizeOf(context).width * 0.95,
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              color: const Color.fromARGB(20, 0, 0, 0),
                              blurStyle: BlurStyle.normal,
                              blurRadius: 20,
                              spreadRadius: 0)
                        ],
                        border: Border.all(
                            color: AppTheme.of(context).secondaryBackground,
                            width: 5,
                            strokeAlign: BorderSide.strokeAlignInside),
                        borderRadius: BorderRadius.circular(10),
                        color: AppTheme.of(context).secondaryBackground),
                    child: FutureBuilder(
                      future: CategoryService.getCategories(
                          Provider.of<AppStateNotifier>(context, listen: false)
                              .getUserAuth),
                      builder: (context, snapshot) {
                        if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                          _values =
                              _values.copyWith(categories: snapshot.data!);
                          return ListView(
                              scrollDirection: Axis.horizontal,
                              children: [
                                Padding(padding: EdgeInsets.all(5)),
                                Row(spacing: 20, children: [
                                  _categoryEditButton('all', context),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    spacing: 20,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: List<Widget>.from(_values
                                        .categories
                                        .map((category) => _categoryEditButton(
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
              padding: EdgeInsetsDirectional.fromSTEB(10, 15, 10, 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    Localization.of(context).getText('products'),
                    style: AppTheme.of(context).labelLarge,
                  ),
                  InkWell(
                    onTap: () {
                      _addItem(context);
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
                    padding: EdgeInsets.only(top: 10, bottom: 10),
                    width: MediaQuery.sizeOf(context).width * 0.95,
                    height: MediaQuery.sizeOf(context).height * 0.72,
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
                          auth: Provider.of<AppStateNotifier>(context,
                                  listen: false)
                              .getUserAuth,
                          category: _values.selectedCategory),
                      builder: (context, snapshot) {
                        if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                          _values = _values.copyWith(items: snapshot.data!);
                          return ListView(
                              padding: EdgeInsetsDirectional.zero,
                              children: [
                                Column(
                                  spacing: 10,
                                  children: List<Widget>.generate(
                                      _values.items.length, (index) {
                                    return _itemEditCard(
                                        context, _values.items[index]);
                                  }),
                                ),
                                Padding(
                                    padding: EdgeInsets.only(
                                        bottom:
                                            MediaQuery.sizeOf(context).height *
                                                0.05))
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
          ],
        ));
  }

  Future<dynamic> _addCategory(BuildContext context) {
    return showModalBottomSheet(
        isDismissible: false,
        useSafeArea: true,
        context: context,
        builder: (context) => AddCategoryWidget());
  }
  Future<dynamic> _addItem(BuildContext context) {
    return showModalBottomSheet(
            sheetAnimationStyle: AnimationStyle(
                curve: Curves.easeInOut, duration: Duration(milliseconds: 500)),
            isScrollControlled: true,
            isDismissible: false,
            backgroundColor: Colors.transparent,
            context: context,
            builder: (context) => AddItemWdget(
              categories: _values.categories,
            ),
          );
  }

  Widget _itemEditCard(BuildContext context, Item item) {
    return Dismissible(
      background: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppTheme.of(context).error,
        ),
        alignment: Alignment.centerLeft,
        child: Icon(
          Icons.delete_outline_rounded,
          color: AppTheme.of(context).info,
        ),
      ),
      secondaryBackground: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: AppTheme.of(context).secondaryText,
            borderRadius: BorderRadius.circular(10)),
        alignment: Alignment.centerRight,
        child: Icon(
          Icons.edit,
          color: AppTheme.of(context).info,
        ),
      ),
      onDismissed: (direction) {
        _values.items.removeWhere((i) => i.id == item.id);
        setState(() {});
      },
      confirmDismiss: (direction) async {
        if (direction == DismissDirection.startToEnd) {
          return await showModalBottomSheet(
              isDismissible: false,
              useSafeArea: true,
              context: context,
              builder: (context) {
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
                      border: Border.all(
                          color: const Color.fromARGB(22, 0, 0, 0), width: 2),
                      color: AppTheme.of(context).primaryBackground,
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(15))),
                  height: MediaQuery.sizeOf(context).height * 0.25,
                  child: Column(
                    spacing: 20,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Text(
                          Localization.of(context).getText('delete'),
                          style: AppTheme.of(context).labelLarge,
                        ),
                      ),
                      Text(
                        Localization.of(context).getText('delete msg'),
                        style: AppTheme.of(context).bodyLarge,
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
                                if (await ItemService.removeItem(
                                    Provider.of<AppStateNotifier>(context,
                                            listen: false)
                                        .getUserAuth,
                                    item.id!)) {
                                  Navigator.of(context).canPop()
                                      ? Navigator.of(context).pop(true)
                                      : null;
                                }
                              },
                              text: Localization.of(context).getText('confirm'),
                              icon: Icon(
                                Icons.delete_outline_rounded,
                                color: AppTheme.of(context).info,
                              ),
                              options: MyButtonOptions(
                                color: AppTheme.of(context).error,
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
              });
        } else {
          return await showModalBottomSheet(
            sheetAnimationStyle: AnimationStyle(
                curve: Curves.easeInOut, duration: Duration(milliseconds: 500)),
            isScrollControlled: true,
            isDismissible: false,
            backgroundColor: Colors.transparent,
            context: context,
            builder: (context) => EditItemWdget(
              categories: _values.categories,
              item: item,
            ),
          );
        }
      },
      key: ValueKey<int>(item.id!),
      child: Container(
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
        width: MediaQuery.sizeOf(context).width * 0.9,
        padding: EdgeInsets.all(5),
        child: Column(
          children: [
            Row(spacing: 30, children: [
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.all(5),
                child: Icon(
                  Icons.image_outlined,
                  size: 40,
                  color: AppTheme.of(context).primaryText,
                ),
              ),
              Container(
                  alignment: Alignment.center,
                  width: MediaQuery.sizeOf(context).width * 0.2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('No.${item.id!.toString()}',
                          style: AppTheme.of(context).bodySmall.copyWith(
                              color: AppTheme.of(context).secondaryText)),
                      Text(
                          '${item.price} ${Localization.of(context).getText('jod')}',
                          style: AppTheme.of(context).bodySmall),
                      Text(
                          '${item.category![0].toUpperCase()}${item.category!.substring(1)}',
                          style: AppTheme.of(context).bodySmall)
                    ],
                  )),
              Expanded(
                  child: Text('${item.name}:\n\n${item.description}',
                      style: AppTheme.of(context).bodySmall))
            ]),
          ],
        ),
      ),
    );
  }

  Widget _categoryEditButton(String category, BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        showModalBottomSheet(
            isDismissible: false,
            useSafeArea: true,
            context: context,
            builder: (context) {
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
                    border: Border.all(
                        color: const Color.fromARGB(22, 0, 0, 0), width: 2),
                    color: AppTheme.of(context).primaryBackground,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(15))),
                height: MediaQuery.sizeOf(context).height * 0.25,
                child: Column(
                  spacing: 20,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text(
                        Localization.of(context).getText('delete'),
                        style: AppTheme.of(context).labelLarge,
                      ),
                    ),
                    Text(
                      Localization.of(context).getText('delete category msg'),
                      style: AppTheme.of(context).bodyLarge,
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
                              if (await CategoryService.removeCategory(
                                  Provider.of<AppStateNotifier>(context,
                                          listen: false)
                                      .getUserAuth,
                                  category)) {
                                Navigator.of(context).canPop()
                                    ? Navigator.of(context).pop(true)
                                    : null;
                                setState(() {});
                              }
                            },
                            text: Localization.of(context).getText('confirm'),
                            icon: Icon(
                              Icons.delete_outline_rounded,
                              color: AppTheme.of(context).info,
                            ),
                            options: MyButtonOptions(
                              color: AppTheme.of(context).error,
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
            });
      },
      child: MyButtonWidget(
        onPressed: () async {
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
      ),
    );
  }
}
