import 'package:assunta/classes/cart_class.dart';
import 'package:assunta/pages/adds/rounded_title.dart';
import 'package:flutter/material.dart';
import 'package:assunta/classes/food_class.dart';
import 'package:provider/provider.dart';
import 'package:assunta/pages/adds/modal_column.dart';
import 'dart:math' as math;

class FoodPage extends StatelessWidget {
  SliverPersistentHeader makeHeader(String headerText, BuildContext context) {
    return SliverPersistentHeader(
      floating: false,
      pinned: false,
      delegate: _SliverAppBarDelegate(
        minHeight: 0,
        maxHeight: 50.0,
        child: Center(
          child: Text(
            headerText,
            style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var list = Provider.of<List<Food>>(context);
    for (var e in list )
      print(e.name);
    return CustomScrollView(
      slivers: <Widget>[
        SliverList(
          delegate: SliverChildListDelegate(
              [RoundedTitle(title: "Sagra di Santa Maria del Campo")]),
        ),

        makeHeader("Piatti Caldi", context),
        SliverList(
          delegate: SliverChildListDelegate(_makeList(Provider.of<List<Food>>(context), 0)),
        ),
        makeHeader("Bibite", context),
        SliverList(
          delegate: SliverChildListDelegate(_makeList(Provider.of<List<Food>>(context), 1)),
        ),

      ],
    );
  }
}

class MyCard extends StatelessWidget {
  final Food dish;

  MyCard({this.dish});
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(dish.name),
      subtitle: Text(dish.description),
      onTap: () {
        _showDishModal(context, dish);
      },
      enabled: dish.available,
      trailing: Text(
        "€ ${dish.price.toStringAsFixed(2)}",
        style: TextStyle(color: Colors.green),
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate({
    @required this.minHeight,
    @required this.maxHeight,
    @required this.child,
  });
  final double minHeight;
  final double maxHeight;
  final Widget child;
  @override
  double get minExtent => minHeight;
  @override
  double get maxExtent => math.max(maxHeight, minHeight);
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}

void _showDishModal(context, Food dish) {
  showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(15),
              topRight: const Radius.circular(15))),
      isDismissible: true,
      builder: (BuildContext bc) {
        var cart = Provider.of<Cart>(context);
        return ModalColumn(dish: dish, quantity: cart.getQuantity(dish));
      });
}

class CustomShapeBorder extends ContinuousRectangleBorder {
  @override
  Path getOuterPath(Rect rect, {TextDirection textDirection}) {
    Path path = Path();
    path.lineTo(0, rect.height - 80);
    path.quadraticBezierTo(
        rect.width / 2, rect.height, rect.width, rect.height - 80);
    path.lineTo(rect.width, 0);
    path.close();

    return path;
  }
}

List _makeList(List<Food> list, int type) {
  List<Widget> retList = [];
  for (int i = 0; i < list.length; ++i)
    if (list[i].available)
      if(list[i].type == type)
        retList.add(Column(
          children: <Widget>[
            MyCard(dish: list[i]),
            if (i != list.length - 1)
              Divider(
                thickness: 1,
                indent: 20,
                endIndent: 20,
              )
          ],
        ));
  return retList;
}
