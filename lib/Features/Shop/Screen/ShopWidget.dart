import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trks/Features/Features.dart';
import 'package:trks/Repositories/Repositories.dart';
import 'package:trks/Utilities/Utilities.dart';
import 'package:trks/Widget/Widgets.dart';

import '../../../Models/Models.dart';

class ShopWidget extends StatefulWidget {
  const ShopWidget({super.key});

  @override
  State<ShopWidget> createState() => _ShopWidgetState();
}

class _ShopWidgetState extends State<ShopWidget> {
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.

    return BlocProvider(
      create: (context)=>ShopCubit(),
      child: BlocConsumer<ShopCubit,ShopState>(
        listener: (context, state){},
        builder: (context, state) {
          if(state is ShopInitial){
            return Column(
              children: [
                getBanner(),
                getFilters(context, state),
                LayoutBuilder(builder: (context,size) {
                  return getListProducts(context, state, size);
                }),
                getNextPreviousWidget(context, state),
                Footer(),
              ],
            );
          }
          return Container();
        },
      ),
    );
  }

  Widget getBanner() {
    return SizedBox(
      width: 1100,
      child: AspectRatio(
        aspectRatio: 16/9,
        child: Padding(
          padding: const EdgeInsets.all(12.5),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15)
            ),
            clipBehavior: Clip.hardEdge,
            child: Image.asset(
              'assets/images/KS5.jpg',
              fit:BoxFit.fill
            ),
          ),
        ),
      ),
    );
  }

  Widget getFilters(BuildContext context, ShopInitial state) {
    return SizedBox(
      width: 1100,
      child: Padding(
        padding: const EdgeInsets.all(12.5),
        child: Row(
          children: [
            Row(
              children: [
                Text("Category:"),
                DropdownButton(
                  items: getDropDownCategoryItems(ItemCategoryRepository().listCategories),
                  value: ItemCategoryRepository().listCategories.firstWhere((x)=>x.key==state.categoryKey),
                  onChanged: (x) {
                    BlocProvider.of<ShopCubit>(context).onCategoryOrSortSelected(x.key,state.orderBy);
                  }
                ),
              ],
            ),
            Spacer(),
            Row(
              children: [
                Text("Sort by:"),
                DropdownButton(
                  hint: Text("Sort by"),
                  items: getDropDownSortItems(),
                  value: state.orderBy,
                  onChanged: (x) {
                    BlocProvider.of<ShopCubit>(context).onCategoryOrSortSelected(state.categoryKey,x);
                  }
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  List<DropdownMenuItem> getDropDownCategoryItems(List<ItemCategory> listItems){
    List<DropdownMenuItem<ItemCategory>> retVal=listItems.map((category) {
      return DropdownMenuItem(
        value: category,
        child: Text(category.description),
      );
    }).toList();
    return retVal;
  }

  List<DropdownMenuItem> getDropDownSortItems(){
    List<DropdownMenuItem<SortBy>> retVal=SortBy.values.map((sortBy) {
      return DropdownMenuItem(
        value: sortBy,
        child: Text(sortBy.name),
      );
    }).toList();
    return retVal;
  }

  Widget getListProducts(BuildContext context, ShopInitial state,BoxConstraints size){
    //No filters
    if(state.categoryKey==-1){
      return SizedBox(
        width: 1100,
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(12.5,5,5,5),
                child: Text(
                  "Memorabilia",
                  textAlign: TextAlign.start,
                  style: Styles.headerStyle,
                ),
              ),
            ),
            Wrap(
              spacing: 25,
              alignment: WrapAlignment.center,
              children: getProducts(context,true,state,size),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(12.5,5,5,5),
                child: Text(
                  "Merch",
                  textAlign: TextAlign.start,
                  style: Styles.headerStyle,
                ),
              ),
            ),
            Wrap(
              spacing: 25,
              alignment: WrapAlignment.center,
              children: getProducts(context,true,state,size),
            ),
          ],
        ),
      );
    }
    return SizedBox(
      width: 1100,
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(12.5,5,5,5),
              child: Text(
                ItemCategoryRepository().listCategories.firstWhere((x)=>x.key==state.categoryKey).description,
                textAlign: TextAlign.start,
                style: Styles.headerStyle,
              ),
            ),
          ),
          Wrap(
            spacing: 25,
            alignment: WrapAlignment.center,
            children: getProducts(context,false,state,size),
          ),
        ],
      ),
    );
  }

  List<Widget> getProducts(BuildContext context, bool isMemorabilia,ShopInitial state,BoxConstraints size){
    List<Widget> retVal=[];
    for(ShopItem item in isMemorabilia?state.listMemorabiliaItems:state.listMerchItems.where((x)=>state.categoryKey==-1 || x.categoryKey.contains(state.categoryKey))){
      retVal.add(
        ShopItemWidget(shopItem: item, constraints: size)
      );
    }
    return retVal;
  }

  Widget getNextPreviousWidget(BuildContext context, ShopInitial state){
    if(state.totalIndexes<=1){
      return Container();//Return empty container since no content.
    }
    return Center(
      child: InkWell(
        onTap: () {

        },
        child: Text(
            "View More",
            style: TextStyle(color: CustomColors.accentPink)
        ),
      ),
    );
  }

  Widget getNextPreviousWidget1(BuildContext context, ShopInitial state){
    if(state.totalIndexes<=1){
      return Container();//Return empty container since no content.
    }
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 25,
      children: [
        InkWell(
          onTap: () {

          },
          child: Text(
            "<- Prev",
            style: TextStyle(color: CustomColors.accentPink)
          ),
        ),
        ...getIndexes(context,state),
        InkWell(
          onTap: () {

          },
          child: Text(
              "Next ->",
              style: TextStyle(color: CustomColors.accentPink)
          ),
        ),
      ],
    );
  }

  List<Widget> getIndexes(BuildContext context, ShopInitial state){
    List<Widget> retVal=[];
    for(int i=0; i<state.totalIndexes;i++){
      retVal.add(
        InkWell(
          child: Text(
            i.toString(),
            style: TextStyle(color: CustomColors.accentPink),
          ),
        )
      );
    }
    return retVal;
  }
}