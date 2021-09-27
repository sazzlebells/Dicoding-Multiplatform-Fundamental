import 'package:flutter/material.dart';
import 'package:restaurant_app/restaurant.dart';

class ExpandCard extends StatefulWidget {
  ExpandCard({required this.menu});
  List<Menu>? menu;

  @override
  _ExpandCardState createState() => _ExpandCardState();
}

class _ExpandCardState extends State<ExpandCard> {
  @override
  Widget build(BuildContext context) {
    return _menuList();
  }

  Widget _menuList() {
    return Container(
        height: 180,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: widget.menu!.length,
            itemBuilder: (context, index) {
              return Card(
                elevation: 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 150,
                      height: 110,
                      child: Image.network(
                        widget.menu![index].imageUrl.toString(),
                        fit: BoxFit.cover,
                      ),
                    ),
                    Text("${widget.menu![index].menu}"),
                    Text("Rp${widget.menu![index].price}")
                  ],
                ),
              );
            }));
  }
}
