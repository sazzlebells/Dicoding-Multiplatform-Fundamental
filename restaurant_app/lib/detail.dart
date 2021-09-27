import 'dart:async';
import 'package:flutter/material.dart';
import 'package:restaurant_app/common/styles.dart';
import 'package:restaurant_app/menu.dart';
import 'package:restaurant_app/restaurant.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({Key? key, required this.detail}) : super(key: key);
  final Restaurant detail;
  static const routeName = "/detail";

  Future<void> _bukaMap(BuildContext context, String url) async {
    try {
      await launch(
        url,
        forceSafariVC: false,
        forceWebView: false,
        headers: <String, String>{'my_header_key': 'my_header_value'},
      );
    } catch (e) {
      print(e);
      _showSNackbar(context, "Tidak bisa membuka tautan");
    }
  }

  Future<void> _call(String url, BuildContext context) async {
    try {
      await launch(url);
    } catch (e) {
      print(e);
      _showSNackbar(context, "Tidak bisa membuat telepon");
    }
  }

  _showSNackbar(BuildContext context, String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
          headerSliverBuilder: (context, isScrolled) {
            return [
              SliverAppBar(
                expandedHeight: 200,
                pinned: true,
                automaticallyImplyLeading: false,
                flexibleSpace: FlexibleSpaceBar(
                  title: Text(
                    detail.name.toString(),
                    overflow: TextOverflow.ellipsis,
                  ),
                  titlePadding: const EdgeInsets.only(left: 16, bottom: 16),
                  background: Hero(
                    tag: detail.imageUrl.toString(),
                    child: Image.asset(
                      detail.imageUrl.toString(),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ];
          },
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.yellow, size: 35),
                      Text(
                        detail.rating.toString(),
                        style: myTextTheme.headline5,
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        size: 27,
                        color: Colors.red,
                      ),
                      Flexible(
                        child: Text(
                          "${detail.address}, ${detail.location}",
                          style: myTextTheme.bodyText1,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Text("Deskripsi", style: myTextTheme.headline5),
                  SizedBox(height: 15),
                  Text(
                    "${detail.name} yang berlokasi di ${detail.location} ini menjadi objek wisata kuliner yang selalu ramai oleh pengunjung dari luar kota. Selain karena letaknya yang strategis, makanan yang disajikan juga memiliki rasa yang enak. Harga yang ditawarkan juga masih terjangkau. Bila ingin reservasi bisa langsung menghubungi melalui telepon.",
                    softWrap: true,
                    textAlign: TextAlign.justify,
                  ),
                  SizedBox(height: 20),
                  Text("Menu", style: myTextTheme.headline5),
                  SizedBox(height: 15),
                  ExpandCard(menu: detail.menus),
                  SizedBox(height: 20),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    detail.phone == ""
                        ? Container()
                        : ElevatedButton.icon(
                            onPressed: () =>
                                _call("tel:${detail.phone}", context),
                            icon: Icon(Icons.phone),
                            label: Text("Reservasi")),
                    detail.phone == "" ? Container() : SizedBox(width: 30),
                    ElevatedButton.icon(
                        onPressed: () =>
                            _bukaMap(context, detail.mapUrl.toString()),
                        icon: Icon(Icons.location_pin),
                        label: Text("Lihat Peta")),
                  ]),
                ],
              ),
            ),
          )),
    );
  }
}
