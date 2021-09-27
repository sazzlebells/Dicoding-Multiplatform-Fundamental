import 'package:flutter/material.dart';
import 'package:restaurant_app/common/styles.dart';
import 'package:restaurant_app/detail.dart';
import 'package:restaurant_app/restaurant.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);
  static const routeName = "/home";

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool iconStatus = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cBackground,
      appBar: AppBar(
        title: Text("Wisata Kuliner Lampung"),
        actions: [
          IconButton(
              icon: Icon(iconStatus ? Icons.grid_view : Icons.list_rounded),
              onPressed: () {
                setState(() {
                  iconStatus = !iconStatus;
                });
              })
        ],
      ),
      body: FutureBuilder<String>(
          future: DefaultAssetBundle.of(context)
              .loadString('assets/restaurants.json'),
          builder: (context, snapshot) {
            final List<Restaurant> restaurants =
                parseRestaurants(snapshot.data);
            return iconStatus ? _bodyGrid(restaurants) : _bodyList(restaurants);
          }),
    );
  }

  Widget _bodyList(List<Restaurant> data) {
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                backgroundColor: secondaryColor,
                content: Text(data[index].name.toString())));

            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) =>
                    DetailPage(detail: data[index])));
          },
          child: Card(
            elevation: 8,
            margin: const EdgeInsets.fromLTRB(8, 4, 8, 4),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    margin: const EdgeInsets.all(8),
                    height: 100,
                    child: Hero(
                      tag: data[index].imageUrl.toString(),
                      child: Image.asset(
                        data[index].imageUrl.toString(),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Expanded(
                    flex: 3,
                    child: Container(
                      height: 100,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(data[index].name.toString(),
                              style: myTextTheme.bodyText1),
                          Wrap(
                            children: [
                              const Icon(
                                Icons.location_on,
                                size: 20,
                                color: Colors.red,
                              ),
                              Text(data[index].location.toString()),
                            ],
                          ),
                          Wrap(
                            children: [
                              const Icon(
                                Icons.star,
                                size: 20,
                                color: Colors.yellow,
                              ),
                              Text(data[index].rating.toString()),
                            ],
                          )
                        ],
                      ),
                    ))
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _bodyGrid(List<Restaurant> data) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 1,
          crossAxisCount: 2,
          mainAxisSpacing: 4,
        ),
        itemCount: data.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) =>
                      DetailPage(detail: data[index])));
            },
            child: Card(
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Image.asset(
                      data[index].imageUrl.toString(),
                      fit: BoxFit.cover,
                      height: 100,
                    ),
                  ),
                  Text(
                    data[index].name.toString(),
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    data[index].location.toString(),
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
