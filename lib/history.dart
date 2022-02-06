import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'list.dart';

class HistoryPage extends StatefulWidget {
  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: false, //iOS
        forceWebView: true, //Android
        enableJavaScript: true, //Android
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(20.0, 100.0, 20.0, 20.0),
              child: const Text(
                'Scanning History',
                style: TextStyle(
                    fontFamily: 'Product Sans',
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                    color: Color(0xFF1E1E1E)),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(50.0, 0.0, 50.0, 30.0),
              child: const Text(
                'QR-Scanner will keep your last scan history\nClick on link icon to launch the URL',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Product Sans',
                  height: 1.4,
                  color: Color(0xFFA0A0A0),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SizedBox(
                    height: 50.0,
                    width: 110.0,
                    child: FloatingActionButton.extended(
                      onPressed: () {},
                      backgroundColor: const Color(0XFFFF7D54),
                      label: const Text(
                        "Today",
                        style: TextStyle(
                          fontFamily: 'Product Sans',
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 15.0,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SizedBox(
                    height: 50.0,
                    width: 110.0,
                    child: FloatingActionButton.extended(
                      onPressed: () {},
                      backgroundColor: Colors.grey[100],
                      label: const Text(
                        "All",
                        style: TextStyle(
                          fontFamily: 'Product Sans',
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 15.0,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: urls.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding:
                          const EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 10.0),
                      child: SizedBox(
                        height: 80,
                        child: ListTile(
                          shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0)),
                          ),
                          tileColor: Colors.grey[100],
                          title: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: Expanded(
                                child: Row(
                                  children: [
                                    IconButton(
                                      onPressed: () => _launchURL(urls[index]),
                                      icon: const Icon(
                                        Icons.link,
                                        size: 40.0,
                                        color: Color(0xFFFF7D54),
                                      ),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Text(
                                          urls[index],
                                          style: const TextStyle(
                                            fontFamily: 'Product Sans',
                                            fontSize: 15,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
